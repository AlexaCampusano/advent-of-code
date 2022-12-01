class Calorie
  attr_reader :amount
  def initialize(amount)
    @amount = amount
  end
end

class Food
  attr_reader :calorie
  def initialize(calorie_amount)
    @calorie = Calorie.new(calorie_amount)
  end
end

class Elf
  attr_reader  :food_list
  def initialize(food_list)
    @food_list = food_list
  end

  def count_food_calories
    @food_list.map { |food| food.calorie.amount }.reduce(:+)
  end

end

class CalorieManager
  def initialize(source_path)
    @elves = []
    File.read(source_path).split("\n\n").each do |group|
      food_items = group.split("\n").map { |line| Food.new(line.to_i)}
      @elves << Elf.new(food_items)
    end
  end

  def highest_calories_amount
    @elves.map { |elf| elf.count_food_calories }.max
  end

  def top_highest_calories_total(top_length)
    @elves.map { |elf| elf.count_food_calories }
      .max(top_length)
      .reduce(:+)
  end
end

result = CalorieManager.new("calorie_source.txt")
p result.highest_calories_amount
p result.top_highest_calories_total(3)
