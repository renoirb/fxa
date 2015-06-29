SHELL := bash

default: base

deps:
		. scripts/clone_all.sh

base:
		docker build --rm --no-cache=true -t fxa/base .

run:
		docker run -it --rm -v "$(CURDIR)/src":/srv/webapps fxa/base

