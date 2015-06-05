# Ruby/Rails Performance

---
## Ruby/Rails is fucking slow

---
## agenda

- active record
- test
- deployment
- rails framework
- ruby gc
- profiling tools

---
## Active Record

---
## N + 1 Query

1. get n resource by 1 query
2. get 1 sub-resource by resouce by 1 query, but n times

```ruby
User.all.each do |user|
  puts user.post.title # bad performance
end

User.includes(:posts).all.each |user|
  puts user.post.title # good performance
end
```
---
## in memory process
you should always watch memory size

```ruby
User.all.to_a.sort_by {|user| user.name} # bad
User.order(name: 'desc').all # good

# generate tmp variable
[[1, 1],[2, 2],[3, 3]].map({ |arr| arr.join(',') }).join(',')

# ugly but fast
[[1, 1],[2, 2],[3, 3]].inject([]) do |memo, arr|
  arr.each {|i| memo << i}
  memo
end.join(',')

```
---
## extra columns
sometimes you don't need all columns in a model

```ruby
User.where(age: 18).map(&:name) # get all columns and only names
User.where(age: 18).pluck(:name) # only get names
```
---
## memorized method
cache your method
```ruby
def current_user
  User.find(session[:id]) # query db multi times
end

def current_user
  @user ||= User.find(session[:id]) # only once
end
```
---
## take out
do not developing and tuning at same time

- watch db query count
- watch memory, prefer db processing
- only query what you need

---
## test
---
## save in transaction, not db
- for unit test, write data in one transaction then rollback
- for feature test, write data in db then clean db

```ruby
RSpec.configure do |config|
  config.use_transactional_fixtures = true # or false then manage data by database cleaner
end
```

---
## parallel test
- create several test db
- start multi process to run test
- more cpu core, more faster

---
## rspec 3.x
[upgrade rspec](http://jiukunz.github.io/tw-ruby-training/slides/#/8) 2.x to 3.x will make 10% ~ 20% faster

---
## deployment

---
## Database migration

---
## batch find
not instance all data at 1 time, avoid memory consume

```ruby
User.all.each { ... } # instance user all at 1 time, no matter 1 or 1000000 rows

User.find_each {|user| xxx} # batch load 1000 rows, loop 1 by 1

User.find_in_batches {|users| xxx} # batch load 1000 rows, loop 1000 by 1
```
---
## batch update
try to avoid save modal 1 by 1
```ruby
User.all.each {|user| user.update_attributes(age: 18)} # fire db looooooooots of times
User.update_all(age:18)
```
---
## what if I want to update dynamic value?

---
## batch update

- RDBMS, raw sql
- MongoDB, impossible

---
## db index
- add index for good query performance
- index may slow down inserting

---
## bundler group
at least 3 groups

```ruby
group :development
group :test
group :production
```
---
## asset packaging

- rails default provide application.js application.css
- precompile is slow, only require needed assets
- remove empty asset files which generate by rails

---
## Rails framework

---
## spring gem
- preload rails app in background, speed up when testing or running rake task

---
## template engine

choose your favorite one

- erb
- haml
- slim

---
##  url helper is slow
pay attention for url helper method
- xxx_path
- xxx_url
- link_to
- ....
---
## Ruby GC

GC is getting better, read [Ruby GC History](http://tmm1.net/ruby21-rgengc/)

- 1.8.7 : simple mark and sweep
- 1.9.3 : lazy sweep
- 2.0.0 : Bitmap Marking
- 2.1.0 : RGen GC
- 2.2.0 : Incremental GC, 2 age RGen GC, Symbol GC

---
## profiling tools

---
## New Relic
free monitor service

---
## OneAPM
Chinese New Relic

---
## rack-mini-profiler
[watch video](http://railscasts.com/episodes/368-miniprofiler)

---
## TracePoint
ruby built in tool to help you measure performance
```ruby
calls = []
trace = TracePoint.new(:call) do |tp|
  calls << [tp.defined_class, tp.method_id, tp.lineno]
end
trace.enable
@users = User.all.to_a
trace.disable
pp calls.group_by(&:itself).map {|k, v| {k => v.length}}.sort_by {|h| -h.values.first}
```
---
## ruby-prof gem

---
## Summary
- you need fix typical issue when coding
- baby step for performance tuning
- measure performance by tools
- try to fix issue
- measure performance again

---
## at last
you'd better writing less code
