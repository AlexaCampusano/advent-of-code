input = File.read("input.txt").split("\n")
special_chars = input.flat_map { |value| value.scan(/\D/).select { |v| v == "*" } }.uniq
results =  Hash.new { |h, k| h[k] = [] }

input.each_with_index do |value, i|
  j = 0
  groups = value.chars.slice_when { |i, j| i.match(/\D/) || j.match(/\D/) }
  groups.flat_map do |group|
    number = group.join
    if number.match?(/\d/)
      rows = ([0, i - 1].max..[input.length - 1, i + 1].min).to_a
      cols = ([0, j - 1].max..[input[i].length - 1, j + number.length].min).to_a
      rows.product(cols).each do |row, col|
        results["#{row}#{col}"] << number.to_i if special_chars.include?(input[row][col])
      end
    end
    j += number.length
  end
end

puts results.select {|k, v| v.length == 2 }.map {|(key,value)| value.reduce(:*)}.sum