
def find_marker(characters_constraint)
    buffer = File.read("tuning-trouble.txt")
    result = 0
    buffer.chars.each_cons(characters_constraint).with_index do |group, i|
        next if group.uniq != group
        result = i + characters_constraint
        break
    end
    result
end

p "Part one result: "
p find_marker 4

p "Part two result: "
p find_marker 14