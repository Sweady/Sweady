VERSION := $(shell git describe --tags)
.DEFAULT_GOAL := help

build:	 		build				## Build
server:			server				## Server
deploy:			deploy				## Deploy

build:
	hugo

build-server:
	hugo server

deploy: deps
	sh ./.script/deploy.sh

deps:
	rm -rf deploy public


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf 	"\033[36m%-30s\033[0m %s\n", $$1, $$2}'
