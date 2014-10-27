require 'rspec'
require 'wrong'
require 'spec_helper'

include Wrong
describe Calc::Token do

  it 'should initialize' do
    assert('catagory') {Calc::Token.new(:operation,'+').category == :operation}
    assert('raw_value') {Calc::Token.new(:operation,'+').raw_value == '+'}
  end
  it 'should initialize with auto converter' do
    assert('operation') {Calc::Token.new(:operation,'+').value == :+}
    assert('number') {Calc::Token.new(:numeric,'11.0').value == 11}
  end
  it 'should call operation function' do
    raise_error('noMethodError') {Calc::Token.new(:operation,'+').call(1,2) == 1+2}
  end
  it 'should raise error when called by token except from operation' do
    raise_error('noMethodError') {Calc::Token.new(:numeric,'11.0').call(1,2) == :+}
  end
end
