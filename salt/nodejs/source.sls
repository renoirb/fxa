{% set node = pillar.get('nodejs', {}) -%}
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
  cmd.wait:
    - cwd: /usr/src/node-v{{ version }}
    - names:
      - ./configure
      - make --jobs={{ make_jobs }}
      - checkinstall --install=yes --pkgname=nodejs --pkgversion "{{ version }}" --default
  file.symlink:
    - name: /usr/bin/nodejs
    - target: /usr/local/bin/node

{% include 'nodejs/source_npm.sls' %}

