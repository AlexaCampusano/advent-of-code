input = File.read("input.txt").split("\n")
left_list = Hash.new(0)
right_list = Hash.new(0)

# Contar ocurrencias en ambas listas
input.each do |line|
  left, right = line.split.map(&:to_i)
  left_list[left] += 1
  right_list[right] += 1
end

# Calcular el resultado
result = left_list.sum { |key, value| key * value * right_list[key] }

puts result

