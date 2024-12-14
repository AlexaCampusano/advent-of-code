def valid_report?(report, condition)
  report.each_cons(2).map do |prev, nxt|
    condition.call(prev, nxt)
  end.all?
end

input = File.read("input.txt").split("\n")

conditions = [
  ->(prev, nxt) { prev > nxt && (1..3).include?(prev - nxt) }, # Increasing condition
  ->(prev, nxt) { nxt > prev && (1..3).include?(nxt - prev) } # Decreasing condition
]

valid_reports_count = conditions.sum do |condition|
  input.count do |line|
    report = line.split.map(&:to_i)
    valid_report?(report, condition)
  end
end

puts valid_reports_count
