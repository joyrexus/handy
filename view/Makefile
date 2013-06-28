DEPLOY_DIR = $(WEBDOCS)/SILC/demo/hanoi

.PHONY: build deploy

SOURCES := $(wildcard src/*.coffee)

build: $(SOURCES)
	coffee -co lib/ src/
	@echo "coffee sources were compiled"

FILES = index.html lib data

deploy: build $(FILES)
	rsync -r --exclude=".git" $(FILES) $(DEPLOY_DIR)
	@echo "files copied to $(DEPLOY_DIR)"

