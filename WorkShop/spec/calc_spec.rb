require 'rspec'
require 'wrong'
require 'spec_helper'

include Wrong
describe Calc do

  it 'should eval one number' do
    assert('one digit') { Calc.eval('1') == 1 }
    assert('multiple digits') { Calc.eval('11') == 11 }
  end

  it 'should eval two number with one operation' do
    assert('plus') { Calc.eval('1+1') == 2 }
    assert('minus') {Calc.eval('1-1') == 0 }
    assert('multiple') {Calc.eval('2*1') == 2 }
    assert('divide') {Calc.eval('4/2') == 2 }
    assert('minus') {Calc.eval('3-5') == 0 }
    assert('minus') {Calc.eval('4-10') == 0 }
  end

  it 'should eval three or more numbers with two operation' do
    assert('without priority') { Calc.eval('1-1+1') == 1 }
    assert('without priority') { Calc.eval('1-1+1+3') == 4 }
    assert('with priority') { Calc.eval('2+4/2') == 4 }
    assert('with priority') { Calc.eval('3-6/2') == 0 }
  end
  #
  # it 'should eval brackets' do
  #   assert('with one operation') { Calc.eval('(1-1)') == 0 }
  #   assert('with two operation') { Calc.eval('(1-1+1)') == 1 }
  #   assert('with priority') { Calc.eval('(2-1)*2') == 2 }
  #   assert('with priority') { Calc.eval('2*(1-2)') == -2 }
  # end
end