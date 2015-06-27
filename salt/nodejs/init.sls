{% set pillar_get = salt['pillar.get'] -%}
include:
{%- if pillar_get('nodejs:install_from_source') %}
  - .source
{%- else %}
  - .pkg
{%- endif %}
