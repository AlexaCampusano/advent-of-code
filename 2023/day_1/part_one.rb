input = File.read("input.txt").split("\n")
calibration_combo = input.map do |line|
  digits = line.tr('^[0-9]', '')
  "#{digits[0] + digits[-1]}".to_i
end
puts calibration_combo.sum
