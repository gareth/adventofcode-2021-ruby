#!/usr/bin/env ruby
# frozen_string_literal: true

depths = ARGF.lines.map { |line| Integer(line) }

puts depths.each_cons(2).count { |a, b| b > a }
