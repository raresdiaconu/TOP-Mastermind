# frozen_string_literal: true

require_relative 'Computer'
require_relative 'Display'
require_relative 'Player'
require 'pry-byebug'
require 'rainbow/refinement'
using Rainbow
# require 'io/console'

# Contains the logic of the game.
class Game
  include Display
  attr_accessor :winner, :pegs, :rounds_played, :guess, :code

  def initialize
    @rounds_played = 0
    @winner = false
    @pegs = []
    @guess = ''
  end

  def play
    @code = Computer.generate_code
    reset_game
    display_instructions
    play_round while @winner == false && @rounds_played < 12
    game_lost if @rounds_played == 12
  end

  # private

  def play_round
    @rounds_played += 1
    check_right_pos(player_guess)
    display_pegs
    winner?
  end

  def player_guess
    puts display_prompt_guess
    @guess = gets.chomp.chars
    return invalid_input unless guess.length == 4

    @guess.each do |digit|
      return invalid_input unless digit.match(/[1-6]/)
    end
    apply_color(guess)
    @guess.map!(&:to_i)
  end

  def apply_color(code)
    code.each do |digit|
      print colors(digit.to_s)
    end
    puts
  end

  def check_right_pos(guess)
    temp_code = []
    @code.each_with_index do |digit, idx|
      if digit == guess[idx]
        add_solid_peg
        temp_code << nil
      else
        temp_code << digit
      end
    end
    check_any_pos(guess, temp_code)
  end

  def check_any_pos(guess, temp_code)
    guess.uniq.each do |digit|
      add_empty_peg if temp_code.include?(digit)
    end
  end

  def add_solid_peg
    @pegs << solid_peg
  end

  def add_empty_peg
    @pegs << empty_peg
  end

  def invalid_input
    puts display_invalid_input
    player_guess
  end

  def reset_game
    @rounds_played = 0
    @winner = false
    @pegs = []
    @guess = ''
  end

  def announce_winner
    puts display_game_won
  end

  def winner?
    return unless @guess == @code

    announce_winner
    @winner = true
    another_game?
  end

  def game_lost
    puts display_game_lost
    apply_color(code)
    another_game?
  end

  def another_game?
    puts display_another_game
    input = gets.chomp.upcase
    return puts 'Thanks for playing!' unless input == 'Y'

    play
  end
end
