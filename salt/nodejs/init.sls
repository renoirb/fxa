include:
  - .source

Install npm packages:
  cmd.run:
    - cwd: /srv/webapps
    - names:
      - /usr/local/bin/npm install -g pm2
      - /usr/local/bin/npm install -g grunt-cli


