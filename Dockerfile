FROM ubuntu:14.04

MAINTAINER Renoir Boulanger <hello@renoirboulanger.com>

LABEL Description="This is a base image to run Mozilla Firefox Accounts. It uses has salt-minion configured master and configuration less (i.e. no /srv/salt), ready to be used as a base image with your own states."

ENV DEBIAN_FRONTEND noninteractive
ENV ROLE base

COPY salt /srv/salt
COPY pillar /srv/pillar

VOLUME ["/usr/src"]

RUN    apt-get install -yqq \
         git \
         software-properties-common \
    && add-apt-repository -y ppa:saltstack/salt \
    && apt-get update \
    && apt-get -yqq install \
         python-git \
         salt-minion \
    && apt-get -yqq upgrade \
    && apt-get -yqq autoremove \
    && mkdir -p /var/cache/pkgs \
    && printf "failhard: True\nfile_client: local\nstate_verbose: True\nstartup_states: highstate" >> /etc/salt/minion.d/container.conf \
    && salt-call --local state.highstate \
    && rm -rf /srv/salt /srv/pillar

# We delete all in base, but we'll copy them back on build later.
ONBUILD COPY salt /srv/salt
ONBUILD COPY pillar /srv/pillar
ONBUILD RUN     printf "role: ${ROLE}\n" >> /etc/salt/grains \
            &&  salt-call state.highstate

#
# Set in place onbuild to handle web app specificities
#
# See also:
# * http://docs.docker.com/reference/builder/#onbuild
# * [**Ian Miell** talk at *London DevOps #6.2* - Docker, Package Management and Building from Source](https://www.youtube.com/watch?v=UGp16yvSrFE)
