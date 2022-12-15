require 'minitest/autorun'

class CPU
  attr_accessor :X, :cycles

  def initialize
    @X = 1
    @cycles = [@X]
  end

  def run(program)
    program.each_line do |line|
      case line.chomp
      when 'noop'
        noop
      when /addx (\-?\d+)/
        addx ::Regexp.last_match(1).to_i
      end
    end
  end

  def addx(n)
    @cycles << @X
    crt
    @cycles << @X
    @X += n
  end

  def noop
    @cycles << @X
    crt
  end

  def crt
    # TODO
  end

  def current_cycle = @cycles.count
  def current_cycle_strength = current_cycle * @X
  def X_at(cycle, *rest) = @cycles[cycle, *rest]
  def cycle_strength(n) = n * X_at(n)
end

describe CPU do
  it 'gives a sum of 13140 for interesting singals' do
    cpu = CPU.new
    cpu.run(open('input_example.txt'))
    _([20, 60, 100, 140, 180, 220].sum { cpu.cycle_strength _1 })
      .must_equal 13140
  end

  it 'gives the right answer to part 1' do
    cpu = CPU.new
    cpu.run(open('input.txt'))
    _([20, 60, 100, 140, 180, 220].sum { cpu.cycle_strength _1 })
      .must_equal 14560
  end
end
