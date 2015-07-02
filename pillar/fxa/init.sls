fxa:
  apps:

  - name: auth-server mailer
    # fxa-auth-server/config/index.js
    cwd: fxa-auth-server
    script: test/mail_helper.js
    env:
      PORT: 9000
      IP_ADDRESS: 0.0.0.0
      NODE_ENV: dev
      PUBLIC_URL: http://127.0.0.1:9000
      DB_BACKEND: httpdb
      HTTPDB_URL: http://127.0.0.1:8000
      CUSTOMS_SERVER_URL: http://127.0.0.1:7000
      CONTENT_SERVER_URL: http://127.0.0.1:3030
      MAILER_HOST: 127.0.0.1
      MAILER_PORT: 9001
      SMTP_HOST: localhost
      SMTP_PORT: 25
      SMTP_SECURE: false
      #SMTP_USER: ''
      #SMTP_PASS: ''
      SMTP_SENDER: Firefox Accounts <no-reply@lcip.org>
      REDIRECT_DOMAIN: firefox.com
      #USE_TLS: false
      #TLS_KEY_PATH: ''
      #TLS_CERT_PATH: ''
    max_restarts: 1
  - name: auth-server db memory
    # fxa-auth-server/config/index.js
    cwd: fxa-auth-server
    script: node_modules/fxa-auth-db-mem/bin/server.js
    env:
      PORT: 9000
      IP_ADDRESS: 0.0.0.0
      NODE_ENV: dev
      PUBLIC_URL: http://127.0.0.1:9000
      DB_BACKEND: httpdb
      HTTPDB_URL: http://127.0.0.1:8000
      CUSTOMS_SERVER_URL: http://127.0.0.1:7000
      CONTENT_SERVER_URL: http://127.0.0.1:3030
      MAILER_HOST: 127.0.0.1
      MAILER_PORT: 9001
      SMTP_HOST: localhost
      SMTP_PORT: 25
      SMTP_SECURE: false
      #SMTP_USER: ''
      #SMTP_PASS: ''
      SMTP_SENDER: Firefox Accounts <no-reply@lcip.org>
      REDIRECT_DOMAIN: firefox.com
      #USE_TLS: false
      #TLS_KEY_PATH: ''
      #TLS_CERT_PATH: ''
    max_restarts: 1
  - name: auth-server key server
    # fxa-auth-server/config/index.js
    cwd: fxa-auth-server
    script: bin/key_server.js
    env:
      NODE_ENV: dev
      PUBLIC_URL: http://127.0.0.1:9000
      DB_BACKEND: httpdb
      HTTPDB_URL: http://127.0.0.1:8000
      IP_ADDRESS: 127.0.0.1
      PORT: 9000
      CUSTOMS_SERVER_URL: http://127.0.0.1:7000
      CONTENT_SERVER_URL: http://127.0.0.1:3030
      MAILER_HOST: 127.0.0.1
      MAILER_PORT: 9001
      SMTP_HOST: localhost
      SMTP_PORT: 25
      SMTP_SECURE: false
      #SMTP_USER: ''
      #SMTP_PASS: ''
      SMTP_SENDER: Firefox Accounts <no-reply@lcip.org>
      REDIRECT_DOMAIN: firefox.com
      #USE_TLS: false
      #TLS_KEY_PATH: ''
      #TLS_CERT_PATH: ''
    max_restarts: 1



  - name: content-server PORT 3030
    # server/lib/configuration.js
    cwd: fxa-content-server
    script: node_modules/.bin/grunt
    args:
    - server
    env:
      PORT: 3030
      HTTP_PORT: 3080
      REDIRECT_PORT: 80
      PUBLIC_URL: http://127.0.0.1:3030
      ENABLE_STATSD: true
      FXA_URL: http://127.0.0.1:9000
      FXA_OAUTH_URL: https://oauth.dev.lcip.org
      FXA_PROFILE_URL: http://127.0.0.1:1111
      FXA_PROFILE_IMAGES_URL: http://127.0.0.1:1112
      FXA_OAUTH_CLIENT_ID: ea3ca969f8c6bb0d
      FXA_MARKETING_EMAIL_API_URL: http://127.0.0.1:1114
      FXA_MARKETING_EMAIL_PREFERENCES_URL: https://www-dev.allizom.org/newsletter/existing/
    max_restarts: 1
  - name: content-server basket proxy PORT 1114
    # server/lib/configuration.js
    cwd: fxa-content-server
    script: server/bin/basket-proxy-server.js
    env:
      PORT: 1114
      HTTP_PORT: 3080
      REDIRECT_PORT: 80
      PUBLIC_URL: http://127.0.0.1:3030
      ENABLE_STATSD: true
      FXA_URL: http://127.0.0.1:9000
      FXA_OAUTH_URL: https://oauth.dev.lcip.org
      FXA_PROFILE_URL: http://127.0.0.1:1111
      FXA_PROFILE_IMAGES_URL: http://127.0.0.1:1112
      FXA_OAUTH_CLIENT_ID: ea3ca969f8c6bb0d
      FXA_MARKETING_EMAIL_API_URL: http://127.0.0.1:1114
      FXA_MARKETING_EMAIL_PREFERENCES_URL: https://www-dev.allizom.org/newsletter/existing/
    max_restarts: 1
  - name: content-server null basket server PORT 10140
    # server/lib/configuration.js
    cwd: fxa-content-server
    script: server/bin/null-basket-server.js
    env:
      PORT: 10140
      HTTP_PORT: 3080
      REDIRECT_PORT: 80
      PUBLIC_URL: http://127.0.0.1:3030
      ENABLE_STATSD: true
      FXA_URL: http://127.0.0.1:9000
      FXA_OAUTH_URL: https://oauth.dev.lcip.org
      FXA_PROFILE_URL: http://127.0.0.1:1111
      FXA_PROFILE_IMAGES_URL: http://127.0.0.1:1112
      FXA_OAUTH_CLIENT_ID: ea3ca969f8c6bb0d
      FXA_MARKETING_EMAIL_API_URL: http://127.0.0.1:1114
      FXA_MARKETING_EMAIL_PREFERENCES_URL: https://www-dev.allizom.org/newsletter/existing/
    max_restarts: 1



  - name: oauth-server PORT 9010
    # fxa-oauth-server/lib/config.js
    cwd: fxa-oauth-server
    script: bin/server.js
    env:
      NODE_ENV: dev
      PORT: 9010
      HOST: 0.0.0.0
      HOST_INTERNAL: 127.0.0.1
      PORT_INTERNAL: 9011
      PUBLIC_URL: http://192.168.99.102:9010
      DB: memory
      #DB: mysql
      #MYSQL_DATABASE: fxa_oauth
      #MYSQL_HOST: 172.28.128.3
      #MYSQL_USERNAME: root
      #MYSQL_PASSWORD: ''
      ISSUER: api.accounts.firefox.com
      VERIFICATION_URL: https://verifier.accounts.firefox.com/v2
      CONTENT_URL: https://accounts.firefox.com/oauth/
    max_restarts: 1
  - name: oauth-server-internal PORT 9011
    # fxa-oauth-server/lib/config.js
    cwd: fxa-oauth-server
    script: bin/internal.js
    env:
      NODE_ENV: dev
      PORT: 9011
      HOST: 0.0.0.0
      HOST_INTERNAL: 127.0.0.1
      PORT_INTERNAL: 9011
      PUBLIC_URL: http://192.168.99.102:9010
      DB: memory
      #DB: mysql
      #MYSQL_DATABASE: fxa_oauth
      #MYSQL_HOST: 172.28.128.3
      #MYSQL_USERNAME: root
      #MYSQL_PASSWORD: ''
      ISSUER: api.accounts.firefox.com
      VERIFICATION_URL: https://verifier.accounts.firefox.com/v2
      CONTENT_URL: https://accounts.firefox.com/oauth/
    max_restarts: 1



  - name: profile-server PORT 1111
    # fxa-profile-server/lib/config.js
    cwd: fxa-profile-server
    script: bin/server.js
    env:
      NODE_ENV: dev
      PORT: 1111
      HOST: 0.0.0.0
      #DB: memory
      #DB: mysql
      #MYSQL_DATABASE: fxa_profile
      #MYSQL_HOST: 172.28.128.3
      #MYSQL_USERNAME: root
      #MYSQL_PASSWORD: ''
      #PUBLIC_URL: http://127.0.0.1:1111
      #WORKER_HOST: 127.0.0.1
      #WORKER_PORT: 1113
    max_restarts: 1
  - name: profile-server static dev PORT 1112
    # fxa-profile-server/lib/config.js
    cwd: fxa-profile-server
    script: bin/_static.js
    env:
      NODE_ENV: dev
      PORT: 1112
      HOST: 0.0.0.0
      #DB: memory
      #DB: mysql
      #MYSQL_DATABASE: fxa_profile
      #MYSQL_HOST: 172.28.128.3
      #MYSQL_USERNAME: root
      #MYSQL_PASSWORD: ''
      #WORKER_HOST: 127.0.0.1
      #WORKER_PORT: 1113
    max_restarts: 1
  - name: profile-server worker PORT 1113
    # fxa-profile-server/lib/config.js
    cwd: fxa-profile-server
    script: bin/worker.js
    env:
      NODE_ENV: dev
      PORT: 1113
      HOST: 0.0.0.0
      #DB: memory
      #DB: mysql
      #MYSQL_DATABASE: fxa_profile
      #MYSQL_HOST: 172.28.128.3
      #MYSQL_USERNAME: root
      #MYSQL_PASSWORD: ''
      #PUBLIC_URL: http://127.0.0.1:1111
      #WORKER_HOST: 127.0.0.1
      #WORKER_PORT: 1113
    max_restarts: 1



  - name: 123done PORT 8080
    cwd: 123done
    env:
      CONFIG_123DONE: ./config-local.json
      NODE_ENV: dev
    max_restarts: 1
    script: server.js
  - name: 321done UNTRUSTED PORT 10139
    cwd: 123done
    script: server.js
    env:
      CONFIG_123DONE: ./config-local-untrusted.json
      NODE_ENV: dev
    max_restarts: 1


  - name: fxa-oauth-console PORT 10137
    cwd: fxa-oauth-console
    script: bin/server.js
    env:
      NODE_ENV: dev
    max_restarts: 1


  - name: browserid-verifier PORT 5050
    cwd: browserid-verifier
    script: server.js
    env:
      PORT: 5050
    max_restarts: 1


  - name: redis-server PORT 6379
    script: redis.sh
    cwd: _scripts
    max_restarts: 1


  - name: loop-server PORT 10222
    cwd: loop-server
    script: loop/index.js
    env:
      CONFIG_FILES: ../_scripts/configs/loop.json
      NODE_ENV: test
      PORT: 10222
    max_restarts: 1


  - name: sync server PORT 5000
    cwd: syncserver
    script: ../_scripts/syncserver.sh
    max_restarts: 1
