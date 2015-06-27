base:
  '*':
    - basesystem
    - nodejs
    - fxa
  'role: oauth':
    - match: grain
    - fxa.oauth

