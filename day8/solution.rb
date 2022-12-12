$input = open('input.txt').readlines(chomp: true).map(&:chars)
$heights = $input.map { |row| row.map(&:to_i) }

RANGE = 0...$input.count

def each_tree
  return to_enum(__method__) unless block_given?

  RANGE.each do |x|
    RANGE.each do |y|
      yield [x, y]
    end
  end
end

def cross_trees((x, y), (dir_x, dir_y))
  return to_enum(__method__, [x, y], [dir_x, dir_y]) unless block_given?

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
  lambda do |x, y|
    if $heights[y][x] > tallest
      tallest = $heights[y][x]
      $visible[y][x] = true
    end
  end
end

RANGE.each do |i|
  cross_trees [i, RANGE.min], [0, 1], &beam
  cross_trees [i, RANGE.max], [0, -1], &beam
  cross_trees [RANGE.min, i], [1, 0], &beam
  cross_trees [RANGE.max, i], [-1, 0], &beam
end

puts $visible.sum { |row| row.sum { |tree| tree ? 1 : 0 } }

#-------------------------------------------------------------------------------
# Part Two
#-------------------------------------------------------------------------------

$heights[RANGE.begin] = $heights[RANGE.end] = Array.new(RANGE.count, 9)
$heights.each { |row| row[RANGE.begin] = row[RANGE.end] = 9 }

def count_trees((x, y), dir)
  my_height = $heights[y][x]
  view_dist = 0

  cross_trees([x, y], dir).lazy.drop(1).each do |cx, cy|
    if $heights[cy][cx] < my_height
      view_dist += 1
    else
      view_dist += 1
      return view_dist
    end
  end

  view_dist
end

pp each_tree.map { |pos|
  view_distances = {
    up: count_trees(pos, [0, -1]),
    down: count_trees(pos, [0, 1]),
    left: count_trees(pos, [-1, 0]),
    right: count_trees(pos, [1, 0])
  }
  scenic_score = view_distances.values.reduce :*
  [scenic_score, view_distances, pos, $heights[pos[1]][pos[0]]]
}.max_by(10, &:first)

# Think
# Quero encontrar o indice
# find_index
[1, 2, 3, 4, 5].find_index { |n| n.even? }

# Wrong answers:
197_400  # wrong
201_348  # too low
254_592  # too high

# Queue
230_112

__END__
30373
25512
65332
33549
35390