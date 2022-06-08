# frozen_string_literal: true

require_relative 'computer'
require_relative 'display'
require_relative 'player'

# Contains the logic of the game.
class Game
  include Computer
  include Display
  include Player

  @games_played = 0

  def play
    @code = Computer.generate_code
    reset_game
    play_round until winner?
  end

  def play_round
    return game_lost if @games_played == 12

    @games_played += 1
  end

  def reset_game
    @games_played = 0
  end

  def winner?(temp_code)
    return unless temp_code.uniq? == 1

    announce_winner
    true
  end

  def announce_winner
    puts display.game_won
  end

  def game_lost
    puts display.game_lost
    another_game?
  end

  def another_game?
    puts display.another_game
    if user.gets.chomp.upcase == 'Y'
      play
    else
      'Thanks for playing.'
    end
  end
end
