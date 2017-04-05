VERSION := $(shell git describe --tags)
.DEFAULT_GOAL := help

build:	 		build				## Build for MacOS
build-all:		build-all			## Build for all plateform
fmt:			fmt					## Clear indentation in code

build: deps
	go build -o bin/sweady-darwin

build-all: deps
	gox -ldflags "-X main.version=${VERSION}" -os="linux darwin windows" -arch="amd64 386" -output="bin/{{.OS}}-{{.Arch}}/sweady" .

fmt:
	go fmt ./...

deps:
	export AUTO_GOPATH=1
	go get github.com/mitchellh/gox
	glide install
	rm -rf bin


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf 	"\033[36m%-30s\033[0m %s\n", $$1, $$2}'
