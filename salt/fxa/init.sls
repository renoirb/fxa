{% set servers = salt['pillar.get']('fxa', {'app':[]}) %}

Ensure common deps are installed:
  pkg.installed:
    - pkgs:
      - build-essential
      - libgmp3-dev
      - graphicsmagick

# This will have to be reworked to be usable in
# CentOS. As per syncserver requests it.
Ensure python modules are installed:
  pkg.installed:
    - pkgs:
      - python-pip
      - python-virtualenv
      - python2.7-dev

/srv/webapps/servers.json:
  file.managed:
    - contents: |
        {{ servers|json }}
