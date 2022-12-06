CRATE_DIMENSION_SPACE = 4
stack_input, instructions_input = File.read("supply-stack.txt").split("\n\n")

def parse_grid(stacks)
    grid_rows = stacks.split("\n")
    stack_grid = grid_rows.last.split.map { [] }

    grid_rows.each do |row|
        stack_grid.each_with_index do |c, i|
            value = row.chars.each_slice(CRATE_DIMENSION_SPACE).map(&:join)[i]
            c << value.strip.gsub(/[^\w\s]/, "") unless value.strip.empty?
        end unless row == grid_rows.last
    end

    stack_grid
end

def parse_instructions(instructions_input)
    list = instructions_input.split("\n")
    list.map { |sentence| sentence.split.each_slice(2).map { |item| item.last.to_i - 1 }}
end

def execute_part1(stack_input, instructions_input)
    grid = parse_grid stack_input
    instructions = parse_instructions instructions_input
    instructions.map do |actions|
        move, from, to = actions
        items = grid[from].slice!(0..move)
        grid[to].insert(0, *items.reverse)
    end
    grid.map { |stack| stack.first }.join
end

def execute_part2(stack_input, instructions_input)
    grid = parse_grid stack_input
    instructions = parse_instructions instructions_input
    instructions.map do |actions|
        move, from, to = actions
        items = grid[from].slice!(0..move)
        grid[to].insert(0, *items)
    end
    grid.map { |stack| stack.first }.join
end


p execute_part1 stack_input, instructions_input
p execute_part2 stack_input, instructions_input