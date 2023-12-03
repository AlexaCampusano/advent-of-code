CURRENT_BAG_LOAD = { "red" => "12", "blue" =>  "14", "green" => "13" }
input = File.read("input.txt").split("\n")

def get_game_number_and_sets(line)
  game_number, sets_str = line.split(':')
  [game_number.tr('^[0-9]', '').to_i, sets_str.split(';')]
end

def game_valid?(game_set)
  color_groups = game_set.split(',')

  color_groups.all? do |group|
    amount, color = group.split(' ')
    amount.to_i <= CURRENT_BAG_LOAD[color].to_i
  end
end

result = input.filter_map do |line|
  game_number, game_sets = get_game_number_and_sets(line)
  game_number if game_sets.all? { |set| game_valid?(set) }
end

puts result.sum
