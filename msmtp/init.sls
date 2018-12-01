# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "msmtp/map.jinja" import msmtp with context %}

msmtp:
  pkg.installed:
    - pkgs:
      - msmtp
      - msmtp-mta

  file.managed:
    - name: {{ msmtp.msmtprc }}
    - source: salt://msmtp/files/msmtprc.tmpl
    - user: root
    - group: root
    - mode: 600
    - template: jinja
    - context:
        msmtp_config: {{ msmtp.config }}
        msmtp_accounts: {{ msmtp.accounts }}
        default_account: {{ msmtp.default_account }}

aliases:
  file.managed:
    - name: {{ msmtp.config.aliases }}
    - source: salt://msmtp/files/aliases.tmpl
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        aliases: {{ msmtp.aliases }}
