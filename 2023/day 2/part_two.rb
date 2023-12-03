input = File.read("input.txt").split("\n")

def get_game_sets(line)
  sets_str = line.split(':').last
  sets_str.split(';')
end

def find_minimum_cube(sets)
    sets.reduce({ "blue" => [], "red" => [], "green" => [] }) do |memo, set|
        game_groups = set.split(',')
        game_groups.each { |group| memo[group.split(' ').last].push(group.split(' ').first.to_i) }
        memo
    end.values.map(&:max)
end

result = input.filter_map do |line|
    game_sets = get_game_sets(line)
    find_minimum_cube(game_sets).reduce(&:*)
end.sum

puts result