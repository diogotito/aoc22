# debug
vminx, vmaxx = visited_positions.map(&:x).minmax
vminy, vmaxy = visited_positions.map(&:y).minmax
grid = Array.new(vmaxx - vminx + 1) do |x|
  Array.new(vmaxy - vminy + 1) do |y|
    visited_positions.include?(Knot.new(x + vminx, y + vminy))
  end
end

csv = grid.map { _1.map { |b| b ? 1 : 0 } }.transpose.map { _1.join ',' }.reverse.join("\n")
ascii = grid.map { _1.map { |b| b ? '#' : '.' } }.transpose.map { _1.join }.reverse.join("\n")
IO.write('| CLIP', csv) # to paste in Excel with Paste > Use Text Import Wizard
puts ascii

# 1790: too low
# 1791: too low
