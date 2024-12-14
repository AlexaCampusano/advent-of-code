def valid_report?(report, condition)
  report.each_cons(2).map do |prev, nxt|
    condition.call(prev, nxt)
  end.all?
end

def safe_report_with_removal?(report, condition)
  (0...report.length).any? do |i|
    new_report = report[0...i] + report[i+1..-1]
    valid_report?(new_report, condition)
  end
end

input = File.read("input.txt").split("\n")

conditions = [
  ->(prev, nxt) { prev > nxt && (1..3).include?(prev - nxt) }, # Increasing condition
  ->(prev, nxt) { nxt > prev && (1..3).include?(nxt - prev) } # Decreasing condition
]

valid_reports_count = conditions.sum do |condition|
  input.count do |line|
    report = line.split.map(&:to_i)
    valid_report?(report, condition) || safe_report_with_removal?(report, condition)
  end
end

puts valid_reports_count
