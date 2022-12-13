$input = open('input.txt').readlines(chomp: true).map(&:chars)
$heights = $input.map { |row| row.map(&:to_i) }

RANGE = 0...$input.count

def walk_trees((x, y), (dir_x, dir_y))
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

visible = $input.map { |row| row.map { false } }

# Make a closure that marks visible trees in a walk
def mark_in(visible)
  tallest = -1
  lambda do |x, y|
    if $heights[y][x] > tallest
      tallest = $heights[y][x]
      visible[y][x] = true
    end
  end
end

RANGE.each do |i|
  walk_trees [i, RANGE.min], [0, 1],  &mark_in(visible) # down
  walk_trees [i, RANGE.max], [0, -1], &mark_in(visible) # up
  walk_trees [RANGE.min, i], [1, 0],  &mark_in(visible) # right
  walk_trees [RANGE.max, i], [-1, 0], &mark_in(visible) # left
end

puts visible.sum { |row| row.sum { |tree| tree ? 1 : 0 } }
# Answer: 1845

#-------------------------------------------------------------------------------
# Part Two
#-------------------------------------------------------------------------------

# Optimization: Write 9s in the border to skip testing for it in view_distance
$bordered_heights = $heights.map(&:dup)
$bordered_heights[0] = $bordered_heights[-1] = Array.new($heights.count, 9)
$bordered_heights.each { |row| row[0] = row[-1] = 9 }

def view_distance((x, y), dir)
  my_height = $heights[y][x]

  blocking_tree_at = walk_trees([x, y], dir).find_index do |cx, cy|
    next if [cx, cy] == [x, y] # skip starting position

    $bordered_heights[cy][cx] >= my_height
  end

  # find_index returns nil if the block never produces true
  # This only happens if we start at the border and "jump" out of it right away
  # That counts as 0
  blocking_tree_at || 0
end

puts RANGE.entries.product(RANGE.entries).map { |pos|
  [[0, -1], [0, 1], [-1, 0], [1, 0]] # up, down, left, right
    .map { |dir| view_distance(pos, dir) }
    .reduce :*
}.max
# Answer: 230112
