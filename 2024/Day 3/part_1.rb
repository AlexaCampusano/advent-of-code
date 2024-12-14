input = File.read("input.txt").split("\n")

def mul(string)
  string.scan(/mul\((\d+),(\d+)\)/).map { |x, y| x.to_i * y.to_i }.sum
end

def process_multiplications(input)
  total = 0
  input.each do |line|
    index = 0
    while index <= line.size 
      mul_start_idx = line.index("mul(", index)
  
      unless mul_start_idx.nil?
        mul_end_idx = line.index(")", mul_start_idx)
        content = line[mul_start_idx..mul_end_idx]
        total +=  mul(content)
        index = mul_end_idx
      end
  
      index += 1
    end
  end

  total
end

result = process_multiplications(input)

p result