GOPATH=$(shell pwd)/vendor:$(shell pwd)
GOBIN=$(shell pwd)/bin
GOFILES=$(wildcard *.go)
GONAME=$(shell basename "$(PWD)")
PID=/tmp/go-$(GONAME).pid

all: watch

build:
	@echo "Building $(GOFILES) to ./bin"
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go build -o bin/$(GONAME) $(GOFILES)

get:
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go get .

install:
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go install $(GOFILES)

run:
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go run $(GOFILES)

watch: build stop start
	@fswatch -o *.go src/**/*.go | xargs -n1 -I{}  make restart || make stop

restart: stop clean build start

start:
	@echo "Starting bin/$(GONAME)"
	@./bin/$(GONAME) & echo $$! > $(PID)

stop:
	@echo "Stopping bin/$(GONAME)"
	@-kill `cat $(PID)` || true

build-ui:
	@echo "Building UI"
	@cd ui && elm-make src/Main.elm --output public/bundle.js
	@reload-browser chromium

watch-ui:
	@echo "Watching changes on UI"
	@find ui/src/. -name '*.elm' | entr make build-ui

clean:
	@echo "Cleaning"
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go clean

.PHONY: build get install run watch start stop restart clean
