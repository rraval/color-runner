CHROME := $(shell which chromium)

build_coffee := $(patsubst src/%.coffee,build/%.js,$(shell find src -name *.coffee -type f))
build_yaml := $(patsubst src/%.yaml,build/%.json,$(shell find src -name *.yaml -type f))
build_icons := $(addprefix build/,icon16.png icon32.png icon128.png)

.PHONY: all release zip clean

all: build $(build_coffee) $(build_yaml) $(build_icons) | build

$(build_coffee) : build/%.js : src/%.coffee
	coffee --compile --stdio < $^ > $@

$(build_yaml) : build/%.json : src/%.yaml
	python yaml2json.py < $^ > $@

build/icon16.png: icon.svg
	inkscape -f $^ -e $@ -d 11.25

build/icon32.png: icon.svg
	inkscape -f $^ -e $@ -d 22.5

build/icon128.png: icon.svg
	inkscape -f $^ -e $@ -d 90

build:
	mkdir -p build

zip: all
	zip -r color-runner-`git rev-parse --short HEAD`.zip build

clean:
	rm -rf build
	rm -f color-runner-*.zip
