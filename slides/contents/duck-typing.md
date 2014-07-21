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

---

## list

1. 及大胖**
2. 张销售
3. xxxx

---

##table

|Name|gender|address|
|---|---|---|
|1|男|ziwei|
|2|女|haha|

----
##fragment
<h2>Vertical Slides</h2>
<p>
    Slides can be nested inside of other slides,
    try pressing <a href="#" class="navigate-down">down</a>.
</p>
<a href="#" class="image navigate-down">
    <img width="178" height="238" src="https://s3.amazonaws.com/hakim-static/reveal-js/arrow.png" alt="Down arrow">
</a>

----

<section id="fragments">
    <h2>Fragmented Views</h2>
    <p>Hit the next arrow...</p>
    <p class="fragment">... to step through ...</p>
    <ol>
        <li class="fragment"><code>any type</code></li>
        <li class="fragment"><em>of view</em></li>
        <li class="fragment"><strong>fragments</strong></li>
    </ol>

    <aside class="notes">
        This slide has fragments which are also stepped through in the notes window.
    </aside>
</section>

---
---------------------
|First Header  | Second Header|
|-------------|:-------------:|
|Content Cell|c|
|Content Cell  | Content Cell|

---