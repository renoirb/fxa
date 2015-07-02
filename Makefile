SHELL := bash

default: base

src:
		. scripts/clone_all.sh

base:
		docker build --rm --no-cache=true -t fxa/base .

run: src
		docker run -d --name redis redis
		docker run -it --rm -p 3030:3030 -p 1114:1114 \
												-p 10140:10140 -p 9010:9010 \
												-p 9011:9011 -p 1111:1111 \
												-p 1112:1112 -p 1113:1113 \
												-p 8080:8080 -p 10139:10139 \
												-p 10137:10137 -p 5050:5050 \
												-p 9000:9000 \
												-v "$(CURDIR)/src":/srv/webapps \
												--link redis:redis \
												fxa/base

