module Calc
  class Token
    attr_accessor :category, :value, :raw_value

    def converter
      @converter ||= {
          :operation => lambda { |op_str| op_str.to_sym },
          :numeric => lambda { |num| num.to_i }
      }
    end

    def initialize(category, raw_value)
      @category = category
      @raw_value = raw_value
      @value = converter[category].call raw_value
    end

    def call(left, right)
      raise NoMethodError unless @category == :operation
      if @value == :-
        result = left - right
        result > 0 ? result : 0
      else
        left.send(@value, right)
      end
    end
  end
end
