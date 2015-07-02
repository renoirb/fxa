include:
  - .source

Install npm packages:
  cmd.run:
    - cwd: /srv/webapps
    - names:
      - test -f /usr/local/bin/pm2 || /usr/local/bin/npm install -g pm2
      - test -f /usr/local/bin/grunt || /usr/local/bin/npm install -g grunt-cli
      - test -f /usr/local/bin/bower || /usr/local/bin/npm install -g bower
      - /usr/local/bin/npm i -g intel@0.5.2
      - /usr/local/bin/npm i -g depd@1.0.0

