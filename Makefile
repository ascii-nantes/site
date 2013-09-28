SHELL=/bin/bash

all: build

build: site
	./site build

site: site.hs
	ghc --make site.hs
	./site clean

new:
	@./new_event.sh

publish: build
	sudo openconnect -b https://nomade.etu.univ-nantes.fr
	expect <(cat \
		publish/header.sftp \
		publish/password.sftp \
		publish/footer.sftp)
	sudo pkill openconnect

clean:
	@test -f site && ./site clean || true
	rm -f site site.hi site.o

.PHONY: all build new publish clean
