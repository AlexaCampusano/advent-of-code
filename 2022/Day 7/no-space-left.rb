class Commands
    attr_reader :root
    def initialize
        @root = FileSystem.new("/")
        @current_directory = @root
    end

    def cd(path)
        @current_directory = case path
        when ".."
            @current_directory.parent
        when "/"
            @root
        else
            @current_directory.children.find { |child| child.name == path }
        end

    end

    def ls(contents)
        @current_directory.children = contents.map do |content|
            identifier, name = content.split(" ")
            is_directory = identifier == "dir"
            
            if is_directory
                FileSystem.new(name, parent: @current_directory, is_directory: is_directory)
            else
                FileSystem.new(name, parent: @current_directory, size: identifier.to_i)
            end
        end
    end
end


class FileSystem
    attr_accessor :children, :size
    attr_reader :parent, :name, :is_directory
    
    def initialize(name, parent: nil, is_directory: false, size: 0)
        @name = name
        @is_directory = is_directory
        @size = size
        @parent = parent
        @children = []
    end

    class << self
        def directory_size(node, accumulator: 0)
            node.children.inject(accumulator) do |sum, n|
                directory_size(n, accumulator: sum) + n.size
            end
        end
        
        def all_directory_sizes(node, result: [])
            result = result
            node.children.filter(&:is_directory).each do |directory|
                all_directory_sizes(directory, result: result)
                result << { :name => directory.name, :dir_size =>  directory_size(directory) }
            end
            result
        end
    end
end

instructions = File.read("no-space-left.txt").split("$").reject(&:empty?).map do |item|
    command, *result = item.split("\n")
    { :command => command, :result => result }
end

command = Commands.new

instructions.each do |instruction|
    action, param = instruction[:command].split(" ").reject(&:empty?)
    command.send action, param unless param.nil?
    command.send action, instruction[:result] if param.nil?
end

# Result 1
result = FileSystem.all_directory_sizes command.root
p result.filter { |d| d[:dir_size] <= 100000 }.map {|d| d[:dir_size]}.sum

# Result 2
current_space = FileSystem.directory_size command.root
need_to_free = 30000000 - (70000000 - current_space)
directory_to_delete = result.filter {|d| d[:dir_size] >= need_to_free }.map {|d| d[:dir_size]}.min
p directory_to_delete