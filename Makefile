ELMMAKE=elm-make

all: index.html

index.html: src
	$(ELMMAKE) src/Spiral.elm

clean:
	rm index.html


.PHONY: clean
