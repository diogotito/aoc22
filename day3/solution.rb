rucksacks = File.foreach('input.txt', chomp: true).collect &:chars

GET_PRIORITY = ([''] + (?a..?z).to_a + (?A..?Z).to_a).method :index

# Part 1
puts rucksacks.sum {
	_1.each_slice(_1.size / 2).reduce(:&).sum &GET_PRIORITY
}

# Part 2
puts rucksacks.each_slice(3).sum { |group|
	group.reduce(:&).sum &GET_PRIORITY
}