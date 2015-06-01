# data migration

---

## Definition

> Data migration is the process of transferring data between storage types, formats, or computer systems.

---
## some scenarios

- **Add column**
- **Remove column**
- **Modify column**
- Change DB
- Change service provider

---
## Deployment window

> When switching a node in the cloud from the current version to a new version, there is a window of time when the node is unusable in terms of serving traffic. During that window, the node is taken out of traffic, and after the switch it is brought back into traffic.

---
## zero downtime deployment

> Deploy without application downtime, better user experience but need much more effort.

---
## RDBMS vs NoSQL
|            | RDBMS                            | NOSQL                         |
|------------|----------------------------------|-------------------------------|
| DB Name    | MySQL Postgres Oracle SQL Server | MongoDB Cassandra Neo4j Redis |
| Schema     | need schema                      | no schema                     |
| Transation | yes                              | Neo4j yes others no           |

---

## Capistrano process
```ruby
deploy
  deploy:starting
    [before]
      deploy:ensure_stage
      deploy:set_shared_assets
    deploy:check
  deploy:started
  deploy:updating
    git:create_release
    deploy:symlink:shared
  deploy:updated
    [before]
      deploy:bundle
    [after]
      deploy:migrate
      deploy:compile_assets
      deploy:normalize_assets
  deploy:publishing
    deploy:symlink:release
    [after]
      rails server:restart
  deploy:published
  deploy:finishing
    deploy:cleanup
  deploy:finished
    deploy:log_revision
```
---

## zero downtime?

1. first migrate
2. restart rails server
3. is it zero downtime?

---
## schema files
- represent of current state of db
- load schema instead of running all migrations when first deployment

---
## RDBMS + Adding column

- add column in db
- user insert data before restart
- rails server restart
- **raise exception?**

---
## it depends on allow null

otherwise will raise exception column cannot be null

---
## RDMBS + Remove column

- remove column in db
- user insert data before restart
- rails server restart
- **raise exception?**

---
## raise exception !!!
---
## RDBMS + Modify column

- modify column in db
- user insert data before restart
- rails server restart
- **raise exception?**

---
## raise exception !!!
modify column = remove column + add column

---
## mongodb + add column

- add column in db
- user insert data before restart
- rails server restart
- **raise exception?**

---
## Safe action !!!
- mongodb has no **SCHEMA**
- new column will be null by default

---
## mongodb + remove column

- remove column in db
- user insert data before restart
- rails server restart
- **raise exception?**

---
## no exception
1. before restart, user will insert data contains removed column
2. after restart, user will insert data without removed column

---
## mongodb + Modify column

- modify column in db
- user insert data before restart
- rails server restart
- **raise exception?**

---
## raise exception !!!
1. no exception for insert before or after restart
2. after restart, app will found **2 kinds of data on same column**

---
## a little bit hard for zero downtime

---
## zero downtime for add column
1. make sure new column can be null
2. prepare default value for existing data
3. migrate
4. restart rails server

---
## zero downtime for remove column
1. modify code, not read that column
2. deploy
3. write migration task to remove column
3. deploy + migrate

---
## zero downtime for modify column
1. modify code, support 2 kinds of data
2. modify code, insert new format data
2. deploy
3. write migration task to modify data
4. deploy + migrate
4. modify code, remove support 2 kinds of data
5. deploy
---
## Deployment methodology
1. blue green deployment
2. red black deployment
---
## reference
1. [blue/green from martin fowler](http://martinfowler.com/bliki/BlueGreenDeployment.html)
2. [do and don't in blue/green](https://cloudnative.io/blog/2015/02/the-dos-and-donts-of-bluegreen-deployment/)
3. [red-white push](http://theburningmonk.com/2014/08/red-white-push-continuous-delivery-at-gamesys-social/)
4. [deploy in netflix](http://techblog.netflix.com/2013/08/deploying-netflix-api.html)
5. [Implementing Blue-Green Deployments with AWS](http://www.thoughtworks.com/insights/blog/implementing-blue-green-deployments-aws)
5. [blue/green in pivotal](http://docs.pivotal.io/pivotalcf/devguide/deploy-apps/blue-green.html)
