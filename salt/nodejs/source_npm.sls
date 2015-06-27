{%- from "nodejs/map.jinja" import npm_bin, npm_prefix with context %}
{% set nodejs = salt['pillar.get']('nodejs', {}) -%}
{% set npm_user = nodejs.get('npm:user', 'root') -%}
{% set npm_group = nodejs.get('npm:group', 'root') -%}
{% set npm_version = nodejs.get('npm:version', '2.4.1') -%}
{% set npm_sha1sum = nodejs.get('npm:sha1sum', '0212e03b8ade89bec6a59fc75bc2aa03f94f0f53') -%}
{% set pkg_name = 'npm-{0}.tgz'.format(npm_version) %}
{% set local_tgz = npm_prefix ~ '/' ~ pkg_name -%}

Download {{ pkg_name }}:
  archive.extracted:
    - name: /usr/src/npm
    - source: http://registry.npmjs.org/npm/-/{{ pkg_name }}
    - source_hash: sha1={{ npm_sha1sum }}
    - archive_format: tar
    - archive_user: {{ npm_user }}
    - if_missing: /usr/src/npm/package
  file.directory:
    - name: /usr/src/npm
    - user: {{ npm_user }}
    - group: {{ npm_group }}
    - dir_mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
  cmd.wait:
    - cwd: /usr/src/npm/package
    - user: {{ npm_user }}
    - env:
      - npm_config_prefix: {{ npm_prefix }}
    - names:
      - './configure --prefix={{ npm_prefix }} && node cli.js install marked && make install'
    - unless: test -f {{ npm_bin }}
    - creates: {{ npm_bin }}

