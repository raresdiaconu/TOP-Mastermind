# frozen_string_literal: true

require_relative 'Computer'
require_relative 'Display'
require_relative 'Player'
require 'pry-byebug'
require 'rainbow/refinement'
using Rainbow

# Contains the logic of the game.
class Game
  include Display
  attr_accessor :winner, :pegs, :rounds_played, :guess, :code, :game_mode, :player, :computer

  def initialize
    @player = Player.new
    @computer = Computer.new
    @rounds_played = 0
    @winner = false
    @pegs = []
  end

  def play
    reset_game
    display_instructions
    select_game_mode
    create_code
    display_player_code(code) if game_mode == '1'
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
    @code = game_mode == '1' ? player.input_code : computer.generate_code
  end

  def play_round
    @rounds_played += 1
    game_mode == '1' ? code_maker : code_breaker
    apply_color(@guess)
    display_pegs
    winner?
  end

  def code_maker
    puts display_round_number
    @guess = computer.make_guess(rounds_played)
    check_right_pos(@guess)
    computer.sort_new_candidates(pegs)
    sleep 0.5
  end

  def code_breaker
    puts display_guessing_prompt
    @guess = player.input_guess
    check_right_pos(@guess)
  end

  def check_right_pos(guess)
    temp_code = []
    @code.each_with_index do |digit, idx|
      if digit == guess[idx]
        add_peg(solid_peg)
        temp_code << nil
      else
        temp_code << digit
      end
    end
    check_any_pos(guess, temp_code)
  end

  def check_any_pos(guess, temp_code)
    guess.uniq.each do |digit|
      add_peg(empty_peg) if temp_code.include?(digit)
    end
  end

  def add_peg(peg)
    @pegs << peg
  end

  def invalid_selection_input
    puts display_invalid_input
    select_game_mode
  end

  def reset_game
    @rounds_played = 0
    @winner = false
    @pegs.clear
    @guess = ''
    computer.reset_permutations
  end

  def announce_winner
    puts game_mode == '1' ? display_game_won_code_maker : display_game_won_code_breaker
  end

  def winner?
    return unless @guess == @code || computer.guess == @code

    announce_winner
    @winner = true
    another_game?
  end

  def game_lost
    puts game_mode == '1' ? display_game_lost_code_maker : display_game_lost_code_breaker
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
