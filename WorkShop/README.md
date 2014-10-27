RubyConf-WorkShop
=================

Repository for workshop of Ruby China Conference 2014

#银河计算器

####以下为最高机密，请在阅后10分钟内清除
10分钟之前，接到NASA的密电，在太平洋海域又发生一起爆炸，疑似与马航MH370、MH17、阿尔及利亚AH5017号失事时检测到的噪音余波拥有同一来源。

在马航MH370失事前，NASA截获了一个信号`"1"`，之后的也接收到了`1`次余波，之后的AH5017与MH17，分别截获了`"13"`和“`"1+2"`，也同样探测到了`13`和`3`场余波。经过声纹分析得知，这是来自银河系太阳系外的一种远程武器，于是NASA紧急反向工程研制了对抗装置，但是由于威力过大，需要精确计量，我们作为特聘顾问，需要为其定制精确的分析工具。

目前，新的信号正在不断被截获，发送频率愈来愈高，而且正从太平洋转移到欧亚大陆，所以我们时间紧迫。

##Task 1
###读取单个的数字
 ```
	assert('one digit') { Calc.eval('1') == 1 }
	assert('multiple digits') { Calc.eval('13') == 13 }
 ```
##Task 2
###一对数字的运算
 ```
    assert('plus') {Calc.eval('1+2') == 3 }
    assert('minus') {Calc.eval('1-1') == 0 }
    assert('multiply') {Calc.eval('2*1') == 2 }
    assert('divide') {Calc.eval('4/2') == 2 }
```
###特例，减法也无法获得负数
```
    assert('minus') {Calc.eval('3-5') == 0 }
    assert('minus') {Calc.eval('4-10') == 0 }
```
##Task 3
###多个运算（不带优先级）

```
	assert('without priority') { Calc.eval('1-1+1') == 1 }
    assert('without priority') { Calc.eval('1-1+1+3') == 4 }
```
##Task 4
###多个运算（带优先级）
```
    assert('with priority') { Calc.eval('2+4/2') == 4 }
    assert('with priority') { Calc.eval('3-6/2') == 0 }
```
##Task Extra
###带括号运算
```
	assert('with one operation') { Calc.eval('(1-1)') == 0 }
    assert('with two operation') { Calc.eval('(1-1+1)') == 1 }
    assert('with priority') { Calc.eval('(2-1)*2') == 2 }
    assert('with priority') { Calc.eval('2*(1-2)') == -2 }
```
###奇怪的乘法变异
```
    assert('multiply') {Calc.eval('2*3') == 222 }
    assert('multiply') {Calc.eval('1*5') == 11111 }
```
