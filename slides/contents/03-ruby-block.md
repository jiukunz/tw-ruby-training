# **Ruby Block**
---
### Block is **part of** method in Ruby.
---
### You can give **ANY** method a block,
### Whether you use it or not.
```ruby
def meth
end
meth { "Where block code live in" }
```
---
### One method have **one** and **only one** block.
```ruby
meth {} {} # => syntax error
```
---
### Block **very close** binding with this method.
```ruby
p meth {} # <=> p (meth {})

```
### priority **TOP 3** in Ruby:
**()** > **{** > **.** == **::**
---
## How to **USE** block?
---
# **yield (让 + 予)**
---
### We can yield some **data** to block.
```ruby
def meth
  yield 1, 2, 3 if block_given?
end
```
### And expect return some **value**.

```ruby
p meth {|x, y, z| x + y + z } # => ??
```
---
## What really does **yield** ?
```ruby
def meth; yield [1, 2, 3] end
meth {|x, y, z| x + y + z } # => 6
```
- pass **[1, 2, 3]** to block, and **BLOCK** method.
  
- block take data with **parallel assignment**<br />
  x, y, z = [1, 2, 3] # => x=1, y=2, z=3
  
- do block logic.

- return result value to yield. (**NOT** return to method)

- **RESUME** from yield, continue execute The rest statement of method.
---
### Write Enumerable#select youself ##
1. We have Array#each be implemented.
2. use Array#each, implement a **filter** method for Array.

```ruby
[1, 2, 3, 4].filter {|e| e >= 2 } # => [2, 3, 4]
```
---
```ruby
class Array
  def filter
    return self.to_enum(:filter) unless block_given?

    array = []
    self.each {|e| array << e if yield e }
    array
  end
end

p [1, 2, 3, 4].filter {|e| e >= 3 }     # => [2, 3, 4]
p [1, 2, 3, 4].filter                   # => #<Enumerator: [1, 2, 3, 4]:filter>
```
---
### We need pass in a **predefine** block
```ruby
p [1, 2, 3, 4].filter &block
```
---
### We can **objectfy** block as a Proc object
```ruby
def meth(&block)
  p block.class
end

meth {}         # => Proc < Object
```
### with the **address** notation in parameter.
---
### We can **blockfy** a Proc object
```ruby
one_proc = proc {|x, y, z| x + y + z }
meth(&new_proc)         # => 6

another_proc = proc {|e| e >= 3 }
[1, 2, 3, 4].filter(&another_proc)
```
### with the **address** notation in argument.
---
### Use **Proc#call** to call the block
### with arguments passed into block
```ruby
def meth1(&block)
  block.call(1, 2, 3)   # => slower
end

def meth2
  yield 1, 2, 3         # => more faster.
end

require 'fruity'
compare do
  slower { meth1 {|x, y, z| x + y + z } }
  faster { meth2 {|x, y, z| x + y + z } }
end
# Running each test 32768 times. Test will take about 1 second.
# faster is faster than slower by 8x ± 1.0
```
---
## Where **block** to use?
---
### **Break** method encapsulation, pass in logic.
```ruby
# pass x >= 2(one logic) into select method
[1, 2, 3, 4].select {|x| x >= 2 }
```
### (Maybe) expect a meaningful **return value**
```ruby
[1, 2, 3, 4].map {|x| x * x }   # => [1, 4, 9, 16]
```
---
### **Side effect**.
```ruby
[1, 2, 3, 4].each {|x| puts x }
```

```ruby
def fetch
  while some_condition
    yield http_fetch(5000)
  end
end

fetch {|data| import(data) }
```
---
### Write DSL with instance_eval
```ruby
class SomeClass
  def self.run(&block)
    new.instance_eval(&block)
  end

  def do_one_thing; ... end

  def do_another_thing; ... end
end

SomeClass.run do
  do_one_thing
  do_another_thing
end
```
---
## Where is **lambda**?
## AKA: **higher-order function**
---
## lambda is kind of Proc
```ruby
one_lambda = lambda {}
one_proc = proc {}

p one_lambda    # => #<Proc:0x007fd74b872498 (lambda)>
p one_proc      # => #<Proc:0x007fd74b872470>
```
---
### **proc** is **objectfied** block.
### **lambda** is **objectfied** method.
---
### **NEVER** pass lambda as block, make **confused**!
```ruby
one_lambda = lambda {|x, y| x + y }
one_proc = proc {|x, y| x + y }

def meth(&block)
 p block
 p block.call([10, 20])
end

meth(&one_lambda)
# => #<Proc:0x007fbd0b872380 lambda>
# => wrong number of arguments (1 for 2) (ArgumentError)
meth(&one_proc)
# => #<Proc:0x007fb0f2075f58>
# => 30
```
---
### Another difference:
```ruby
one_lambda = lambda { return 100 }
one_proc = proc { return 100 }

def meth(&block)
  p block.call
end

meth(&one_lambda)               # => 100
meth(&one_proc)                 # => unexpected return (LocalJumpError)
another_proc = proc { next 100 }
meth(&another_proc)             # => 100
```
---
### We can use **lambda + block** together.
```ruby
def meth(lambda_param)
  yield lambda_param
end

meth(lambda { 100 }) {|x| x.call }       # => 100
```
---
# Homework
1. Array#group_by1, Array#inject1.
2. convert a number to Roman notation. (use block)

    "M"         => 1000,
    "CM"        => 900,
    "D"         => 500,
    "CD"        => 400,
    "C"         => 100,
    "XC"        => 90,
    "L"         => 50,
    "XL"        => 40,
    "X"         => 10,
    "IX"        => 9,
    "V"         => 5,
    "IV"        => 4,
    "I"         => 1

```ruby
Roman.encode(1234)     # => "MCCXXXIV"
Roman.encode(2014)     # => "MMXIV"
```
