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
# Answer: 1845

#-------------------------------------------------------------------------------
# Part Two
#-------------------------------------------------------------------------------

def count_trees((x, y), dir)
  my_height = $heights[y][x]
  cross_trees([x, y], dir).find_index do |cx, cy|
    [cx, cy] != [x, y] and
      $heights[cy][cx] >= my_height or
      [cx, cy].any? { |coord| RANGE.minmax.include? coord }
  end or 0
end

puts each_tree.map { |pos|
  [[0, -1], [0, 1], [-1, 0], [1, 0]]
    .map { |dir| count_trees(pos, dir) }
    .reduce :*
}.max
# Answer: 230112
