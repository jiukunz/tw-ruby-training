# Rack

---

## Rack: a Ruby Webserver Interface

![Rack](http://rack.github.io/rack-logo.png)

- Rack is a nice Ruby-fied replacement for CGI

---

- Supported web servers (included)
  - Mongrel
  - EventedMongrel
  - SwiftipliedMongrel
  - WEBrick
  - FCGI
  - CGI
  - SCGI
  - LiteSpeed
  - Thin

---

- Supported web frameworks
  - Camping
  - Coset
  - Espresso
  - Halcyon
  - Mack
  - Maveric
  - Merb
  - Racktools::SimpleApplication
  - Ramaze
  - Ruby on Rails
  - Rum
  - Sinatra
  - Sin
  - Vintage
  - Waves
  - Wee
  - and many others

---

```bash
$ gem install rack
```

---

## WEBrick

```ruby
require 'webrick'

class Simple < WEBrick::HTTPServlet::AbstractServlet
  def initialize server, color, size
    super server
    @color = color
    @size = size
  end

  def service request, response
    status, content_type, body = 200, 'text/plain', "color is #{@color} and size is #{@size}"

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end
end

server = WEBrick::HTTPServer.new :Port => 8000
server.mount '/', Simple, 'red', '2em'
server.start
```

---

## my_rack_app.rb

```ruby
require 'rack'
 
app = Proc.new do |env|
    ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]
end

Rack::Handler::WEBrick.run app
```

```bash
$ ruby my_rack_app.rb
```

---

## Rack::Handler::WEBrick

https://github.com/rack/rack/blob/master/lib/rack/handler/webrick.rb

---

## CGI - Common Gateway Interface

- a standard method used to generate dynamic content on Web pages and Web applications.
- the HTTP server runs the specified script and passes the output of the script to the Web browser

---

## Practice Time

Rack::Handler::CGI

---

```ruby
require 'rack'

app = Proc.new do |env|
    ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]
end

Rack::Handler::CGI.run app
```

---

## config.ru

```ruby
run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['get rack\'d']] }
```

```bash
$ rackup
```

---

## Rack::Builder

### run

```ruby
run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['get rack\'d']] }
```

---

### map

```ruby
map '/' do
  run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['index']] }
end

map '/version' do
  run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['1.0']] }
end
```

---

### use

```ruby
class Middleware
  def initialize(app)
    @app = app
  end

  def call(env)
    puts 'before app call'
    result = @app.call(env)
    puts 'after app call'
    result
  end
end
```

```ruby
use Middleware

map '/' do
  app = Proc.new do |env|
    puts 'in app call'
    ['200', {'Content-Type' => 'text/html'}, ['index'] ]
  end
  run app
end
```

---

https://github.com/rack/rack/wiki/List-of-Middleware

---

# Sinatra

```bash
$ gem install sinatra
```

```ruby
require 'sinatra'

get '/hi' do
  "Hello World!"
end
```

```bash
$ ruby hi.rb
```

---

## Routes

```ruby
get '/hello/:name' do
  # matches "GET /hello/foo" and "GET /hello/bar"
  # params[:name] is 'foo' or 'bar'
  "Hello #{params[:name]}!"
end
```

```ruby
get '/posts' do
  # matches "GET /posts?title=foo&author=bar"
  title = params[:title]
  author = params[:author]
  # uses title and author variables; query is optional to the /posts route
end
```

---

## Return Values

- An Array with three elements: `[status (Fixnum), headers (Hash), response body (responds to #each)]`
- An Array with two elements: `[status (Fixnum), response body (responds to #each)]`
- An object that responds to #each and passes nothing but strings to the given block
- A Fixnum representing the status code

```ruby
class Stream
  def each
    100.times { |i| yield "#{i}\n" }
  end
end

get('/') { Stream.new }
```

---

## Filters

```ruby
before do
  @note = 'Hi!'
  request.path_info = '/foo/bar/baz'
end

get '/foo/*' do
  @note #=> 'Hi!'
  params[:splat] #=> 'bar/baz'
end
```

---

## Sinatra::Application

```ruby
require 'sinatra/base'

class MyApp < Sinatra::Application
  get '/' do
    'Hello world!'
  end
end
```

---

## Sinatra::Base

```ruby
require 'sinatra/base'

class MyApp < Sinatra::Base
  set :sessions, true
  set :foo, 'bar'

  get '/' do
    'Hello world!'
  end
end
```
---

## Modular vs. Classic Style

http://www.sinatrarb.com/intro.html#Modular%20vs.%20Classic%20Style

---

## Serving a Modular Application

```ruby
require_relative 'my_app'

run MyApp
```

---

## Using a Classic Style Application with a config.ru

```ruby
require_relative 'hi'

run Sinatra::Application
```

---

## Homework

- `run MyApp`
- a Webapp can Register and Login

---

## References

- http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
- https://en.wikipedia.org/wiki/Common_Gateway_Interface
- http://rubydoc.info/github/rack/rack/
- http://m.onkey.org/ruby-on-rack-2-the-builder
- http://rubydoc.info/github/rack/rack/master/Rack/Builder
- http://www.sinatrarb.com/intro.html
