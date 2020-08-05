require 'pry'

class Minilang
  VALID = %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(commands)
    @commands = commands.split(' ')
    @register = 0
    @stack = []
  end

  def eval
    @commands.each_with_index do |command, i|
      case
      when command == 'PUSH'
        @stack << @register
      when command == 'ADD'
        raise "Empty stack!" if @stack.empty?
        @register += @stack.pop.to_i
      when command == 'SUB'
        raise "Empty stack!" if @stack.empty?
        @register -= @stack.pop.to_i
      when command == 'MULT'
        raise "Empty stack!" if @stack.empty?
        @register *= @stack.pop.to_i
      when command == 'DIV'
        raise "Empty stack!" if @stack.empty?
        @register /= @stack.pop.to_i
      when command == 'MOD'
        raise "Empty stack!" if @stack.empty?
        @register %= @stack.pop.to_i
      when command == 'POP'
        raise "Empty stack!" if @stack.empty?
        @register = @stack.pop.to_i
      when command == 'PRINT'
        puts @register
      when command.to_i.to_s == command
        @register = command.to_i
      when VALID.include?(command) == false
        raise "Invalid token: #{command}"
      end
    end
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
