---
title: De bons outils pour bosser en Informatique
author: Hugo Mougard
---

Jeudi 29 dernier, nous avons organisé une conférence pour présenter
des outils classiques en gestion de projets Informatique. Le but était
de donner aux étudiants les moyens de bien bosser, avant les cours de
Master qui les introduisent.

<div></div><!--more-->

## Introduction

Les sujets abordés étaient :

- [Git][git], pour correctement gérer son code, seul
  et à plusieurs ;

- [Maven][mvn], pour construire et déployer des projets Java, et ses
  variantes pour les
  [autres dialectes](https://en.wikipedia.org/wiki/List_of_JVM_languages)
  de la *Java Virtual Machine* ([Gradle][gradle] pour
  [Groovy][groovy], [sbt][sbt] pour [Scala][scala], [Leiningen][lein]
  pour [Clojure][cloj], etc). Seul Maven a été présenté, mais les
  autres systèmes sont basés sur lui et lui sont très similaires.

- les [Autotools][autotools], ancêtres de Maven et des systèmes de
  build modernes, toujours utilisés pour gérer des projets C/C++.

## Les slides

Les slides utilisées sont disponibles sur
[un des dépôt github][github] de l'ascii.

## Les tutoriels

Pour accès rapide, ci-après les tutoriels conseillés pendant la conf :

### Maven

Les [guides officiels][mvn-guide] sont une bonne source d'info.

### Git

- [Livre/tutoriel sur Git][git-book], chapitres 1 et
  2 ;

- [Tutoriel interactif][try-git]

### Les Autotools

La meilleure ressource disponible à l'heure actuelle est éditée par un
développeur Gentoo, Flameeyes, et est disponible
[sur son site][flameeyes-site]. Pour une introduction, demander à
quelqu'un qui connaît ;(

[flameeyes-site]: https://www.flameeyes.eu/autotools-mythbuster/

[git]: http://git-scm.com/

[git-book]: http://git-scm.com/book/

[try-git]: http://try.github.io/

[mvn]: https://maven.apache.org/

[mvn-guide]: https://maven.apache.org/guides/

[lein]: https://github.com/technomancy/leiningen

[cloj]: http://clojure.org/

[sbt]: http://www.scala-sbt.org/

[scala]: http://www.scala-lang.org/

[gradle]: http://www.gradle.org/

[groovy]: http://groovy.codehaus.org/

[autotools]: https://www.gnu.org/software/automake/manual/html_node/index.html

[github]: https://github.com/ascii-nantes/conf-tooling
