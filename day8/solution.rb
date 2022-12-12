$input = DATA.readlines(chomp: true).map &:chars
$heights = $input.map { |row| row.map &:to_i }
$visible = $input.map { |row| row.map { false } }

RANGE = 0...$input.count

def cross_trees((x, y), (dir_x, dir_y))
  while RANGE.cover? x and RANGE.cover? y and yield x, y
    x += dir_x
    y += dir_y
  end
end

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


#-------------------------------------------------------------------------------
# Output
#-------------------------------------------------------------------------------
puts $visible.sum { |row| row.sum { |tree| tree ? 1 : 0 } }
puts $visible.map { |row| row.map { |tree| tree ? "*" : "-" }.join }


__END__
30373
25512
65332
33549
35390