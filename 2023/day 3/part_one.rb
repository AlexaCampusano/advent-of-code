input = File.read("test_input.txt").split("\n")

special_chars = input.map {|value| value.split('.').map {|n| n.tr('[0-9]','')}.filter {|v| v unless v.empty?}}.flatten.uniq
number_groups = input.map  do |value|
  value.split('').slice_when do |i, j, p|
    binding.irb
    i.match(/\d/) && j.match(/\d/)
  end.map(&:join)
end

p number_groups

valid_numbers = number_groups.map.with_index do |group, i|
  group.map.with_index do |value, j|
    if value.match?(/\d/)
      rows = ([0, i-1].max..[input.length-1, i+1].min).to_a
      cols = ([0,j-1].max..[input[i].length-1, j + value.length].min).to_a

      # p value
      # p rows
      # p cols
      results = []

      rows.each do |row|
        cols.each do |col|
          results << value.to_i if special_chars.include?(input[row][col])
        end
      end

      results
    end
  end
end

p valid_numbers

# valid_numbers = number_groups.map.with_index do |numbers, i|
#   numbers.map do |number|
#     starting_index = input[i].index(number)
#     rows = ([0, i-1].max..[input.length-1, i+1].min).to_a
#     cols = ([0,starting_index-1].max..[input[i].length-1, starting_index + number.length].min).to_a

#     results = []

#     rows.each do |row|
#       cols.each do |col|
#         results << number.to_i if special_chars.include?(input[row][col])
#       end
#     end
#     results
#   end
# end.flatten

# p valid_numbers
# puts valid_numbers.sum


# #!/usr/bin/env ruby

# parts = []
# symbols = []

# File.read("input.txt").each_line.each_with_index do |line, y|
#   line.chomp.chars.each_with_index do |c, x|
#     case c
#     when /[^\d\.]/
#       symbols << [x, y]
#     when /[\d]/
#       current_part = parts.last

#       if (current_part = parts.last) && current_part[:x].include?(x - 1)
#         current_part[:x] = current_part[:x].min..x
#         current_part[:number] << c
#         parts[-1] = current_part
#       else
#         parts << { number: c, x: x..x, y: y }
#       end
#     end
#   end
# end

# parts.select! do |part|
#   symbols.any? do |(symbol_x, symbol_y)|
#     ((part[:y] - 1)..(part[:y] + 1)).include?(symbol_y) &&
#     ((part[:x].min - 1)..(part[:x].max + 1)).include?(symbol_x)
#   end
# end
# p parts.map { |part| part[:number].to_i }
# puts parts.map { |part| part[:number].to_i }.sum
