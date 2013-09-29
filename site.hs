--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid ( (<>) )
import           Hakyll
import           System.FilePath (takeBaseName)


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "assets/ico/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "assets/img/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "assets/js/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "files/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "assets/css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "static/*.md" $ do
        route   $ gsubRoute "static/" (const "") `composeRoutes` setExtension "html"
        compile $ do
            path <- getResourceFilePath
            let baseName    = takeBaseName path
                staticCtx     =
                    constField (baseName ++ "Active") "true"  <>
                    defaultContext
            pandocCompiler
                >>= loadAndApplyTemplate "templates/container.html" staticCtx
                >>= loadAndApplyTemplate "templates/structure.html" staticCtx
                >>= relativizeUrls

    match "static/*.html" $ do
        route   $ gsubRoute "static/" (const "")
        compile $ do
            path <- getResourceFilePath
            let baseName  = takeBaseName path
                staticCtx = constField (baseName ++ "Active") "true" <>
                                defaultContext
            getResourceBody
                >>= loadAndApplyTemplate "templates/structure.html" staticCtx
                >>= relativizeUrls

    match "events/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
                >>= saveSnapshot "content"
                >>= loadAndApplyTemplate "templates/event.html"     eventCtx
                >>= loadAndApplyTemplate "templates/container.html" eventCtx
                >>= loadAndApplyTemplate "templates/structure.html" eventCtx
                >>= relativizeUrls

    create ["events.html"] $ do
        route idRoute
        compile $ do
            events <- recentFirst =<< loadAll "events/*"
            let eventsCtx =
                    listField  "events" eventCtx (return events) <>
                    constField "eventsActive" "true"             <>
                    constField "title" "Confs & Events"          <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/events-list.html"
                        (teaserField "teaser" "content" <> eventsCtx)
                >>= loadAndApplyTemplate "templates/container.html" eventsCtx
                >>= loadAndApplyTemplate "templates/structure.html" eventsCtx
                >>= relativizeUrls

    create ["atom.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = eventCtx <> bodyField "description"
            posts <- fmap (take 10) . recentFirst =<<
                loadAllSnapshots "events/*" "content"
            renderAtom feedConfiguration feedCtx posts

    create ["rss.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = eventCtx <> bodyField "description"
            posts <- fmap (take 10) . recentFirst =<<
                loadAllSnapshots "events/*" "content"
            renderRss feedConfiguration feedCtx posts

    match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------
eventCtx :: Context String
eventCtx = dateField "date" "%d/%m/%Y" <> defaultContext

feedConfiguration :: FeedConfiguration
feedConfiguration = FeedConfiguration
    { feedTitle       = "ASCII website"
    , feedDescription = "Confs & events feed."
    , feedAuthorName  = "ASCII"
    , feedAuthorEmail = "ascii.asso@gmail.com"
    , feedRoot        = "http://ascii.univ-nantes.fr"
    }
