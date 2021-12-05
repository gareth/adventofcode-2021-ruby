# frozen_string_literal: true

require "pry"

DAY_GLOB = "day*"
INPUTS = {
  test: "test.txt",
  challenge: "input.txt"
}.freeze

task default: :current

desc "Run the latest day's exercise"
last = Dir[DAY_GLOB].max
task :current => last

paths = Pathname.glob(DAY_GLOB)

paths.each do |dir|
  day = dir.to_s[/(?<=day)\d+/].to_i

  # e.g. `rake day03`
  desc "Run day #{day} exercises"
  task dir do
    puts "Running day #{day}"

    dir.glob("?.rb").sort.each do |exercise|
      INPUTS.each do |level, file|
        input = dir.join(file)
        if input.file?
          puts "Running #{level} input"
          puts `ruby #{exercise} #{input}`
        end
      end
    end
  end

  # e.g. `rake 3` as a shortcut
  task day => dir
end

desc "Run all days's exercises"
task :all => paths.sort
