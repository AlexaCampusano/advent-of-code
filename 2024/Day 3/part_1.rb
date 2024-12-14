input = File.read("input.txt").split("\n")

def mul(string)
  string.scan(/mul\((\d+),(\d+)\)/).map { |x, y| x.to_i * y.to_i }.sum
end

total = input.map { |line| mul(line) }.sum

p total