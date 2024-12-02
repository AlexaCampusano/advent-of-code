# part_1.rb

# Read the input file
input = File.read("input.txt").split("\n")

result = input
  .map { |line| line.split.map(&:to_i) }
  .transpose.map(&:sort)
  .reduce(:zip)
  .map { |left, right| (left - right).abs }
  .sum

p result


