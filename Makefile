SHELL := bash

default: docker-build

docker-build:
		docker build -t fxa/base .

docker-run:
		docker run -it --rm fxa/base

