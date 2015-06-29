fxa:
  apps:
  - name: auth-server mailer
    cwd: fxa-auth-server
    env:
      NODE_ENV: dev
      PUBLIC_URL: 'http://127.0.0.1:9000'
      HTTPDB_URL: 'http://127.0.0.1:8000'
      IP_ADDRESS: 0.0.0.0
      PORT: 9000
      CUSTOMS_SERVER_URL: 'http://127.0.0.1:7000'
      CONTENT_SERVER_URL: 'http://127.0.0.1:3030'
    max_restarts: 1
    script: test/mail_helper.js
  - name: auth-server db memory
    cwd: fxa-auth-server
    env:
      NODE_ENV: dev
    max_restarts: 1
    script: node_modules/fxa-auth-db-mem/bin/server.js
  - name: auth-server key server
    cwd: fxa-auth-server
    env:
      NODE_ENV: dev
    max_restarts: 1
    script: bin/key_server.js
  - name: content-server PORT 3030
    args:
    - server
    cwd: fxa-content-server
    max_restarts: 1
    script: node_modules/.bin/grunt
  - name: content-server basket proxy PORT 1114
    cwd: fxa-content-server
    max_restarts: 1
    script: server/bin/basket-proxy-server.js
  - name: content-server null basket server PORT 10140
    cwd: fxa-content-server
    max_restarts: 1
    script: server/bin/null-basket-server.js
  - name: oauth-server PORT 9010
    cwd: fxa-oauth-server
    env:
      NODE_ENV: dev
      PORT: 9010
      HOST: '0.0.0.0'
      HOST_INTERNAL: '0.0.0.0'
      PORT_INTERNAL: 9011
      PUBLIC_URL: 'http://192.168.99.102:9010'
      MYSQL_DATABASE: fxa_oauth
      MYSQL_HOST: '172.28.128.3'
      MYSQL_USERNAME: root
      MYSQL_PASSWORD: ''
    max_restarts: 1
    script: bin/server.js
  - name: oauth-server-internal PORT 9011
    cwd: fxa-oauth-server
    env:
      NODE_ENV: dev
    max_restarts: 1
    script: bin/internal.js
  - name: profile-server PORT 1111
    cwd: fxa-profile-server
    env:
      NODE_ENV: dev
    max_restarts: 1
    script: bin/server.js
  - name: profile-server static dev PORT 1112
    cwd: fxa-profile-server
    env:
      NODE_ENV: dev
    max_restarts: 1
    script: bin/_static.js
  - name: profile-server worker PORT 1113
    cwd: fxa-profile-server
    env:
      NODE_ENV: dev
    max_restarts: 1
    script: bin/worker.js
  - name: 123done PORT 8080
    cwd: 123done
    env:
      CONFIG_123DONE: ./config-local.json
      NODE_ENV: dev
    max_restarts: 1
    script: server.js
  - name: 321done UNTRUSTED PORT 10139
    cwd: 123done
    env:
      CONFIG_123DONE: ./config-local-untrusted.json
      NODE_ENV: dev
    max_restarts: 1
    script: server.js
  - name: fxa-oauth-console PORT 10137
    cwd: fxa-oauth-console
    env:
      NODE_ENV: dev
    max_restarts: 1
    script: bin/server.js
  - name: browserid-verifier PORT 5050
    cwd: browserid-verifier
    env:
      PORT: '5050'
    max_restarts: 1
    script: server.js
  - name: redis-server PORT 6379
    cwd: _scripts
    max_restarts: 1
    script: redis.sh
  - name: loop-server PORT 10222
    cwd: loop-server
    env:
      CONFIG_FILES: ../_scripts/configs/loop.json
      NODE_ENV: test
      PORT: '10222'
    max_restarts: 1
    script: loop/index.js
  - name: sync server PORT 5000
    cwd: syncserver
    max_restarts: 1
    script: ../_scripts/syncserver.sh
