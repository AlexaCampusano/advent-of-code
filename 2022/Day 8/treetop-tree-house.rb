
input = File.read("treetop-tree-house.txt").split("\n").map(&:chars)

visible_trees = input.each_with_object([]).with_index do |(item, result), i|
    item.map.with_index do |h, y|
        rd = item[y+1..-1]
        ld = item[0...y]
        t = input.transpose[y][0...i]
        d = input.transpose[y][i+1..-1]
        
        result << h unless [ld, rd, t, d].map { |x| x.max ? x.max >= h : false }.inject(:&)
    end
end

# part 1
p visible_trees.count

visible_trees_score = input.each_with_object([]).with_index do |(item, result), i|
    item.map.with_index do |h, y|
        rd = item[y+1..-1]
        ld = item[0...y].reverse
        t = input.transpose[y][0...i].reverse
        d = input.transpose[y][i+1..-1]

        result <<  [ld,rd,t,d].map do |x|
            index = x.find_index { |t| t >= h }
            index ? index + 1 : x.length
        end.inject(&:*)
    end
end

#part 2
p visible_trees_score.max