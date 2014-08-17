CHROME := $(shell which chromium)

build_coffee := $(patsubst src/%.coffee,build/%.js,$(shell find src -name *.coffee -type f))
build_yaml := $(patsubst src/%.yaml,build/%.json,$(shell find src -name *.yaml -type f))

.PHONY: all release zip clean

all: build $(build_coffee) $(build_yaml) | build

$(build_coffee) : build/%.js : src/%.coffee
	coffee --compile --stdio < $^ > $@

$(build_yaml) : build/%.json : src/%.yaml
	python2 yaml2json.py < $^ > $@

build:
	mkdir -p build

zip: all
	zip -r color-runner-`git rev-parse --short HEAD`.zip build

clean:
	rm -rf build
	rm -f color-runner-*.zip
