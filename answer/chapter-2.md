#Palindromes Below
```
class Fixnum 
  def palindrome_below i
    (1...self).select{|f| f.to_s(i) == f.to_s(i).reverse}
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