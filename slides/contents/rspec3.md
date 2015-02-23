# latest things about ruby

> *Rspec 3.x*

---

# Why rspec3.x?

- Introduce Guideline
- Better Performence
- More Decent Inside
- Suck Less In Future

---

# should vs expect

- no __*should*__ anymore, bad implementation
- jasmine syntax expect, __*more decent*__

```ruby
true.should == true # deprecated

expect(true).to be_truthy # be_true no longer exists
expect(true).to eq true # expect does not support == matcher
```

---

# rename hooks
:each, :all, :context, :example not consistency
```ruby
describe User do
  before(:all) do
    ...
  end

  before(:each) do
    ...
  end

  describe '#login?' do
    context 'ok' do
      it 'should login'
    end
  end
end
```
---
# rename hooks
- :all => :context
- :each => :example

```ruby
describe User do
  before(:context) do
    ...
  end

  before(:example) do
    ...
  end

  describe '#login?' do
    context 'ok' do
      it 'login'
    end
  end
end
```
---
#rspec hooks
- before :suite 
- before :context 
- before :example 
- after :example 
- after :context 
- after :suite
---

#filter in hooks
you can do more work for some tag only

```ruby
describe "something", type: :model do
  ...
end

# in spec_helper.rb
RSpec.configure do |c| 
  c.before(:example, type: :model) do
    ...
  end 
end
```

---

#subject
- introduct #is_excpected
- extract `its` to gem `rspec-its`

```ruby
describe 'something' do
  subject {...}
  it { should be_a_multiple_of 3 }
  it { is_expected.to be_a_multiple_of 3 }

  its(:name) { should == 'Rspec'}
  its(:name) { is_expected.to eq 'Rspec'} # gem rspec-its
end
```
---
#method stub
- ***stub*** is bad implementation, no error even not invoked
- ***allow*** force you invoke it

```ruby
object.stub(:foo).and_return(:bar)
object.should_receive(:foo)

allow(:object).to reveive(:foo) # new syntax
```
---
#any instance
- It is the most complicated feature of rspec-mocks, and has historically received the most bug reports. (None of the core team actively use it, which doesn't help.)

```ruby
# bad implementation
Object.any_instance.stub(:foo).and_return(:return_value) 

# not so bad
allow_any_instance_of(Widget).to receive(:name).and_return("Wibble")
```
---
#message chain
```ruby
object.stub_chain(:foo, :bar).and_return('baz')

allow(double).to receive_message_chain(:foo, :bar) { :baz }
```
---
#rspec-rails
---

#spec tags
You should add tag for you rails spec

- Model: ***type: :model***
- Controller: ***type: :controller***
- Request: ***type: :request***
- Feature: ***type: :feature***
- View: ***type: :view***
- Helper: ***type: :helper***
- Mailer: ***type: :mailer***
- Routing: ***type: :routing***

---
#access cookie
get cookie from request and response separately

```ruby
# controller 
def some_action 
  cookies['foo'] = "modified #{cookies['foo']}" 
end

# spec 
request.cookies['foo'] = 'bar' 
get :some_action 
expect(response.cookies['foo']).to eq('modified bar')
```
---
#How to upgrade from 2.x
1. ensure all specs pass
2. upgrade rspec to 2.99
3. verify all specs pass
4. gem install [transpec](http://yujinakayama.me/transpec/)
5. run command `transpec`, then magic happen
6. deal some issues by yourself
7. verify all specs pass and no warning message
8. commit
---
#transpec
- it will convert your specs to 3.x syntax
- do not use absolute path, use relative path

```bash
gem install transpec
transpec
```
---
#should_clean
this [gem](https://github.com/siyelo/should_clean) will make 'it "***should*** do something"' becomes 'it "***does*** something"'
---
#Q & A