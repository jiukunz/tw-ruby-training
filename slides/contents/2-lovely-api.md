# LOVELY **API**
![chicken](https://raw.githubusercontent.com/jiukunz/tw-ruby-training/master/slides/img/chicken.png)

---

#**Agenda**
 - Array
 - Hash
 - Range
 - Enumerable
 - String
 - **CodeWar**

---
#**Array** []
---
##**Array** Creation

```ruby
a = [ 1, "cat", 3.14 ]

puts a[0]          #=> 1
puts a.size        #=> 3

a[3] = nil
puts a.inspect     #=> [1, "cat", nil]

ary = Array.new    #=> []
Array.new(3)       #=> [nil, nil, nil]
Array.new(3, true) #=> [true, true, true]
```
---

##Array **Accessing**
```ruby
arr = [1, 2, 3, 4, 5, 6]
arr[2]             #=> 3
arr[100]           #=> nil
arr[-3]            #=> 4
arr[2, 3]          #=> [3, 4, 5]
arr[1..4]          #=> [2, 3, 4, 5]
arr[1..-3]         #=> [2, 3, 4]
arr.at(0)          #=> 1
```
---

##**Array** Iteration
```ruby
arr = [a,b,c]
arr.each { |x| print x}          #=> abc
arr.reverse_each { |x| print x}  #=> cba
```
---

#Ruby **Map-Reduce**
---

##Array\#**map**
```ruby
a = [ "a", "b", "c", "d" ]
a.collect { |x| x + "!" }        #=> ["a!", "b!", "c!", "d!"]
a.map.with_index{ |x, i| x * i } #=> ["", "b", "cc", "ddd"]
a                                #=> ["a", "b", "c", "d"]
```

---

##Array\#**reduce**
```ruby
# Sum some numbers
(5..10).reduce(:+)                             #=> 45
# Same using a block and inject
(5..10).inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
(5..10).reduce(1, :*)                          #=> 151200
# Same using a block
(5..10).inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear }.inject do |memo, word|
   memo.length > word.length ? memo : word
end
longest                                        #=> "sheep"
```
---

##Array\#**filter**

```ruby
[1,2,3,4,5].select { |num|  num.even?  }   #=> [2, 4]

a = %w{ a b c d e f }
a.select { |v| v =~ /[aeiou]/ }            #=> ["a", "e"]
```
---

#Array as **Stack**

##Array\#pop
```ruby
a = [ "a", "b", "c", "d" ]
a.pop     #=> "d"
a.pop(2)  #=> ["b", "c"]
a         #=> ["a"]
```

##Array\#push
```ruby
a = [ "a", "b", "c" ]
a.push("d", "e", "f")
        #=> ["a", "b", "c", "d", "e", "f"]
[1, 2, 3,].push(4).push(5)
        #=> [1, 2, 3, 4, 5]
```

---

#**Hash** {}
---

##**Hash** Creation&Access
```ruby
grades = { "Jane Doe" => 10, "Jim Doe" => 6 }
options = { :font_size => 10, :font_family => "Arial" }

grades = Hash.new
grades["Dorothy Doe"] = 9
```
---

##**Hash** Iteration

```ruby
books = {
    :matz => "The Ruby Language",
    :black => "The Well-Grounded Rubyist"
}
books.each { |author, name| puts "#{author}: #{name}" }
```

---
##Keyword **Arguments** With Hashes
```ruby
class Person
  attr_accessor :first, :last, :weight, :height

  def initialize(params = {})
    @first = params[:first]
    @last = params[:last]
    @weight = params[:weight]
    @height = params[:height]
  end
end

p = Person.new(
    height: "170cm",
    weight: 72,
    last: 'Doe',
    first: 'John'
)
```
---

##Keyword **Arguments**
```ruby
def foo(str: "foo", num: 424242)
  [str, num]
end

foo(str: 'buz', num: 9) #=> ['buz', 9]
foo(str: 'bar')         # => ['bar', 424242]
foo                     # => ['foo', 424242]
foo(bar: 'buz')         # => ArgumentError
```
- **Only after Ruby 2.0**

- http://brainspec.com/blog/2012/10/08/keyword-arguments-ruby-2-0/

---
#**Range** (1..99)
```ruby
(0...10).map{ ('a'..'z').to_a[rand(26)] }.join
```
---
#**Enumerable**
---
##\#all
```ruby
%w[ant bear cat].all? { |word| word.length >= 3 } #=> true
%w[ant bear cat].all? { |word| word.length >= 4 } #=> false
[nil, true, 99].all?                              #=> false
```
##\#any
```ruby
%w[ant bear cat].any? { |word| word.length >= 3 } #=> true
%w[ant bear cat].any? { |word| word.length >= 4 } #=> true
[nil, true, 99].any?                              #=> true
```
---
##\#count
```ruby
ary = [1, 2, 4, 2]
ary.count               #=> 4
ary.count(2)            #=> 2
ary.count{ |x| x%2==0 } #=> 3
```
---
#**String**

 - Difference between " " and ' '
 - Difference between **puts** and **print** and **p**

```ruby
class M
  def to_s
    p "hahahah"
  end
end

puts M.new  #=> "hahahah"
p M.new     #<M:0x007fc429b904e8>
```

---

##Make String Longer
```ruby
"Ho! " * 3     #=> "Ho! Ho! Ho! "
"Ho! " * 0     #=> ""

a = "hello "
a << "world"   #=> "hello world"
a.concat(33)   #=> "hello world!"
```
---

##Make String as **Array**
```ruby
"qixi".chars                           #=>["q", "i", "x", "i"]
"hello".each_char {|c| print c, ' ' }  #=>"hello"
```
And then, you can use all the methods in **Array**!

---
##Powerful **gsub**/sub
```ruby
"hello".gsub(/[aeiou]/, '*')             #=> "h*ll*"
"hello".gsub(/([aeiou])/, '<\1>')
                                         #=> "h<e>ll<o>"
"hello".gsub(/./) {|s| s.ord.to_s + ' '}
                                         #=> "104 101 108 108 111 "
"hello".gsub(/(?<foo>[aeiou])/, '{\k<foo>}')
                                         #=> "h{e}ll{o}"
'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')
                                         #=> "h3ll*"
"quick brown fox".gsub(/[aeiou]/) {|vowel| vowel.upcase }
                                         #=> "qUIck brOwn fOx"
```
---

##Another **kind** of String

> Symbols are immutable. Mutable objects can be changed after assignment while immutable objects can only be overwritten

```ruby
"I am Ruby developer".to_sym  #=> :"I am Ruby developer"
:"I am Ruby developer".to_s   #=> "I am Ruby developer"
```

**Use symbol when possible!**

---

##**Convert**
```ruby

#to complex
'-3/2'.to_c              #=> ((-3/2)+0i)
'-i'.to_c                #=> (0-1i)

#to float
"123.45e1".to_f          #=> 1234.5
"45.67 degrees".to_f     #=> 45.67

#to fixnum
"1100101".to_i(8)        #=> 294977
"99 red balloons".to_i   #=> 99

##fixnum to string
123.to_s(2)              #=> "1111011"
```
---

# **Codewar** TIME
![cowboy](https://raw.githubusercontent.com/jiukunz/tw-ruby-training/master/slides/img/cowboy.png)
---
## Example: **We need prime numbers and we need them now!**

Write a method that takes a maximum bound and returns all primes starting with 0 up-to and including the maximum bound.

For example:

```ruby
prime(11);
```

Should return an array that looks like this:

```ruby
[2,3,5,7,11]
```

---

## Answer 1
```ruby
def prime(n)
    (2..n).reject do |i|
        (2...i).any?{|o| i % o == 0}
    end
end
```

---
## Answer 2
```ruby
def prime(n)
  (2..n).select { |p| is_prime? p }
end

def is_prime?(x)
  (2...x).none? { |d| x % d == 0 }
end
```

---
## Answer 3
```ruby
require 'prime'
def prime(n)
  result = []
  Prime.each(n) do |prime|
    result << prime
  end
  result
end
```
---
##**Palindromes Below**
Description:

- The aim of this Kata is to modify the Fixnum class to give it the palindrome_below method. This method returns all numbers from and including 1 up to but not including itself that are palindromes for a given base.
---
##**Palindromes Below**
- For example in base 2 (binary)
```ruby
1 = "1"
2 = "10"
3 = "11"
4 = "100"
```
- Therefore 1 and 3 are palindromes in base two and the method should return the following.
```ruby
5.palindrome_below(2)
=> [1, 3]
```
---
##**Blackjack Scorer**
Description:

1. Write a function called scoreHand that determines the score of a hand in the card game Blackjack (aka 21).
2. This function takes one parameter which is an array of strings that represent each card in the hand. Each card will be one of the following strings: "2",..,"10", "J", "Q", "K", "A"
3. It returns a number which is the score of the hand. Return the highest score of the cards that is less than or equal to 21. If there is no score less than or euqal to 21 return the smallest score more than 21.
4. Scoring rules: In Blackjack number cards count as their face value (2 through 10). Jack, Queen and King count as 10. An Ace can be counted as either 1 or 11.

---
##**Blackjack Scorer** Examples

```ruby
scoreHand(["A"]); //=> 11
scoreHand(["A", "J"]); //=> 21

scoreHand(["A", "10", "A"]); //=> 12
scoreHand(["5", "3", "7"]); //=> 15
scoreHand(["5", "4", "3", "2", "A", "K"]); //=> 25
```
---
##**Split hash by key(s)**
Description:

- Write a method which takes arguments:

 - hash
 - keys (comma-separated symbols or strings)

- and it splits hash by given keys and returns array of hashes.
- If a key given as an argument is not present in the hash, the method should raise an exception
- In case there are any empty hash after splitting, it should be removed from resultant array.

---
##For example:
```ruby
# returns [ {:a=>1, :b=>2}, {:c=>3, :d=>4}, {:e=>5, :f=>6} ]
split_hash_by_key( { :a=>1, :b=>2, :c=>3, :d=>4, :e=>5, :f=>6 }, :c, :e )

#returns [ {:a=>1}, {:b=>2, :c=>3, :d=>4, :e=>5}, {:f=>6} ]
split_hash_by_key( { :a=>1, :b=>2, :c=>3, :d=>4, :e=>5, :f=>6 }, :b, :f )

#returns [ {"a"=>1, "b"=>2, "c"=>3}, {"d"=>4, "e"=>5, "f"=>6} ]
split_hash_by_key( { 'a'=>1, 'b'=>2, 'c'=>3, 'd'=>4, 'e'=>5, 'f'=>6 }, 'd' )

#returns [ {:a => 1, :b => 2} ]
split_hash_by_key( {:a => 1, :b => 2}, :a )

# raises an exception
split_hash_by_key( { :a=>1, :b=>2, :c=>3, :d=>4, :e=>5, :f=>6 }, 'b' )
```
---
#**Win the CodeWar!**

homework

