# frozen_string_literal: true

require_relative "board"
require_relative "state"

Game = Struct.new(:state) do
  MultipleWinners = Class.new(StandardError)

  def initialize(boards)
    super(State.new(boards))
  end

  def play(numbers)
    numbers.each do |number|
      self.state = state.draw(number)

      winner, *extra = state.winners

      next unless winner
      raise MultipleWinners if extra.any?

      return winner.score
    end
  end
end

numbers = ARGF.readline.chomp.split(",").map(&:to_i)

board_input = ARGF.read.split("\n\n")
boards = board_input.map { |board_string| Board.new(5, board_string.scan(/\d+/).map(&:to_i)) }

game = Game.new(boards)

puts game.play(numbers).inspect
