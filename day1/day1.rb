elfs = File.foreach('input.txt', chomp: true)
           .chunk { _1.empty? && :_separator }
           .map { _2.sum(&:to_i) }

puts elfs.max
puts elfs.max(3).sum
