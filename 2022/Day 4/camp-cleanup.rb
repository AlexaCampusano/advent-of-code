input = File.read("camp-cleanup.txt").split("\n")

part_one_result = input.select do |assignment|
    section1, section2 = assignment.split(",").map { |section| section.split("-") }
    section1_range = (section1.first..section1.last).to_a
    section2_range = (section2.first..section2.last).to_a

    overlap = section1_range & section2_range

    overlap == section1_range || overlap == section2_range
end.length

p part_one_result

part_two_result = input.select do |assignment|
    section1, section2 = assignment.split(",").map { |section| section.split("-") }
    overlap = (section1.first..section1.last).to_a & (section2.first..section2.last).to_a
    !overlap.empty?
end.length

p part_two_result