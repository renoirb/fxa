SHELL := bash

default: base

src:
		. scripts/clone_all.sh

base:
		docker build --rm --no-cache=true -t fxa/base .

run: src
		docker run -it --rm -v "$(CURDIR)/src":/srv/webapps fxa/base

