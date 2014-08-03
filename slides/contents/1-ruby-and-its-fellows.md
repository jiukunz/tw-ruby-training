# **Ruby** and its fellows

---

# Ruby at a Glance

- a Programming Language
- Open Source
- Designed by Yukihiro Matsumoto
- Appeared in 1995
- Stable release 2.1.2 / May 9, 2014
- Cross-platform

---

## Ruby Features

- Dynamic typing and duck typing
- Object-oriented
- Functional
- Imperative
- Automatic memory management
- Modules
- Mixins
- Default arguments
- Metaprogramming

---

# irb
- Interactive Ruby Shell
- an interactive command-line interpreter

```bash
$ irb
irb(main):001:0> puts "Hello, World"
Hello, World
=> nil
irb(main):002:0> 1+2
=> 3
```


---

# RubyGems

- a Package Manager
- part of the standard library from Ruby version 1.9
- 78,439 gems hosted on RubyGems.org on Jul 15, 2014
- gem command
  - `$ gem search rspec`
  - `$ gem install rspec`
  - `$ gem list`
  - `$ gem list rspec -d`
  - `$ gem uninstall rspec`
  - `$ gem environment gemdir`

---

## What is a gem?

- Inside a gems are the following components:
  * Code (including tests and supporting utilities)
  * Documentation
  * gemspec
- Each gem follows the same standard structure of code organization:

```bash
% tree freewill
freewill/
├── bin/
│   └── freewill
├── lib/
│   └── freewill.rb
├── test/
│   └── freewill_spec.rb
├── README
├── Rakefile
└── freewill.gemspec
```

---

# Rake

- a Make-like program implemented in Ruby
- written in the Ruby programming language and use Ruby syntax
- part of the standard library from Ruby version 1.9 onward

---

## rake command

- `$ rake`

  run the "default" task in the Rakefile
- `$ rake -T`

  Display a list of the major tasks and their comments
- `$ rake -P`

  Display a list of all tasks and their immediate prerequisites
- `$ rake name`
- `$ rake name[Wei,Zheng]`
- `--rakelibdir rakelibdir (-R)`

  Auto-import any .rake files in RAKELIBDIR. (default is 'rakelib')

---

## Rakefile

you must write a "Rakefile" file which contains the build rules

### Simple Tasks

```ruby
task :name
```

### Tasks with Prerequisites

```ruby
task :name => [:prereq1, :prereq2]
```
### Simple Example

```ruby
task :default => [:test]

task :test do
  puts "Hello World!"
end
```

---

### Tasks with Arguments

```ruby
task :name, [:first_name, :last_name] do |t, args|
  args.with_defaults(:first_name => "Xi", :last_name => "Qi")
  puts "First name is #{args.first_name}"
  puts "Last  name is #{args.last_name}"
end
```

#### Have Prerequisites

```ruby
task :name, [:first_name, :last_name] => [:pre_name]
```

---
### Comments
```ruby
desc "Print 'Hello world!'"
task :hello do
	puts "Hello world!"
end
```

### Namespaces
```ruby
namespace "main" do
  task :build do
    puts "main build"
  end
end

namespace "samples" do
  task :test => "main:build" do
    puts "samples test"
  end
end
```

---

# rbenv

- use different rubies in a manner that won't mess with your existing ruby install
- guarantee that your development environment matches production
- letting you run multiple different rubies in seperate terminals concurrently

---

## How It Works

- Understanding PATH

- Understanding Shims

- Choosing the Ruby Version
  - `$ rbenv shell`
  - `$ rbenv local`
  - `$ rbenv global`

---

## Installation

```bash
$ brew install rbenv ruby-build
```
Afterwards you'll still need to add eval "$(rbenv init -)" to your profile as stated in the caveats. You'll only ever have to do this once.

---

### oh-my-zsh

```bash
$ subl ~/.zshrc
```

```
plugins=(git sublime rbenv)
```

---

## rbenv command

