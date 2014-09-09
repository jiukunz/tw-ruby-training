# **REST** and **RESTful Web API**

---

## 分享内容

- 什么是 REST
- 什么是 RESTful Web API

---

## 容易混淆的概念

- RESTful 这个词只是描述某一种架构是否符合 REST 架构风格，而并没有确定其具体的设计细节。
- 所以，我们在说出 RESTful 这个词的时候， 必须搞清楚你所描述的对象：**到底是符合 REST 架构风格，还是仅仅采用了 RESTful Web API 这种具体的架构**。

---

## 名词解释

**REST**

(Representational State Transfer)

- 维基百科 - “表征状态转移”
- 百度百科 - “表述性状态转移”
- 其他 - “表现层状态转化”

……

---

### 个人理解

资源的 - 某种表现形式的 - 状态转化

---

## 简介

（以下内容照搬维基百科，比较学术化，看不懂没关系，不必深究。）

---

- REST 是一种用于提取和抽象分布式超媒体（超链接+多媒体）系统内部结构元素的架构风格。REST 专注于组件所扮演的角色、组件间交互的约束条件以及对于重要数据元素的解释方式, 忽略组件的实现细节以及协议语法。目前，REST 已经成为了一种首选的 Web API 设计模型。
- REST 由 Roy Thomas Fielding 博士于2000年的一篇博士论文中提出（他也是 HTTP 1.0 和 1.1 协议的主要编写者之一）。
- REST 架构风格基于 HTTP/1.0 的已有设计，由 W3C 技术架构小组（TAG）在开发 HTTP/1.1 的同时进行并行开发。如今的万维网便是符合 REST 架构风格的最大系统实现。

---

- REST 风格的架构通常由客户端和服务器组成。客户端向服务器发起请求，服务器处理请求并返回恰当的响应。请求和响应建立在资源的表现形式的转化之上。资源可以是一切能够被定址的清晰且有意义的概念。资源的表现形式通常是一种能够捕获该资源当前以及预期状态的文档。
- 当准备转化到一个新的状态时，客户端开始发出请求。当一个或多个请求被发出后，客户端处于过渡状态。每一个应用程序状态的表现形式均包含用于客户端选择并发起下一个新状态转化请求的链接。

---

## REST 关键目标

- 组件间交互的可伸缩性
- 接口的通用性
- 组件的独立部署
- 通过中间组件来减少延迟、实施安全策略和封装已有系统

---

## 判断是否是 RESTful 的约束条件

- 客户端-服务器分离
- 无状态
- 可缓存
- 多层系统
- 统一接口
- 随需代码（可选）
- 一个能够符合上述所有约束的应用程序或者服务就可以被称作是 RESTful 的，反之，如果违反了上述任何一条约束的话，就不能被称作 RESTful。

---

## REST 基本概念

- REST 是通过观察当前 Web 应用的运作方式而抽象出来的。

- Roy Fielding 认为：“设计良好的 Web 应用表现为一系列的网页，这些网页可以看作的虚拟的状态机，用户选择这些链接导致下一网页传输到用户端展现给使用的人，而这正代表了状态的转变。”

---

- REST 最初是通过 HTTP 的上下文来描述的，但是它并不局限于这种协议。如果能够基于有意义的表现形式的状态转化，并为应用程序提供丰富且一致的词汇表，那么RESTful 架构能够建立在任何的应用程序层协议之上。

- RESTful 应用程序能够最大程度的利用已经存在的，拥有良好接口定义的，提供内置功能的各种网络协议，并最小程度的在其之上增加新的特定应用程序特性。

---

## REST vs SOAP

- REST
  - GET
  - POST
  - PUT
  - DELETE
- SOAP
  - GetXXX()
  - CreateXXX(...)
  - UpdateXXX(...)
  - DeleteXXX(...)

---

## REST 接口设计指导原则

提供统一的接口是任何 REST 服务必须考虑的基本原则。

- 标识资源
- 通过表现形式操作资源
- 自描述消息
- 超媒体即应用状态引擎（HATEOAS）

