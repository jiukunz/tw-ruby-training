# split array

```ruby
array = (1..10).to_a

def split_array(array, n)
  hash = {}
  
  array.each do |e|
    hash[e%n] ||= []
    hash[e%n] << e
  end
  
  hash.values
end

p split_array(array, 3)
```

# group_by1
```
class Array
  def group_by1
    hash = {}
    self.each do |e|
      key = yield e
      hash[key] ||= []
      hash[key] << e
    end
    hash
  end
end


require 'minitest/autorun'
require 'minitest/pride'

describe "" do
  specify do
    ([1, 2, 3, 4].group_by1 {|x| x > 2 }).must_equal({false => [1, 2], true => [3, 4]})
  end
end
```
# inject1

```ruby
class Array
  def inject1(arg=shift)
    if arg.is_a? Symbol
      a = self.shift
      each {|e| a = a.send(arg, e) }
    else
      a = arg
      each {|e| a = yield a, e }
    end
    a
  end
end

p [1, 2, 3, 4].inject(:+)
p [1, 2, 3, 4].inject1 {|a, x| a + x }
```
# Roman

```ruby
class Roman
  @hash = {
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
  }

  def self.encode(value)
    return "" if value == 0
    @hash.each do |roman, num|
      if value >= num
        return roman + encode(value-num)
      end
    end
  end
end

p Roman.encode(1024)
```
