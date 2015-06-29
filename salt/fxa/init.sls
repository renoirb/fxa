{% set servers = salt['pillar.get']('fxa', {'app':[]}) %}

Ensure common deps are installed:
  pkg.installed:
    - pkgs:
      - build-essential
      - libgmp3-dev
      - graphicsmagick

/srv/webapps/servers.json:
  file.managed:
    - contents: |
        {{ servers|json }}
