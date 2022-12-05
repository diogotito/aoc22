lines_enumerator = File.foreach('input.txt', chomp: true)

elfs = lines_enumerator.chunk { _1.empty? && :_separator }


elfs = elfs.map { _1.map(&:to_i).sum }



puts elfs.max(3).sum

# 208180