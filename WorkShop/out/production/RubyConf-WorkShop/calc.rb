require 'calc/token'

module Calc
  def self.patterns


  def self.eval(string)
    nums, operations = tokenize(string)
    result = evaluate(nums, operations)
    result
  end

  def self.evaluate(nums, operations)
    result = nums.pop.value
    until operations.empty?
      result = operations.pop.call(result, nums.pop.value)
    end
    result
  end

  def self.tokenize(string)
    num_regexp = /\A(\d+(\.\d+)?|\.\d+)\b/
    operation_regexp = /\A(\+|-|\*|\/)/
    operations = []
    nums = []
    input = string.dup
    until input.empty?
      operation = operation_regexp.match(input)
      num = num_regexp.match(input)
      if operation
        operations << Calc::Token.new(:operation, operation[0])
        input = input[operation[0].length..-1]
      end
      if num
        nums << Calc::Token.new(:numeric, num[0])
        input = input[num[0].length..-1]
      end
    end
    nums.reverse!
    operations.reverse!
    return nums, operations
  end
end