- `$ rbenv install -l`
- `$ rbenv install 2.1.2`
- `$ rbenv local 2.1.2`
- `$ rbenv rehash`

  Run this command after you install a new version of Ruby, or install a gem that provides commands

---

## rbenv which

- `$ rbenv versions`
- `$ rbenv which ruby`

---

# RVM

- Ruby Version Manager
- RVM is a command-line tool which allows you to easily install, manage, and work with multiple ruby environments from interpreters to sets of gems.

---

# Bundler

- manage your application's	 dependencies
- tracking and installing the exact gems and versions that are needed

```bash
$ gem install bundler
$ bundle init
```

```bash
$ bundle install
```

---

## Gemfile

```ruby
source 'https://rubygems.org'

gem 'awesome_print'
gem 'rails', '3.0.0.beta3'
gem 'rack', '>=1.0'
gem 'thin', '~>1.1'
# gem 'thin', '>= 1.1', '< 1.2'

gem 'sinatra', :require => 'sinatra/base'
gem 'capybare-webkit', :require => false
```
```ruby
require 'awesome_print'

ap 'Hello World!'
```

---
### Bundler.require

```ruby
require 'bundler/setup'
Bundler.require(:default)

ap "Hello World!"
```

---

### Groups

```ruby
gem 'wirble', :group => :development
gem 'debugger', :group => [:development, :test]

group :test do
  gem 'rspec'
end
```

```bash
$ bundle install --without=development test
```

---

### Gemfile.lock

```bash
$ git add Gemfile Gemfile.lock
```

ensures that other developers on your app, as well as your deployment environment, will all use the same third-party code that you are using now.

---

## bundle exec
```bash
$ bundle exec rspec
```

>> rspec-core is not part of the bundle. Add it to Gemfile.

---

### oh-my-zsh

```bash
$ subl ~/.zshrc
```

```
plugins=(git sublime rbenv bundler)
```
---

# RSpec

RSpec is testing tool for the Ruby programming language. Born under the banner of **Behaviour-Driven Development**, it is designed to make **Test-Driven Development** a productive and enjoyable experience with features like:

- a rich command line program (the rspec command)
- textual descriptions of examples and groups (rspec-core)
- flexible and customizable reporting
- extensible expectation language (rspec-expectations)
- built-in mocking/stubbing framework (rspec-mocks)

---

bowling_spec.rb

```ruby
require 'bowling'

describe Bowling, "#score" do
  it "returns 0 for all gutter game" do
    bowling = Bowling.new
    20.times { bowling.hit(0) }
    expect(bowling.score).to be(0)
  end
end
```

---

bowling.rb
```ruby
class Bowling
  def hit(pins)
  end

  def score
    0
  end
end
```

```bash
$ rspec bowling_spec.rb
```

---

# **酷炫的东西!**

---

## __任意大__的整数

    2**10000 # ....
```ruby
1996168403619459789933112942320912427155649134941378111759378593209632395785573004679379452676
5246551266059895520550086918193311542508608460618104685509074866089624888090489894838009253941
6332578506215683094739025569123880652250966438744410467598716269854532228685381616943157756296
4076283688076073222853509164147618395638145896946389941084096053626782106462142733339403652556
5649530603142680234969400335934316651459297773279665775606172582031407994198179607378245683762
2800373028854872519008344645814546505579296014148339216157345881392570953797691192778008269577
3567444412306201875783632550272832378927071037380286639303142813324140162419567169057406141965
4342324638801248856147305207431992259611796250130992860241708340807605932320161268492288496255
8413128440615367389514871142563151110897455142033138202029316409575964647560104058458415660720
4496286701651506192063100418642227590867090057460641785695191145605506825125040600751984226189
......
......
......
```

    (2**10000).to_s.length # => 3011
    (2..10000).class  # => Bignum < Integer
---
## __并行__赋值
```ruby
x, y, z = 1, 2, 3 # => x=1 y=2 z=3

x, y = 1, 2, 3 # => x=1 y=2 z=nil

x = 1, 2, 3   # => x = [1, 2, 3]

x, *y, z = 1, 2, 3, 4 # => x=1, y=[2, 3], z=4

x, y, z = 1, *[2, 3]  # => x=1 y=2 z=3

a, (b, (c, d)) = [1, [2, [3, 4]]]

a, b = b, a  # => 交换 a, b
```
---

