# **Ruby** and its fellows

----

# Ruby at a Glance

- a Programming Language
- Open Source
- Designed by Yukihiro Matsumoto
- Appeared in 1995
- Stable release 2.1.2 / May 9, 2014
- Cross-platform

---

# Ruby Features

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

# RubyGems

- a Package Manager
- part of the standard library from Ruby version 1.9
- 78,439 gems hosted on RubyGems.org on Jul 15, 2014
- gem command
  - `gem search rspec`
  - `gem install rspec`
  - `gem list`
  - `gem list rspec -d`
  - `gem uninstall rspec`
  - `gem environment gemdir`

---

# What is a gem?

Inside a gems are the following components:

* Code (including tests and supporting utilities)
* Documentation
* gemspec

Each gem follows the same standard structure of code organization:

```
% tree freewill
freewill/
├── bin/
│   └── freewill
├── lib/
│   └── freewill.rb
├── test/
│   └── test_freewill.rb
├── README
├── Rakefile
└── freewill.gemspec
```

---

# Rake

---

# bundle

---

# rbenv/rvm

---

#REPL -- pry 

---

# rspec概念, SPEC  代码show一下

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
  (100..1000).step(100).inject([]) {|a, e| a << e }
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





