input = open('input.txt').map do |line|
  line.split(',').map { Range.new(*_1.split('-').map(&:to_i)) }
end

puts input.count { _1.cover? _2 or _2.cover? _1 }    # part 1
puts input.count { not (_1.to_a & _2.to_a).empty? }  # part 2