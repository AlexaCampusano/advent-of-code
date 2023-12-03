input = File.read("input.txt").split("\n")

letter_to_digit = {
  one: "1",
  two: "2",
  three: "3",
  four: "4",
  five: "5",
  six: "6",
  seven: "7",
  eight: "8",
  nine: "9",
  zero: "0"
}

digitalized_input = input.map do |line|
  first_digit = ""
  line.each_char.reduce("") do |memo, char|
    letter_number = "#{memo}#{char}"
    number = letter_number.tr('^[0-9]', '')

    unless number.empty?
      first_digit = number
    else
      letter_to_digit.each_pair do |key, value|
        first_digit = value  if letter_number.include?(key.to_s)
      end
    end
    break unless first_digit.empty?
    letter_number
  end
  last_digit = ""
  line.reverse.each_char.reduce("") do |memo, char|
    letter_number = "#{memo}#{char}"
    number = letter_number.tr('^[0-9]', '')
    unless number.empty?
      last_digit = number
    else
      letter_to_digit.each_pair do |key, value|
        last_digit = value if letter_number.include?(key.to_s.reverse)
      end
    end

    break unless last_digit.empty?
    letter_number
  end

"#{first_digit}#{last_digit}"
end

puts digitalized_input.map(&:to_i).sum
