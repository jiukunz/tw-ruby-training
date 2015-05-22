# background process in rails

---

## Background process

> A background process is a computer process that runs "behind the scenes" (i.e. in the background) and without user intervention. Typical tasks for these processes include logging, system monitoring, scheduling, and user notification.

---

## typical process in asnyc

- send email
- image process
- http downloads
- batch import

---

## message queue
> In computer science, message queues and mailboxes are software-engineering components used for inter-process communication (IPC), or for inter-thread communication within the same process. They use a queue for messaging – the passing of control or of content.

---

## whole process

1. Rails server generate a job
2. Rails server write to a message queue
3. Worker pull the latest message
4. Worker process that message
5. Worker update result in message queue
6. Rails server read result

---
## delayed job gem

- first commit at Feb 2008
- use db as message queue
- delayed job provide default worker
- run `script/delayed_job start` to start worker in another process

```ruby
# without delayed_job
@user.activate!(@device)

# with delayed_job, delay is method added by delayed job gem
@user.delay.activate!(@device)
```

---
## Resque gem
- first commit at Aug 2009
- use redis as message queue
- you need write your worker
- run `bin/resque work` to start worker in another process
- easy to transfer from delayed job

```ruby
class ImageConversionJob
  def work
      # convert some kind of image here
  end
end

# enqueue
resque = Resque.new
resque << ImageConversionJob.new
```
---
## Sidekiq gem
- first commit at Jan 2012
- use redis as message queue
- you need write your worker
- run `bundle exec sidekiq` to start worker in another _**thread**_
- easy to transfer from resque
- 1 sidekiq worker ~= 20 resque worker

```ruby
class HardWorker
  include Sidekiq::Worker
  def perform
  end
end

HardWorker.perform_async('bob', 5)
```
---
## Active Job gem
- first commit at May 2014
- abstraction of background worker, adaptor for delayed job/resque/sidekiq
- merge into rails from 4.2.0

```ruby
class GuestsCleanupJob < ActiveJob::Base
  queue_as :default
  def perform(*args)
     # Do something later
  end
end

GuestsCleanupJob.perform_later record
# in config
config.active_job.queue_adapter = :sidekiq
```
---
## Pros and cons
| gem         | pros                                                            | cons                                  |
|-------------|-----------------------------------------------------------------|---------------------------------------|
| delayed job | first gem no worker                                             | dirty implementation db is slow       |
| resque      | easily compatible high performance simple worker                | n worker, n process                   |
| sidekiq     | easily compatible higher performance simple worker monitor page | multi-thread programming              |

---
## only implementation is not enough
1. implementation
2. deployment
3. monitor
4. **decent as architecture**
