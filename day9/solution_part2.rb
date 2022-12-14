require 'set'

Knot = Struct.new(:x, :y) do
  def touching?(knot)
    (x - knot.x).abs <= 1 and (y - knot.y).abs <= 1
  end
end

class Rope
  def initialize
    @knots = Array.new(10) { Knot.new(0, 0) }
  end

  def head = @knots.first
  def tail = @knots.last

  def move_head(dx: 0, dy: 0)
    head.x += dx
    head.y += dy
    update_knots
  end

  def update_knots
    @knots.each_cons(2) do |knot_in_front, further_knot|
      next if further_knot.touching? knot_in_front

      further_knot.x += (knot_in_front.x <=> further_knot.x)
      further_knot.y += (knot_in_front.y <=> further_knot.y)
    end
  end
end

rope = Rope.new
visited_positions = Set.new

File.foreach('input.txt', chomp: true) do |line|
  direction, steps = line.split

  steps.to_i.times do
    case direction
    when 'U' then rope.move_head dy: 1
    when 'D' then rope.move_head dy: -1
    when 'L' then rope.move_head dx: -1
    when 'R' then rope.move_head dx: 1
    end
    visited_positions << rope.tail.dup
  end
end

puts visited_positions.count
# Anwser: 2619
