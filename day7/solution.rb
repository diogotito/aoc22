# Global state
$ROOT = { total_size: 0 }
$cwd = $ROOT

$all_dirs = [$ROOT]  # Remember all directories to easily query them for sizes
$cur_path = [$ROOT]  # Keep all the ancestors of $cwd handy

open('input.txt').each_line do |line|
  case line.chomp
  when '$ cd /'
    $cwd = $ROOT
    $cur_path = [$ROOT]
  when '$ cd ..'
    $cwd = $cwd[:parent]
    $cur_path.pop
  when /\$ cd (.*)/
    $cwd = $cwd[Regexp.last_match(1)]
    $cur_path << $cwd
  when /dir (.*)/
    $cwd[Regexp.last_match(1)] = { total_size: 0, parent: $cwd }
    $all_dirs << $cwd[Regexp.last_match(1)]
  when /^(\d+) (.*)/
    size = Regexp.last_match(1).to_i
    name = Regexp.last_match(2)
    $cwd[name] = size
    $cur_path.each { |dir| dir[:total_size] += size }
  end
end

# --- Part One ---
puts $all_dirs.map { |dir| dir[:total_size] }
              .filter { |size| size < 100_000 }
              .sum
# 1723892

# --- Part Two ---
TO_FREE = $ROOT[:total_size] - 40_000_000

puts $all_dirs.map { |dir| dir[:total_size] }
              .filter { |size| size >= TO_FREE }
              .min
# 8474158
