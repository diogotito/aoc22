elfs = File.foreach('input.txt', chomp: true)
  .chunk { _1.empty? && :_separator }
  .map { _2.map &:to_i }

puts elfs.map(&:sum).max(3).sum