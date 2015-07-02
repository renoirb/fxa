FROM ubuntu:14.04
#FROM debian:wheezy

MAINTAINER Renoir Boulanger <hello@renoirboulanger.com>

LABEL Description="This is a base image to run Mozilla Firefox Accounts. It uses has salt-minion configured master and configuration less (i.e. no /srv/salt), ready to be used as a base image with your own states."

#ref: http://docs.saltstack.com/en/latest/topics/installation/ubuntu.html
ENV SALT_KEY  http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0x4759FA960E27C0A6
ENV SALT_REPO 'http://ppa.launchpad.net/saltstack/salt/ubuntu trusty'

#ref: http://docs.saltstack.com/en/latest/topics/installation/debian.html
#ENV SALT_KEY  http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key
#ENV SALT_REPO 'http://debian.saltstack.com/debian wheezy-saltstack'

COPY salt /srv/salt
COPY pillar /srv/pillar
COPY scripts /srv/scripts

RUN    DEBIAN_FRONTEND="noninteractive" \
    && apt-get install -yqq wget \
    && wget -q -O- ${SALT_KEY} | apt-key add - \
    && printf "deb ${SALT_REPO} main\n" > /etc/apt/sources.list.d/saltstack.list \
    && apt-get update \
    && apt-get -yqq install salt-minion \
    && apt-get -yqq upgrade \
    && apt-get -yqq autoremove \
    && printf "failhard: True\nfile_client: local\nstate_verbose: True\nstartup_states: highstate" >> /etc/salt/minion.d/container.conf \
    && salt-call --local --id=baseimage state.highstate \
    && rm -rf /usr/src

#
# Set in place onbuild to handle web app specificities
#
# See also:
# * http://docs.docker.com/reference/builder/#onbuild
# * [**Ian Miell** talk at *London DevOps #6.2* - Docker, Package Management and Building from Source](https://www.youtube.com/watch?v=UGp16yvSrFE)
