$input = open('input.txt').readlines(chomp: true).map &:chars
$heights = $input.map { |row| row.map &:to_i }

RANGE = 0...$input.count

def each_tree
  return to_enum(__method__) unless block_given?
  RANGE.each { |x| RANGE.each { |y| yield [x, y] }}
end

def cross_trees((x, y), (dir_x, dir_y))
  while RANGE.cover? x and RANGE.cover? y
    yield x, y
    x += dir_x
    y += dir_y
  end
end

#-------------------------------------------------------------------------------
# Part One
#-------------------------------------------------------------------------------

$visible = $input.map { |row| row.map { false } }

def beam
  tallest = -1
  ->(x, y) do
    if $heights[y][x] > tallest
      tallest = $heights[y][x]
      $visible[y][x] = true
    end
  end
end

RANGE.each do |i|
  cross_trees [i, RANGE.min], [0,  1], &beam
  cross_trees [i, RANGE.max], [0, -1], &beam
  cross_trees [RANGE.min, i], [ 1, 0], &beam
  cross_trees [RANGE.max, i], [-1, 0], &beam
end

puts $visible.sum { |row| row.sum { |tree| tree ? 1 : 0 } }

#-------------------------------------------------------------------------------
# Part Two
#-------------------------------------------------------------------------------

def count_trees((x, y), dir)
  my_height = $heights[y][x]
  count = 0
  cross_trees [x, y], dir do |cx, cy|
    next if x == cx and y == cy
    if $heights[cy][cx] < my_height
      count += 1
    else
      break
    end
  end
  count
end

puts each_tree.map { |pos|
  count_trees(pos, [0,  1]) *
  count_trees(pos, [0, -1]) *
  count_trees(pos, [ 1, 0]) *
  count_trees(pos, [-1, 0])
}.max


__END__
30373
25512
65332
33549
35390