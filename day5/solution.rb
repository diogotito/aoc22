(stack_figure, (_, *commands)) =
  open('input.txt')
    .readlines(chomp: true)
    .slice_before("")
    .to_a

stacks_1 = [[]] + 
  stack_figure.map(&:chars).transpose.map(&:join)
    .each_slice(4).map { |(_, letters, _, _)|
        letters.lstrip[...-1].reverse.chars
    }

stacks_2 = stacks_1.clone

commands.each do
  _1 =~ /move (\d+) from (\d+) to (\d+)/
  (how_many, from, to) = $~.captures.map &:to_i
  how_many.times { stacks_1[to] << stacks_1[from].pop }
  stacks_2[to] += stacks_2[from].pop how_many
end


#-------------------------------------------------------------------------------
# Output
#-------------------------------------------------------------------------------

def show_stacks(stacks)
  puts stacks.drop(1)
         .map { _1.join.reverse.rjust(stacks.map(&:count).max).chars }.transpose
         .map { _1.flat_map { |c| c != " " ? "[#{c}] " : " #{c}  " }.join }
  puts (1...stacks.count).map { |n| "#{n.to_s.center(3)} " }.join
end

puts stack_figure
puts
show_stacks stacks_1
puts
puts stacks_1.map(&:last).join
puts
show_stacks stacks_2
puts
puts stacks_2.map(&:last).join # TODO Wrong answer!