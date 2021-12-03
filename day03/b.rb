# frozen_string_literal: true

def most_common_bit(reports, position, criteria)
  frequencies = [0, 0]

  reports.each do |report|
    frequencies[report[position].to_i] += 1
  end

  frequencies.each_with_index.send(criteria)[1]
end

def filter_reports(reports, bit, criteria)
  target = most_common_bit(reports, bit, criteria)

  reports.select do |report|
    report[bit].to_i == target
  end
end

def rating(reports, criteria)
  position = 0

  while reports.size > 1
    reports = filter_reports(reports, position, criteria)
    position += 1
  end
  reports.first.to_i(2)
end

reports = ARGF.lines.map(&:chomp)

oxygen_generator_rating = rating(reports, :max)
co2_scrubber_rating = rating(reports, :min)

puts oxygen_generator_rating * co2_scrubber_rating
