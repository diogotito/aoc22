rucksacks = open('input.txt').map do
	[_1.chomp!.slice!(..._1.size/2), _1].map &:chars
end

get_priority = ([''] + (?a..?z).to_a + (?A..?Z).to_a).method :index

puts rucksacks.sum { (_1 & _2).sum &get_priority }

puts rucksacks.each_slice(3).sum { |group|
	group.map(&:flatten).reduce(:&).sum &get_priority
}