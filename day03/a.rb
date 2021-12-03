# frozen_string_literal: true

reports = ARGF.lines.map(&:chomp)

frequencies = Hash.new { |h, k| h[k] = [0, 0] }

reports.each do |report|
  report.split(//).each.with_index do |char, i|
    frequencies[i][char.to_i] += 1
  end
end

gamma = frequencies.values.map { |x| x.each_with_index.max[1] }.join("").to_i(2)
epsilon = frequencies.values.map { |x| x.each_with_index.min[1] }.join("").to_i(2)

puts gamma * epsilon
