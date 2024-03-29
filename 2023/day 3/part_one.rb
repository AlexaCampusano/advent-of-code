input = File.read("input.txt").split("\n")
special_chars = input.flat_map { |value| value.scan(/\D/).reject {|v| v == "."} || v.empty? }.uniq
results = []

input.each_with_index do |value, i|
  j = 0
  groups = value.chars.slice_when { |i, j| i.match(/\D/) || j.match(/\D/) }
  groups.flat_map do |group|
    number = group.join
    if number.match?(/\d/)
      rows = ([0, i - 1].max..[input.length - 1, i + 1].min).to_a
      cols = ([0, j - 1].max..[input[i].length - 1, j + number.length].min).to_a
      rows.product(cols).each { |row, col| results << number.to_i if special_chars.include?(input[row][col]) }
    end
    j += number.length
  end
end

puts results.sum