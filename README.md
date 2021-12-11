Role Name
=========

Role to fulfill these tasks:
1 Install RabbitMQ service (latest available from RabbitMQ repository);
2 Install RabbitMQ admin plugin;
3 Remove guest user;
4 Create a vhost and a user with read, write privileges on the created vhost;
5 Modify RabbitMQ open files limit to 100K.
6 Test user password stored in ansible vault;
7 RabbitMQ installation should be suitable for Debian operating system;
8 Yaml files should pass linter (for example: yamllint).
9 Firewall to:
   Open rabbitmq admin console to outside;
   Open default rabbitmq port for localhost only.
sample script to create exhange,queue,bind them, create user and post single message

Requirements
------------

Ansible installed and preconfigured, internet access.

Role Variables
--------------

Secondary rabbitmq user "rw" will be created with password from encrypted file secrets.yml located in var directory. Password to decrypt file contect is stored in files directory.

Dependencies
------------

depends on rabbitmq, iptables, systemd modules.

Example Playbook
----------------

scrips were written fol localhost installs, for remote systems please ammend at least hosts files and other parameters depending on your setup or internal requirements.

ansible-playbook -e @rabbitmq-role/vars/secrets.yml --vault-password-file rabbitmq-role/files/PasswordForDecrypt rabbitmq-install.yml
execute bash script to configure queue, user and post message

License
-------

BSD

Author Information
------------------

https://github.com/sidlauskasr
