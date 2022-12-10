input = open('input.txt').readline

puts  4 + input.each_char.each_cons( 4).find_index { _1.uniq == _1 }
puts 14 + input.each_char.each_cons(14).find_index { _1.uniq == _1 }
