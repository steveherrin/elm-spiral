ELMMAKE=elm-make

all: index.html

index.html:
	$(ELMMAKE) src/Spiral.elm

clean:
	rm index.html


.PHONY: clean
