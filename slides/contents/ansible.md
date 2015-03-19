# Ansible

> *brief introduction*

---

## IT automation tool

- configure systems
- provision machine
- deploy software

---

## Why Ansible?

- Better Performance
- Agent Less
- Base on python, default install on Linux(support Windows)
- Simple DSL

---

## What we need to do to install software on remote machine?

---
## Steps

- connect machine
- install software
- change configuration
- do some callback, eg. restart service

---

## ansible machine - Inventory
[INI File](http://en.wikipedia.org/wiki/INI_file) Format
```bash
mail.example.com #default 22 port

# alias name
test_db ansible_ssh_port=5555 ansible_ssh_host=192.168.1.50

[webservers]  # group
foo.example.com
bar.example.co
```
---
## install software - playbook
Playbook is composed of `play`, which is composed of `tasks`

```yml
- - -                 # a simple play
- name: install nginx # comments for play
  hosts: webservers   # locate machines
  tasks:              # detail action
    - name: install step
      yum: pkg=httpd state=latest # module : parameters
```
---

## change config - module `file`
Copy file to remote node
```bash
# must be in files folder
- copy: src=files/foo.conf dest=/etc/foo.conf
```

---
## change config - `template`
- generate dynamic file base on variable, using [Jinja2](http://jinja.pocoo.org/docs/)
- Variable names should be letters, numbers, and underscores. Variables should always start with a letter.

```bash
- - -
- name: install nginx
  hosts: webservers
  vars:
    key_file: /etc/nginx/ssl/nginx.key
    http_port: 80
  tasks:
    - name: generate nginx config # must be in tempaltes folder
      template: src=templates/nginx.conf dest=/etc/nginx/nginx.conf
    - name: copy ssl key
      copy: src=files/nginx.key dest={{ key_file }}
```
---
## do some hook - `service`
- start, stop, restart, reload a service
- service is a script in /etc/init.d

```bash
# start the httpd service if not running
- service name=httpd state=started # started, not start
```
---

## do some hook - `notify`
Running Operations On Changes

```bash
- name: nginx
  tasks:
    - name: template configuration
      template: src=templates/foo.conf dest=/etc/foo.conf
      notify:
        - restart nginx #pay attention for name
  handlers:
    - name restart nginx
      service: name=nginx state=restarted
```
---

## reuse - `role`
- include other play file for reuse
- download role from ansible-galaxy

```bash
- name: Configure webserver
  hosts: webservers
  sudo: true
  roles: #include other playbook
    - { role: redis}
# folder roles/redis/xxx
```
---
## structure

```bash
production                # inventory file for production servers
stage                     # inventory file for stage environment

group_vars/
  group1                 # here we assign variables to particular groups
  group2                 # ""
host_vars/
  hostname1              # if systems need specific variables, put them here
  hostname2              # ""

library/                  # if any custom modules, put them here (optional)
filter_plugins/           # if any custom filter plugins, put them here (optional)

site.yml                  # master playbook
webservers.yml            # playbook for webserver tier
dbservers.yml             # playbook for dbserver tier

roles/
  common/               # this hierarchy represents a "role"
    tasks/            #
      main.yml      #  <-- tasks file can include smaller files if warranted
  handlers/         #
    main.yml      #  <-- handlers file
  templates/        #  <-- files for use with the template resource
    ntp.conf.j2   #  <------- templates end in .j2
  files/            #
    bar.txt       #  <-- files for use with the copy resource
    foo.sh        #  <-- script files for use with the script resource
  vars/             #
    main.yml      #  <-- variables associated with this role
  defaults/         #
    main.yml      #  <-- default lower priority variables for this role
  meta/             #
    main.yml      #  <-- role dependencies

webtier/              # same kind of structure as "common" was above, done for the webtier role
monitoring/           # ""
fooapp/               # ""
```
---
## Notes

- Base on module, simple and fast
- Module not cover all Linux OS
- SSH is your friend(ssh-agent, ssh-add, forward-agent)

---
# Q & A

---
## Homework 1
1. http://www.ansible.com/resources - quick start video
2. http://www.ansible.com/ansible-book, read and follow
3. http://docs.ansible.com/, reference
4. https://github.com/ansible/ansible-examples, reference
5. http://docs.ansible.com/playbooks_best_practices.html, reference

---
## Homework 2
Please use ansible to install remote machine

0. single node or cluster
1. ruby 2.1.2
2. nginx, latest version
3. memcached, latest version
4. mysql, 5.6.x
