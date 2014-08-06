# Object-oriented programming in Ruby

- Ruby is a genuine object-oriented language
- Everything you manipulate is an object

---

## Class

```ruby
class Person
  def initialize(name)
    @name = name
  end
end

puts Person.new('Xi Qi') # => #<Person:0x007fc623086218>

```

---

### Open Classes/Monkeypatch

> In Ruby, classes are never closed

```ruby
class Person
  def to_s
    "Person #{@name}"
  end
end

puts Person.new("Xi Qi") # => Person Xi Qi
```

---

### Inside Class Definitions

- the class keyword in Ruby is more like a scope operator than a class declaration
- it does create classes that don’t yet exist, but you might argue that it does this as a side effect
- For **class**, the core job is to move you in the context of the class, where you can define methods

```ruby
class Person
  puts "#{self}-#{self.class}-#{self.name}" # => Person-Class-Person
end
```

---

### Inheritance

```ruby
class Programmer < Person
  def code
    "puts 'Hello, World'"
  end
end

p Programmer.superclass # => Person
p Person.superclass # => Object
p Object.superclass # => BasicObject
p BasicObject.superclass # => nil
```
---

## Object

an object simply contains

- its instance variables and
- a reference to its class

---

### Instance Variables

```ruby
class Programmer
  def sleep
    @eyes = 'closed'
  end
end

programmer = Programmer.new('Xi Qi')
p programmer.instance_variables # => [:@name]

programmer.sleep
p programmer.instance_variables # => [:@name, :@eyes]
```

---

## Module

### module methods

```ruby
module MyModule
  def self.meth
    "module methods"
  end
end

p MyModule.meth # => "module methods"
```

---

### Namespaces

```ruby
module MyModule
  MyConstant = 'Outer constant'

  class MyClass
    MyConstant = 'Inner constant'
  end
end

p MyModule::MyConstant # => "Outer constant"
p MyModule::MyClass::MyConstant # => "Inner constant"
p MyModule::MyClass.new # => #<MyModule::MyClass:0x007f881a0a34b8>
```

---

### Mixins

```ruby
module Debug
  def who_am_i?
    "#{self.class.name} (id: #{self.object_id}): #{self.name}"
  end
end

class Phonograph
  include Debug
  attr_reader :name
    def initialize(name)
      @name = name
    end
end

ph = Phonograph.new("West End Blues")
p ph.who_am_i? # => "Phonograph (id: 70166168000260): West End Blues"
```

---

## Practice Time

- Module
- Open Classes

```ruby
p [1,2,3,4,5].sum # =>15
p ('a'..'m').sum # => "abcdefghijklm"
```

---

```ruby
module Summable
  def sum
    inject(:+)
  end
end

class Array
  include Summable
end

class Range
  include Summable
end
```

---

### module Enumerable

```ruby
class Colors
  include Enumerable

  def each
    yield "red"
    yield "green"
    yield "blue"
  end
end

colors = Colors.new
p colors.map(&:reverse) # => ["der", "neerg", "eulb"]
```

---

## Practice Time

- mixin Enumerable
- String#scan

```ruby
finder = VowelFinder.new("the quick brown fox jumped")
p finder.inject(:+) # => "euiooue"
```

---

## Story of `puts`

```ruby
puts "Hello, World"
```

---

### an Object named main

```ruby
puts self # => main
puts self.class # => Object
```

---

### Method Lookup

```ruby
class Programmer < Person
  def code
    "puts 'Hello, World'"
  end
end

xqi = Programmer.new('Xi Qi')
p Programmer.new('Xi Qi').code # => "puts 'Hello, World'"
p xqi.class # => Programmer
```

---

#### a class is an object

```ruby
p "hello".class # => String
p String.class # => Class
p Class.class # => Class
```

```ruby
p Object.superclass # => BasicObject
p BasicObject.superclass # => nil
```

```ruby
p Class.superclass # => Module
p Module.superclass # => Object
```

---
![Object model diagram](https://raw.githubusercontent.com/jiukunz/tw-ruby-training/master/img/object-model-diagram.png)
---

#### `??#puts`

Ruby looks up the method by following the rule

> one step to the right, then up

```ruby
p Object.method(:puts) # => #<Method: Class(Kernel)#puts>
```

---

#### ancestors

```ruby
p Object.ancestors # => [Object, Kernel, BasicObject]

p Kernel.class # => Module
```

---

```ruby
module Debug
  def who_am_i?
    "#{self.class.name} (id: #{self.object_id}): #{self.name}"
  end
end

class Phonograph
  include Debug
  attr_reader :name
    def initialize(name)
      @name = name
    end
end

p Phonograph.ancestors # => [Phonograph, Debug, Object, Kernel, BasicObject]
```

---

#### include classes / proxy classes

When you include a module in a class (or even in another module), Ruby plays a little trick. 

It creates an anonymous class that wraps the module and inserts the anonymous class in the chain, just above the including class itself

---

![Method lookup with modules](https://raw.githubusercontent.com/jiukunz/tw-ruby-training/master/img/method-lookup-with-modules.png)


---

#### Practice Time

`??#new`

---

```ruby
p Object.class.ancestors
# => [Class, Module, Object, Kernel, BasicObject]

p Class.instance_methods(false) # => [:allocate, :new, :superclass]
```

---

### Method Execution

#### receiver

The receiver is simply the object that you call a method on. For example, if you write 

```ruby
my_string.reverse()
```

then `my_string` is the receiver

---

#### self

- Every line of Ruby code is executed inside **current object**
- The current object is also known as self
- when you call a method, the receiver becomes self
- From that moment on, all instance variables are instance variables of self, and
- all methods called without an explicit receiver are called on self

```ruby
class MyClass
  def testing_self
    p self # => #<MyClass:0x007f884b8a35d8>
    @var = 10
    my_method
    self
  end

  def my_method
    @var = @var + 1
  end
end

p self # => main
obj = MyClass.new
p obj # => #<MyClass:0x007f884b8a35d8>
p obj.testing_self # => #<MyClass:0x007f884b8a35d8 @var=11>
```

---

### What private Really Means

```ruby
self.puts 'Hello, World'
# => NoMethodError: private method `puts' called for main:Object
```

private methods come from two rules working together: 

1. you need an explicit receiver to call a method on an object that is not yourself
2. private methods can be called only with an implicit receiver

---

```ruby
class A
  private
  def a_private_method
    puts "a private method"
  end
end


class B < A
  def a_public_method
    a_private_method
  end
end

B.new.a_public_method # => a private method
```

---

## Homework


```ruby
p1 = Person.new("Matz")
p2 = Person.new("Guido")
p3 = Person.new("Larry")
puts [p1, p2, p3].sort # => Guido\nLarry\nMatz
```

---

## References

- http://rubylearning.com/satishtalim/ruby_open_classes.html
- https://en.wikipedia.org/wiki/Object-oriented_programming
- [Metaprogramming Ruby](http://book.douban.com/subject/4086938/)
- [Programming Ruby 1.9 & 2.0 (4th edition): The Pragmatic Programmers' Guide](http://pragprog.com/book/ruby4/programming-ruby-1-9-2-0)
