require 'set'
Point = Struct.new(:x, :y)

class Rope
  def initialize =
    @hx = @hy = @tx = @ty = 0

  def head = Point.new(@hx, @hy)
  def tail = Point.new(@tx, @ty)

  def head_and_tail_are_touching?
    (@hx - @tx).abs <= 1 and (@hy - @ty).abs <= 1
  end

  def move_head(dx: 0, dy: 0)
    @hx += dx
    @hy += dy
    update_tail
  end

  def update_tail
    return if head_and_tail_are_touching?
    @tx += @hx <=> @tx
    @ty += @hy <=> @ty
  end
    
end

rope = Rope.new
visited_positions = Set.new

File.foreach('input.txt', chomp: true) do |line|
    direction, steps = line.split

    steps.to_i.times do
        case direction
        when 'U'; rope.move_head dy: 1
        when 'D'; rope.move_head dy: -1
        when 'L'; rope.move_head dx: -1
        when 'R'; rope.move_head dx: 1
        end
        visited_positions << rope.tail
    end
end

puts visited_positions.count
# Answer: 6018

