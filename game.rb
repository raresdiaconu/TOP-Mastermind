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
  attr_accessor :winner, :pegs, :rounds_played, :guess, :code, :game_mode, :player

  def initialize
    @player = Player.new
    @rounds_played = 0
    @winner = false
    @pegs = []
    @guess = ''
  end

  def play
    reset_game
    display_instructions
    select_game_mode
    create_code
    play_round while @winner == false && @rounds_played < 12
    game_lost if @rounds_played == 12
  end

  # private

  def select_game_mode
    puts display_select_game_mode
    @game_mode = gets.chomp
    return invalid_selection_input unless game_mode.length == 1 && game_mode.match(/[1-2]/)
  end

  def create_code
    @code = game_mode == '1' ? player.input_code : Computer.generate_code
  end

  def play_round
    @rounds_played += 1
    # potential improvement: this method should not assess the mode of the game every round
    game_mode == '1' ? code_maker : code_breaker
    display_pegs
    winner?
  end

  def code_maker
    # check_right_pos(computer_guess)
  end

  def code_breaker
    check_right_pos(player_guess)
  end

  def player_guess
    puts display_prompt_guess
    @guess = gets.chomp.chars
    return invalid_guess_input unless guess.length == 4

    @guess.each do |digit|
      return invalid_guess_input unless digit.match(/[1-6]/)
    end
    apply_color(guess)
    @guess.map!(&:to_i)
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
    @pegs << solid_peg.red
  end

  def add_empty_peg
    @pegs << empty_peg.red
  end

  def invalid_guess_input
    puts display_invalid_input
    player_guess
  end

  def invalid_selection_input
    puts display_invalid_input
    select_game_mode
  end

  def reset_game
    @rounds_played = 0
    @winner = false
    @pegs = []
    @guess = ''
  end

  def announce_winner
    game_mode == '1' ? display_game_won_code_maker : display_game_won_code_breaker
  end

  def winner?
    return unless @guess == @code

    announce_winner
    @winner = true
    another_game?
  end

  def game_lost
    game_mode == '1' ? display_game_lost_code_maker : display_game_lost_code_breaker
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
