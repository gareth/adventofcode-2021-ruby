#!/usr/bin/env ruby
# frozen_string_literal: true

Position = Struct.new(:horizontal, :vertical) do
  def forward(distance)
    Position.new(horizontal + distance, vertical)
  end

  def up(distance)
    Position.new(horizontal, vertical - distance)
  end

  def down(distance)
    Position.new(horizontal, vertical + distance)
  end

  def to_s
    "#{horizontal},#{vertical}"
  end
end

instructions = ARGF.lines.map(&:chomp)

position = instructions.inject(Position.new(0, 0)) do |p, i|
  direction, distance = i.split(" ", 2)
  p.send(direction, distance.to_i)
end

puts position.horizontal * position.vertical
