# split array
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
