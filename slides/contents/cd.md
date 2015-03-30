# Continues Delivery

---
##Process

- setup CI server
- code push
- run tests
- generate package
- one click to deploy

---
##Setup CI

- install CI server
- install CI agent
- connect CI with github
- connect CI with node in deploy env

---
## SSh On CI

- create new github account for CI
- make sure CI can talk to any nodes, even bastion machine

---
## Push Code

- master branch only
- push daily or per story

---
## Run Test
- Unit Test
- Integration Test
- Feature Test
- Performance Test

---
## Package
- zip
- rpm
- gem
- ...

---
## Deployment

- apply new package
- migrate db
- restart server

---
## Role

- load balancer, elb or nginx
- web server, nginx for assets file
- app server, unicorn
- hot store, redis for non persistent data
- database

---
## [Capistrano Process](http://capistranorb.com)

- ssh server
- pull code
- bundle install
- precompile assets
- restart app server

---
## Homework 1, Secure Shell
read SSH reference and share in your team

- [SSH Tutorial](http://support.suso.com/supki/SSH_Tutorial_for_Linux)
- [SSH Agent Forward](https://ihower.tw/blog/archives/7837)
- [SSH Config](http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/)

---
## Homework 2

0. write capistrano 3 deploy script
1. config Go CI server to one click deployment
2. make zhaocaimao running

---
## Capistrano Reference

- Capistrano home page 'Getting Started' Section
- http://www.talkingquickly.co.uk/2014/01/deploying-rails-apps-to-a-vps-with-capistrano-v3/
- http://blog.frankzhao.com.au/2014/04/rails-4-capistrano-3-unicorn-mercurial/
- http://ryaneschinger.com/blog/11-capistrano-3-plugins-to-simplify-your-rails-deployments/
- http://www.zodiacmedia.co.uk/blog/capistrano-3-tutorial-series-part-1
- http://www.zodiacmedia.co.uk/blog/capistrano-3-tutorial-series-part-2
- http://www.zodiacmedia.co.uk/blog/capistrano-3-tutorial-series-part-3

---
## Go CI Reference
- http://thoughtworks.com/products/docs/go/14.2.0/help