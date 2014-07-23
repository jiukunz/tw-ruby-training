#Palindromes Below
```
class Fixnum 
  def palindrome_below i
    (1...self).select{|f| f.to_s(i) == f.to_s(i).reverse}
  end  
end
```
```
class Fixnum
  def palindrome_below2(base)
    array = (1...self).map {|x| x.to_s(base) }
    result = array.inject([]) {|a, e| a << e if (0..e.length/2).all? {|x| e[x] == e[-x-1] }; a }
    result.map {|e| e.to_i(base) }
  end
end
```
---

#Blackjack Scorer
```
def black_jack cards
  x = cards.select { |x| x!="A" }.reduce(0) do |a, s|
    if "JQK".include? s
      a+10
    else
      a+s.to_i
    end
  end

  count = cards.count("A")

  if x+count <= 11
    x+count+10
  elsif x+count
  end
end
```

```
require 'minitest/autorun'
require 'minitest/pride'

describe "BlackJack" do
  specify { score_hand("A").must_equal 11 }
  specify { score_hand("A", "J").must_equal 21 }
  specify { score_hand("A", "10", "A").must_equal 12 }
  specify { score_hand("5", "3", "7").must_equal 15 }
  specify { score_hand("1", "2", "3").must_equal 6 }
  specify { score_hand("J", "5").must_equal 15 }
  specify { score_hand("5", "4", "3", "2", "A", "K").must_equal 25 }
end


RULES = {
  "1" => [1],
  "2" => [2],
  "3" => [3],
  "4" => [4],
  "5" => [5],
  "6" => [6],
  "7" => [7],
  "8" => [8],
  "9" => [9],
  "10" => [10],
  "J" => [10],
  "Q" => [10],
  "K" => [10],
  "A" => [1, 10]
}

def score_hand(*args)
  result = args.inject(0) do |a, e|
    a + RULES[e].first
  end
  result += RULES["A"][1] if result <= 11 and args.include? "A"
  result
end

```
---
Split hash by key

```
require 'minitest/autorun'
require 'minitest/pride'

describe "split hash by key" do
  specify { split_hash_by_key( { :a=>1, :b=>2, :c=>3, :d=>4, :e=>5, :f=>6 }, :b, :f).must_equal [ {:a=>1}, {:b=>2, :c=>3, :d=>4, :e=>5}, {:f=>6} ] }
end

def split_hash_by_key(hashs, *args)
  keys = hashs.keys
  array = args.map {|e| keys.shift(keys.index(e))}.concat([keys])
  array.map {|e| e.map {|x| [x, hashs[x]] } }.map {|e| Hash[e] }
end
```
