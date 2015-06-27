salt-minion:
  pkg.installed

/etc/salt/minion.d/masterless.conf:
  file.managed:
    - contents: |
        file_client: local
        state_verbose: True
        log_level: debug
        log_level_logfile: debug
        startup_states: highstate

