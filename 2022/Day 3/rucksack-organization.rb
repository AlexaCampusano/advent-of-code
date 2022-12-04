PRIORITIES = ('a'..'z').to_a + ('A'..'Z').to_a
input = File.read("rucksack-organization.txt").split("\n")


part_one_result = input.map do |rucksack|
    half = rucksack.length/2
    compartment1, compartment2 = rucksack.scan /.{#{half}}/
    common_item = (compartment1.chars & compartment2.chars).first
    priority = PRIORITIES.index(common_item) + 1
end.sum

p part_one_result

result = []
input.each_slice(3) do |group|
    common_item = group.map {|item| item.chars }.inject(:&).first
    result << PRIORITIES.index(common_item) + 1
end

part_two_result = result.sum

p part_two_result