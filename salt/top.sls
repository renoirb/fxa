base:
  '*':
    - basesystem
    - fxa
  'baseimage':
    - nodejs
  'role: oauth':
    - match: grain
    - fxa.oauth

