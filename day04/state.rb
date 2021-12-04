# frozen_string_literal: true

State = Struct.new(:boards, :drawn) do
  def initialize(boards, drawn = [])
    super(boards, drawn)
  end

  def draw(number)
    self.class.new(
      boards.map { |b| b.draw(number) },
      drawn + [number]
    )
  end

  def winners
    boards.select(&:complete?)
  end

  def losers
    boards.reject(&:complete?)
  end
end
