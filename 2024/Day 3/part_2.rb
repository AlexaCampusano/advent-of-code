input = File.read("input.txt").delete("\n")

def process_multiplications(input)
  total = 0
  index = 0
  valid_input = input.gsub(/don't\(\).*?do\(\)/, "")

  while index < valid_input.size
    match = valid_input.match(/mul\((\d+),(\d+)\)/, index)

    if match
      total += match[1].to_i * match[2].to_i
      index = match.end(0)
    else
      index += 1
    end
  end

  total
end

result = process_multiplications(input)
puts result
