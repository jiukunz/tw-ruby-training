# VowelFinder

```ruby
class VowelFinder
  include Enumerable

  def initialize(arg)
    @arg = arg
    @enum = arg.scan(/[aeiou]/).to_enum
  end

  def each
    loop do
      yield @enum.next
    end
  end
end

finder = VowelFinder.new("the quick brown fox jumped")
p finder.inject(:+) # => "euiooue"
```
