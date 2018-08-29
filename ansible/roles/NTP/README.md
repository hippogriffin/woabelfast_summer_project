Role Name
=========

Install NTP service on servers

Requirements
------------

None.

Role Variables
--------------

    ntp_enable = true/false

Defines whether or not ntp will be started and enabled on system boot 

    ntp_timezone = (timezone)

This is used to set your timezone and is also passed into you system clock via a template

    ntp_manage_config = true/false

When true, ntp will be configured according to your ntp.conf.j2 template

    ntp_servers:
    - server1
    -server2

This defines ntp servers to be added to your ntp.conf.j2 template

    ntp_restrict:
    - ip1
    - ip2

Defines what servers can use this server as an ntp server. setting to 127.0.0.1 will restrict to itself.

    ntp_daemon = 

This defines the ntp daemon name. This will be different depending on your distribution

Example Playbook
----------------

    - hosts: all
      roles:
         - NTP

License
-------

BSD

#
### Training and Resources
https://docs.ansible.com/ansible/2.5/user_guide
