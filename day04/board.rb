# frozen_string_literal: true

Board = Struct.new(:size, :cells, :drawn) do
  IrregularBoard = Class.new(ArgumentError)

  def initialize(size, cells, drawn = [])
    raise IrregularBoard, "Board was size #{cells.size} (expected #{size**2})" unless cells.size == size**2

    super(size, cells, drawn)
    @rows = cells.each_slice(size).to_a
    @columns = cells.group_by.with_index { |_x, i| i % 5 }.values
    @lines = @rows + @columns
  end

  def unmarked
    cells - drawn
  end

  def complete?
    @lines.find { |l| (l - drawn).empty? }
  end

  def score
    return unless complete?

    unmarked.sum * drawn.last
  end

  def draw(number)
    # Don't add to drawn numbers if complete
    next_numbers = complete? ? drawn : drawn + [number]
    self.class.new(size, cells, next_numbers)
  end
end