## splat(__*__) 参数
```ruby
def some_meth(*args)
  p args
end

some_meth(1, 2, 3, 4)   # => [1, 2, 3, 4]

args = [1, 2, 3, 4]
some_meth(*args)    # => [1, 2, 3, 4]
```

---
## 字符串的 __[]__ 方法
```ruby
str = "hello world!"

str[0]   # => 'h'
str[-1]   # => '!'
str[0..3] # => 'hell'
str[0...3] # => 'hel'
str[0, 4] # => 'hell'
str['!']  # => '!'
str[/he*\B/]  # => 'hello'
str[/(he)ll(o)/, 2] # => 'o'
```
---
## 强大的 __正则表达式__

```ruby
# 零宽断言
str = "red, white, and blue."
str.scan(/\w+(?=,)/)  # => ["red", "white"]

# 回文
"`abcba' is a palindromes".match(/(.)(.)(.)\k<-1>?\k<-2>\k<-3>/)
# => #<MatchData "abcba">

# 汉字
"one 汉字".match(/\p{han}+/)  # => '汉字'
```
---
## 神奇的 __==__ 方法
```ruby
require 'bcrypt'
include BCrypt

# create a Password instance.
password = Password.create('hello')

p password == 'hello'    # => true

p password
# => "$2a$10$qbDd3IegZotD7X828QFpauLCKy1ZcwT7bgXJfjTRSMLMU/J2gTSWi"

p password.class  # => BCrypt::Password < String

class Password < String
  def ==(secret)
    super(BCrypt::Engine.hash_secret(secret, @salt))
  end
end
```
---
## 神奇的 __===__ 方法 和 __case__ 语句

```ruby
class Range
  def ===(other)
    self.include? other.abs
  end
end

def meth(x)
  case x
  when 10..30  # (10..30) === x
    puts "in 10-30"
  else
    puts "not in 10-30"
  end
end

meth(15)  # => 'in 10-30'
meth(-15) # => 'in 10-30'
```
---
## 计算: 1m/4 + 10cm * 3 - 5mm
```ruby
# open class, 甚至 Fixnum (核心类) 也不例外.

class Fixnum
  def m; self*1000 end
  def cm; self*10 end
  def mm; self*1 end
end

1.m/4 + 10.cm * 3 - 5.mm  # => 545
```
---
## 内部__迭代器__
```ruby
  2.times { puts "hello world!" }  # =>
                                     hello world!
                                     hello world!
  [1, 2, 3, 4].map {|x| x * x } # => [1, 4, 9, 16]
  [1, 2, 3, 4].select {|x| x > 2 } # => [3, 4]
  (100..1000).step(100).to_a
  # => [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000]
  (1..10).reduce(:+) # => 55
```
---
## Terminal 下__文本处理__
```sh
# 反转文件的每一行 (rev 命令)
cat 1.txt | ruby -lne 'puts $_.reverse'
# 将两个空行换为一个空行.
ruby -e 'STDIN.readlines.join.gsub(/\n\n/, "\n")' 1.txt
# 统计行数. (wc 命令)
ruby -e 'while gets; end; puts $.' 1.txt
# 打印文件前十行 (head 命令)
ruby -pe 'exit if $. > 10' 1.txt
# 打印匹配正则的行 (grep 命令)
ruby -ne 'print if /regex/' 1.txt
```
---

## **FizzBuzz**

homework

>Return "fizz", "buzz" or "fizzbuzz".
>
>For a given natural number greater zero return
>
>"fizz" if the number is dividable by 3
>"buzz" if the number is dividable by 5
>"fizzbuzz" if the number is dividable by 15

<small>**PS: Tdd with rspec, Rake is bonus! **</small>

---

## **Resource**

- https://github.com/jiukunz/tw-ruby-training
- http://tryruby.org/



