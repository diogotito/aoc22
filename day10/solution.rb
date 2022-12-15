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
    @X += n
    @cycles << @X
  end

  def noop
    @cycles << @X
  end

  def current_cycle = @cycles.count
  def current_cycle_strength = current_cycle * @X
  def X_at(cycle, *rest) = @cycles[cycle, *rest]
  def cycle_strength(n) = n * X_at(n)
end

describe CPU do
  it 'runs the small program' do
    cpu = CPU.new
    _(cpu.X).must_equal 1
    cpu.noop
    _(cpu.X).must_equal 1
    cpu.addx 3
    _(cpu.cycles).must_equal [1, 1, 1, 4]
    _(cpu.X).must_equal 4
    cpu.addx(-5)
    _(cpu.X_at(4, 2)).must_equal [4, -1]
    _(cpu.X).must_equal(-1)
  end

  it 'runs the example input' do
    cpu = CPU.new
    cpu.run(open('input_example.txt'))
    # IO.write("| CLIP", cpu.cycles.join(?\n))
    _(cpu.X_at(20)).must_equal 21
    _(cpu.cycle_strength(20)).must_equal 420
    _(cpu.X_at(60)).must_equal 19
    _(cpu.cycle_strength(60)).must_equal 1140
    _(cpu.X_at(100)).must_equal 18
    _(cpu.cycle_strength(100)).must_equal 1800
    _(cpu.X_at(140)).must_equal 21
    _(cpu.cycle_strength(140)).must_equal 2940
    _(cpu.X_at(180)).must_equal 16
    _(cpu.cycle_strength(180)).must_equal 2880
    _(cpu.X_at(220)).must_equal 18
    _(cpu.cycle_strength(220)).must_equal 3960
  end

  it 'gives a sum of 13140 for interesting singals' do
    cpu = CPU.new
    cpu.run(open('input_example.txt'))
    _([20, 60, 100, 140, 180, 220].sum { cpu.cycle_strength _1 })
      .must_equal 13140
  end
end
