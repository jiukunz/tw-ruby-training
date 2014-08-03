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
## **yield (给予 + 收益)**

---
### We can yield some **data** to block.
```ruby
def meth
  yield 1, 2, 3 if block_given?
end
```
### And expect some **value** to be return.

```ruby
p meth {|x, y, z| x + y + z } # => ??
```
---
## What really does **yield** ?
```ruby
def meth; yield [1, 2, 3] end

meth {|x, y, z| x + y + z } # => 6
```
- yield **[1, 2, 3]** to block, also **BLOCK** this method.

- block take data with **parallel assignment**<br />
  x, y, z = [1, 2, 3] # => x=1, y=2, z=3

- execute block logic.

- return result value to **yield**.

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
### How to pass in a **predefine** block ?
```ruby
[1, 2, 3, 4].filter &some_block
```
---
### We can **blockfy** a Proc object
```ruby
one_proc = proc {|e| e >= 3 }

[1, 2, 3, 4].filter(&one_proc)
```
### with the **&** notation in **argument**.
### [1, 2, 3, 4].filter(**&one_proc**)
---
### We can **objectfy** block as a Proc object
```ruby
def meth(&block)
  p block.class
end

meth {}         # => Proc < Object
```
### with the **&** notation in **parameter**.
### def meth(**&block**)
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
# pass x >= 2 into select method
[1, 2, 3, 4].select {|x| x >= 2 }
```
### Expect a meaningful **value** to be return.

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

p one_lambda            # => #<Proc:0x007fd74b872498 (lambda)>
p one_lambda.lambda?    # => true

p one_proc              # => #<Proc:0x007fd74b872470>
p one_proc.lambda?      # => false
```
---
### **proc** is **objectfied** block.
```ruby
def meth(&proc_object)
  p proc_object         # => a proc object.
end

meth { 100 }             # => proc is { 100 }
```
### **lambda** is **objectfied** method.
```ruby
method(:meth).to_proc   # => a lambda object.
```
---
### **NEVER** pass lambda as block
## make **confused**!
---
## Reason one:
```ruby
one_lambda = lambda {|x, y| x + y }
one_proc = proc {|x, y| x + y }

[[1, 2], [3, 4]].map &one_lambda
# => wrong number of arguments (1 for 2) (ArgumentError)

[[1, 2], [3, 4]].map &one_proc
# => [3, 7]
```
---
## Reason two:
```ruby
one_lambda = lambda { return 100 }
one_proc = proc { return 100 }

def meth(&block)
  block.call
end

# lambda only return block to block.call
meth(&one_lambda)       # => 100

# proc return outer method which meth exist.
meth(&one_proc)         # => unexpected return (LocalJumpError)
```
---
### We should use lambda as **JavaScript**:
```
def meth(lambda_arg)
  lambda_arg.call(100)
end

meth(lambda {|x| x })           # => 100
meth -> (x) { return x }        # => 1.9 new lambda
```
```js
meth(function (x) { return x }) # => Javascript
meth (x) -> x                   # => Coffee
```
---
### We can use **lambda + block** together.
```ruby
def meth(lambda_param)
  yield lambda_param
end

meth(-> (x) { x + x }) {|x| x.call(100) }       # => ???
```
---
### average split a array. (use each)
1. Given array = (1..100).to_a
2. Split array to N part, each part should have as avarage as amount element.
3. Array element can be arbitrary.

```ruby
array = (1..10).to_a
split_array(array, 3)   # => [[1, 4, 7, 10], [2, 5, 8], [3, 6, 9]]
```
---
# Homework
1. Array#group_by1, Array#inject1.

2. convert a number to Roman notation. (use each + recursion)
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
