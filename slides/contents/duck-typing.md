##动态类型(**duck** typing)
<small>会呱呱叫的就是鸭子</small>
```
# 鸭子
class Duck
  def quack
    puts "quack!"
  end
end

# 野鸭，不用继承
class Mallard
  def quack
    puts "qwuaacck!! quak!"
  end
end
```

---

## Class 不是 Type

<small>⼀个对象可以做什么才是重点</small>
```
birds = [Duck.new, Mallard.new, Object.new]
# 迭代数组，并调用方法 (无须担心类型)
birds.each do |duck|
    duck.quack if duck.respond_to? :quack
end
```

----

##**Duck** Typing
<small>(from wikipedia)</small>
>duck typing is a style of dynamic typing in 
>which **an object's methods and properties 
>determine the valid semantics**, rather than 
>its inheritance from a particular class or 
>implementation of a speciﬁc interface
