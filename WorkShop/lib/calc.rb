require 'calc/token'

module Calc
  def self.scanners
    @scanners ||= [
        {category: :operation, pattern: /\A(\+|-|\*|\/)/},
        {category: :numeric, pattern: /\A(\d+(\.\d+)?|\.\d+)\b/}
    ]
  end

  def self.token_stacks
    @token_stacks ||= {
        operation: [],
        numeric: []
    }
  end

  def self.eval(string)
    token_stacks = tokenize(string)
    result = evaluate token_stacks
    result
  end

  def self.evaluate(tokens)
    token_stacks[:numeric] << tokens.pop.value
    until tokens.empty?
      operation = tokens.pop
      if [:*, :/].include? operation.value
        left = tokens.pop.value
        right = token_stacks[:numeric].pop
        token_stacks[:numeric] << operation.call(left, right)
      elsif [:+, :-].include? operation.value
        token_stacks[:operation] << operation
        token_stacks[:numeric] << tokens.pop.value
      end
    end
    until token_stacks[:operation].empty?
      left = token_stacks[:numeric].pop
      right = token_stacks[:numeric].pop
      operation = token_stacks[:operation].pop
      token_stacks[:numeric] << operation.call(left,right)
    end
    token_stacks[:numeric].pop
  end

  def self.tokenize(string)
    @tokens = []
    input = string.dup
    until input.empty?
      scanners.each { |scanner|
        token = scanner[:pattern].match(input)
        if token
          @tokens << Calc::Token.new(scanner[:category], token[0])
          input = input[token[0].length..-1]
        end
      }
    end
    return @tokens
  end
end