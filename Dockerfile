FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

COPY salt /srv/salt
COPY pillar /srv/pillar

RUN apt-get install -y wget && \
    apt-get remove --purge -y openssh-server && \
    echo 'deb http://ppa.launchpad.net/saltstack/salt/ubuntu trusty main' > /etc/apt/sources.list.d/saltstack.list && \
    wget -q -O- "http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0x4759FA960E27C0A6" | apt-key add - && \
    apt-get update && \
    apt-get install -y salt-minion && \
    apt-get -y upgrade ; apt-get -y autoremove && \
    salt-call --local --state-output=terse -l quiet --out=yaml --no-color state.highstate

