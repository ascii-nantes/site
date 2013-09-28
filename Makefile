all: build

build: site
	./site build

site: site.hs
	ghc --make site.hs
	./site clean

new:
	@./new_event.sh

publish: build
	rsync -az --delete _site/ mog@88.191.117.112:www/blog

clean:
	test -f site && ./site clean || true
	rm -f site site.hi site.o

.PHONY: all build new publish clean
