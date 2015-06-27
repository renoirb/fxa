SHELL := bash

default: base

base:
		docker build --rm --no-cache=true -t fxa/base .

run:
		docker run -it --rm -v "$(CURDIR)/src":/srv/webapps -v "$(CURDIR)/pkgs":/var/cache/pkgs fxa/base

