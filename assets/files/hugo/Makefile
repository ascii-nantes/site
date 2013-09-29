markdown = $(shell ls *.md)
html = $(markdown:.md=.html)
onstaged = $(html:%=onstage.html\#%)

all: $(html)

%.html: %.md
	~/.cabal/bin/pandoc \
		-Ssf markdown \
		-t dzslides \
		--slide-level 2 \
		--template template.html \
		$< \
		-o $@
	touch onstage.html

view: $(html)
	firefox $(onstaged)
	while :; do inotifywait -qqe modify $(markdown); make; done

.PHONY: all view
