# frozen_string_literal: true

require_relative 'computer'
require_relative 'display'
require_relative 'game'
require_relative 'player'

def play_game
  game = Game.new
  game.play
end

play_game