---

## REST 核心原则

- REST 的一个重要概念是资源的存在（特定信息的来源），每一个资源都应当通过全局标识符来引用（比如 HTTP 中的 URI）。为了操作这些资源，网络组件（用户代理和源服务器）通过标准化接口（比如 HTTP）与资源进行通信并交换资源的表现形式（传递信息的实际文档）。
- 一个应用程序只需要通过两件东西与资源进行交互：资源的标识和所需要的动作——它不需要知道缓存、代理、网关、防火墙、隧道或者任何其他的东西，服务器将会保存这些信息。应用程序需要了解返回信息（表现形式）的格式，通常会像是 HTML、XML 或者 JSON 这样的文档，也可能是图像、纯文本或者其他的内容。

---

## 什么是 RESTful Web API

- RESTful Web API （也可以叫做 RESTful Web Service）是一种基于 HTTP 和 REST 架构风格的 Web API 实现。它是一个资源的集合，有四个方面的定义：

---

- 使用基本的 URI，比如 http://example.com/resources/ 。
- 使用互联网媒体类型表现数据，通常使用的是 JSON，但是也可以使用其他有效的互联网媒体类型。
- 使用 HTTP 请求方法来支持操作（比如 GET、PUT、POST 或者 DELETE 等 HTTP 动词，Ruby on Rails 4.0 以后的版本中，用 PATCH 代替了 PUT 以便更加的语义化）。
- API 必须是超文本驱动的。

---

- GET http://example.com/resources - 获取所有资源
- GET http://example.com/resources/item1 - 获取指定标识的资源
- POST http://example.com/resources - 创建新的资源并返回资源标识
- PUT http://example.com/resources/item1 - 更新指定标识的资源
- DELETE http://example.com/resources/item1 - 删除指定标识的资源

---

## 设计 RESTful Web API 的误区

- 最常见的一种设计错误，就是 URI 包含动词。因为"资源"表示一种实体，所以应该是名词，URI 不应该有动词，动词应该放在 HTTP 协议中。

  举例来说，某个 URI 是：

  ```
  /posts/show/1
  ```

  其中 show 是动词，这个 URI 就设计错了，正确的写法应该是：

  ```
  /posts/1
  ```

  然后用 GET 方法表示 show。

---

- 如果某些动作是 HTTP 动词表示不了的，你就应该把动作做成一种资源。比如网上汇款，从账户1向账户2汇款500元，错误的 URI 是：

  ```
  POST /accounts/1/transfer/500/to/2
  ```

  正确的写法是把动词 transfer 改成名词transaction，资源不能是动词，但是可以是一种服务：

  ```
  POST /transaction HTTP/1.1
  Host: 127.0.0.1

  from=1&to=2&amount=500.00
  ```
---

- 另一个设计误区，就是在 URI 中加入版本号：

  ```
  http://www.example.com/app/1.0/foo
  http://www.example.com/app/1.1/foo
  http://www.example.com/app/2.0/foo
  ```

  因为不同的版本，可以理解成同一种资源的不同表现形式，所以应该采用同一个 URI 。版本号可以在 HTTP 请求头信息的 Accept 字段中进行区分：

  ```
  Accept: vnd.example-com.foo+json; version=1.0
  Accept: vnd.example-com.foo+json; version=1.1
  Accept: vnd.example-com.foo+json; version=2.0
  ```

---

## 一些常见的 REST Web API 框架

- Sinatra
- ASP.NET Web API
- Restlet

……

---

## **Resource**

- [Architectural Styles and the Design of Network-based Software Architectures](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm)
- [Representational state transfer](http://en.wikipedia.org/wiki/Representational_state_transfer)
- [Learn REST: A Tutorial](http://rest.elkstein.org)
- [Learn REST: A RESTful Tutorial](http://www.restapitutorial.com)
- [理解RESTful架构](http://www.ruanyifeng.com/blog/2011/09/restful.html)
- [RESTful API 设计指南](http://www.ruanyifeng.com/blog/2014/05/restful_api.html)
