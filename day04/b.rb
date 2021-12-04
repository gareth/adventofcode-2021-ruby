# frozen_string_literal: true

require_relative "board"
require_relative "state"

Game = Struct.new(:state) do
  NoLosers = Class.new(StandardError)

  def initialize(boards)
    super(State.new(boards))
  end

  def play(numbers)
    to_draw = numbers.dup

    self.state = state.draw(to_draw.shift) until state.losers.size <= 1

    loser, * = state.losers

    # The last remaining loser doesn't have a full grid yet, so we need to play
    # out the rest of the board
    to_draw.each do |number|
      loser = loser.draw(number)
    end

    loser.score
  end
end

numbers = ARGF.readline.chomp.split(",").map(&:to_i)

board_input = ARGF.read.split("\n\n")
boards = board_input.map { |board_string| Board.new(5, board_string.scan(/\d+/).map(&:to_i)) }

game = Game.new(boards)

puts game.play(numbers).inspect
