# Meta Programming

> *What is meta programming?*

---

# Basic

---

## Meta Programming

- *Metaprogramming is writing code that writes code.*

---

## Example One

```ruby
class Person
  def name=(value)
    @name = value
  end

  def name
    @name
  end
end

person = Person.new
person.name = "ruby"
puts person.name # => ruby

```

---

## Example Two

```ruby
class Person
  attr_accessor :name
end
person = Person.new
person.name = "ruby"
puts person.name # => ruby

```

---

## Meta Programming

- *Metaprogramming is writing code that manipulates language constructs at runtime.*

---

## Practice Time

- use :attr_reader, :attr_writer, :attr_accessor to implement following class

```ruby
class Girl
  def initialize()
    self.gender = 'female'
  end
  def name=(value)
    @name = value
  end
  def name
    @name
  end
  def age=(value)
    @age = value
  end
  def gender
    @gender
  end
end
```

---

# Advance

---

## Block is not a object

- Everything you manipulate is an object, **except block**

---

## :send

- Call a dynamic method
- You can call private method by :send

```ruby
puts "123" # => 123
send(:puts, 123) => 123
```

---

## :respond_to?

- Check if respond specific method

```ruby
'Qi Xi'.respond_to?(:chun_ye_men) # => false
'Mao Chao'.respond_to?(:handsome) #=> true
```

---

## :method_missing

- When ruby can't find a method, it will call :method_missing
- If you override :method_missing, you never get NoMethodError

```ruby
class Lawyer
  def method_missing(method, *args)
    puts "You called: #{method}(#{args.join(', ')})"
  end
end
Lawyer.new.blah_blah # => You called: blah_blah()

```

---

## :define_method

- Module#define_method
- A method to let you define a method
- You can only call it in class/module

```ruby
class Person
  def name=(value)
    @name = value
  end

  define_method "name=" do |value|
    @name = value
  end
end
```

---

# Expert

---

## Class of class is class

```ruby
class A ;end

A.new.class #=> A
A.class #=> Class
Class.class #=> Class
```

---

## Closure

- You can reference variable in other environment(binding in ruby)

```ruby
def my_method
  x = "Goodbye"
  yield("cruel")
end
x = "Hello"
my_method {|y| "#{x}, #{y} world" } # => "Hello, cruel world"
```

---

## Scope

- local variables, current object and self

```ruby
v1 = 1
class MyClass
  v2 = 2
  Kernel.local_variables # => [:v2]

  def my_method
    v3 = 3
    Kernel.local_variables
  end

  Kernel.local_variables # => [:v2]
end
obj = MyClass.new
obj.my_method # => [:v3]
obj.my_method # => [:v3]
local_variables # => [:v1, :obj]

```

---

## Changing Scope

- :def, :module and :class will change scope

```ruby
v1 = 1
class MyClass   # SCOPE GATE: entering class
  v2 = 2
  Kernel.local_variables # => [:v2]

  def my_method # SCOPE GATE: entering def
    v3 = 3
  end           # SCOPE GATE: leaving def

  Kernel.local_variables # => [:v2]
end             # SCOPE GATE: leaving class

```

---

## :define_method change scope?

```ruby
v1 = 1
class MyClass
  v2 = 2

  define_method :my_method do # SCOPE GATE ?
    v3 = 3
  end
end
```
---

## Changing Scope

- :define_method, Module.new and Class.new will change scope

```ruby
v1 = 1
class MyClass   # SCOPE GATE: entering class
  v2 = 2

  define_method :my_method do # SCOPE GATE: entering def
    v3 = 3
  end           # SCOPE GATE: leaving def

end             # SCOPE GATE: leaving class

```

---

## :instance_eval

- Object#instance_eval
- evaluate a block in the context of an object

```ruby
class MyClass
  def initialize
    @v = 1
  end
end
obj = MyClass.new
obj.instance_eval do
  self # => #<MyClass:0x3340dc @v=1>
  @v # => 1
end
v=2
obj.instance_eval { @v = v } # change scope?
obj.instance_eval { @v } # => 2

```

---

## :class_eval

- Module#class_eval
- evaluate a block in the context of an class

```ruby
def add_method_to(a_class)
   a_class.class_eval do
     def m; 'Hello!'; end
   end
￼end
add_method_to String
"abc".m # => "Hello!"
```

---

## Practice Time

- Implement following 3 methods

```ruby
class Girl
  def self.my_attr_assessor; end
  def self.my_attr_writer; end
  def self.my_attr_reader; end
  my_attr_assessor :name
  my_attr_writer :age
  my_attr_reader :gender

  def initialize()
    self.gender = 'female'
  end
end

```

---

## Pay Attention

- Meta programming is black magic, you can easily fool others and yourself
- It's important in building DSL

---

## Homework

> Read Metaprogramming Ruby Chapter 1, 2 and 3 in 1 weeks

---

## References

- [Metaprogramming Ruby](http://book.douban.com/subject/4086938/)
