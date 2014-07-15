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

# 神奇的 == ##
```ruby
require 'bcrypt'
include BCrypt
password = Password.create('hello')
p password == 'hello'
# p password
```
---
# 奇妙的 case/when ##
```ruby
class String
  def ===(other)
    return true if self[0].casecmp other[0]
  end
end
x = "hello"
case x
when "hello", "Hello", "helle"
  puts "相等"
when "bello", "ball"
  puts "不相等"
end
```
---
# 字符串的 [] 方法. 
```ruby
str = "hello"
str[/(he)llo/, 1]
str[0..3]
str[1...-1]
```
---
# 计算: 1m/4 + 10cm * 3 - 5mm
```ruby
# open class, 甚至 Fixnum (核心类) 也不例外.

class Fixnum
  def m; 1000 end
  
  def cm; 10 end
  
  def mm; 1 end
end

1.m/4 + 10.cm * 3 - 5.mm
```
---
# 可以处理任意大的整数.
```ruby
2**10000 # ....
```
---
# 并行赋值
```ruby
a, b = b, a, # 并行赋值同时发生, 可以用来交换 a 和 b
a, (b, (c, d)) = [1, [2, [3, 4]]]
```
---
# splat 参数.
```ruby
def meth(*args)
  p args
end

args = [1, 2, 3, 4]

meth(*args) # 等价于 meth(1, 2, 3, 4), 输出结果: [1, 2, 3, 4]
```
---
# 迭代器方法
```ruby
  10.times do
    # do something
  end

  (100..1000).step(100) {|x| p x }
```
---
# 强大的正则
```ruby
# 处理回文
"`abba' is a palindromes".match(/(.)(.)\k<-1>\k<-2>/)

# 匹配汉字
"one 汉字".match(/\p{han}/)
```
---
# 取代 awk, sed, perl.
```sh
# 在 Terminal 下, 用一行 Ruby 代码实现 rev 命令. (反转文件的每一行.)
cat 1.txt |ruby -lne 'puts $_.reverse'
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





