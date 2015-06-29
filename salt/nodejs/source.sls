{% set node = pillar.get('nodejs', {}) -%}
{% set npm_version = node.get('npm:version', '2.4.1') %}
{% set version = node.get('version', '0.10.39') -%}
{% set checksum = node.get('checksum', 'b53d33b5e1b980b2fe9009fec810187eaa6b8144') -%}
{% set make_jobs = node.get('make_jobs', '1') -%}
{% set pkg_name = 'node-v' ~ version ~ '.tar.gz' -%}

git_packages:
  pkg.installed:
    - pkgs:
      - libssl-dev
      - git
      - pkg-config
      - build-essential
      - curl
      - gcc
      - g++
      - checkinstall

Download {{ pkg_name }}:
  archive.extracted:
    - name: /usr/src/
    - source: https://nodejs.org/dist/v{{ version }}/{{ pkg_name }}
    - source_hash: sha1={{ checksum }}
    - archive_format: tar
    - if_missing: /usr/src/node-v{{ version }}

Build {{ pkg_name }}:
  cmd.wait:
    - cwd: /usr/src/node-v{{ version }}
    - names:
      - ./configure
      - make --jobs={{ make_jobs }}
      - checkinstall --install=yes --pkgname=nodejs --pkgversion "{{ version }}" --default
    - watch:
      - archive: Download {{ pkg_name }}
  file.symlink:
    - name: /usr/bin/nodejs
    - target: /usr/local/bin/node

Upgrade npm to {{ npm_version }}:
  cmd.wait:
    - names:
      - npm install -g npm@{{ npm_version }}
    - watch:
      - cmd: Build {{ pkg_name }}

