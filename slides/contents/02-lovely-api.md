# LOVELY **API**
![chicken](../img/chicken.png)
---
#**Array** []
---
##**Array** Creating

```
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
```
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

##Array\#each/reverse_each
```
arr = [a,b,c]
arr.each { |x| print x}          #=> abc
arr.reverse_each { |x| print x}  #=> cba
```
---

#Ruby **Functional** Programming
---

##Array\#**map**
```
a = [ "a", "b", "c", "d" ]
a.collect { |x| x + "!" }        #=> ["a!", "b!", "c!", "d!"]
a.map.with_index{ |x, i| x * i } #=> ["", "b", "cc", "ddd"]
a                                #=> ["a", "b", "c", "d"]
```

---

##Array\#**reduce**
```
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

```
[1,2,3,4,5].select { |num|  num.even?  }   #=> [2, 4]

a = %w{ a b c d e f }
a.select { |v| v =~ /[aeiou]/ }            #=> ["a", "e"]
```
---

#Array as **Stack**

##Array\#pop
```
a = [ "a", "b", "c", "d" ]
a.pop     #=> "d"
a.pop(2)  #=> ["b", "c"]
a         #=> ["a"]
```

##Array\#push
```
a = [ "a", "b", "c" ]
a.push("d", "e", "f")
        #=> ["a", "b", "c", "d", "e", "f"]
[1, 2, 3,].push(4).push(5)
        #=> [1, 2, 3, 4, 5]
```

---

##Hash

---

#**String** 
 - Difference between " " and ' '
 - Difference between **puts** and **print** and **p**
 
```
class M
    def to_s
        "hahahah"
    end
end

puts M.new       #=> #<M:0x007fc429b904e8>
p M.new          #=> "hahahah"
```

---

##Make String Longer
```
"Ho! " * 3     #=> "Ho! Ho! Ho! "
"Ho! " * 0     #=> ""

a = "hello "
a << "world"   #=> "hello world"
a.concat(33)   #=> "hello world!"
```

---

##Make String as **Array**
```
"qixi".chars                           #=>["q", "i", "x", "i"]
"hello".each_char {|c| print c, ' ' }  #=>"hello"

```
And then, you can use all the methods in **Array**!

---
##Powerful **gsub**
```
"hello".gsub(/[aeiou]/, '*')                  #=> "h*ll*"
"hello".gsub(/([aeiou])/, '<\1>')             #=> "h<e>ll<o>"
"hello".gsub(/./) {|s| s.ord.to_s + ' '}      #=> "104 101 108 108 111 "
"hello".gsub(/(?<foo>[aeiou])/, '{\k<foo>}')  #=> "h{e}ll{o}"
'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')    #=> "h3ll*"
```
---

##Another **'kind'** of String

> Symbols are immutable. Mutable objects can be changed after assignment while immutable objects can only be overwritten

```
"I am Ruby developer".to_sym  #=> :"I am Ruby developer"
:"I am Ruby developer".to_s   #=> "I am Ruby developer"
```

**Use symbol when possible!**

---

##**Convert**
```

#to complex
'-3/2'.to_c              #=> ((-3/2)+0i)
'-i'.to_c                #=> (0-1i)

#to float
"123.45e1".to_f          #=> 1234.5
"45.67 degrees".to_f     #=> 45.67

#to integer
"1100101".to_i(8)        #=> 294977
"99 red balloons".to_i   #=> 99
```
---

# **Codewar** TIME
![cowboy](../img/cowboy.png)
---
## Example: **We need prime numbers and we need them now!**

Write a method that takes a maximum bound and returns all primes starting with 0 up-to and including the maximum bound.

For example:

```
prime(11);
```

Should return an array that looks like this:

```
[2,3,5,7,11]
```

---

## Answer 1
```
def prime(n)
    (2..n).reject do |i|
        (2...i).any?{|o| i % o == 0}
    end
end
```

---
## Answer 2
```
def prime(n)
  (2..n).select { |p| is_prime? p }
end

def is_prime?(x)
  (2...x).none? { |d| x % d == 0 }
end
```

---
## Answer 3
```
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
```
1 = "1"
2 = "10"
3 = "11"
4 = "100"
```
- Therefore 1 and 3 are palindromes in base two and the method should return the following.
```
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

```
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
```
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

##**Luck check**
Description:

- In some countries of former Soviet Union there was a belief about lucky tickets. A transport ticket of any sort was believed to posess luck if sum of digits on the left half of its number was equal to the sum of digits on the right half. Here are examples of such numbers:
```
003111    #         3 = 1 + 1 + 1
813372    # 8 + 1 + 3 = 3 + 7 + 2
17935     #     1 + 7 = 3 + 5
56328116
```
---
##**Luck check**
- Such tickets were either eaten after being used or collected for bragging rights.
- Your task is to write a funtion `luck_check(str)`, which returns `true` if argument is string decimal representation of a lucky ticket number, or `false` for all other numbers. It should handle errors for empty strings or strings which don't represent a decimal number
---
#Homework
    
**作业: 使用 each 来自己实现 select, map, reduce**

