# frozen_string_literal: true

require_relative 'computer'
require_relative 'Display'
require_relative 'player'

# Contains the logic of the game.
class Game
  include Display

  @rounds_played = 0
  @@winner = false
  @@pins = []

  def play
    @code = Computer.generate_code
    reset_game
    play_round until @@winner == true
  end

  # private

  def play_round
    return game_lost if @rounds_played == 12

    @rounds_played += 1
    check_right_pos(player_guess)
    display_pins
  end

  def player_guess
    puts display_prompt_guess
    guess = gets.chomp.chars
    return invalid_input unless guess.length == 4

    guess.each do |digit|
      return invalid_input unless digit.match(/[1-6]/)
    end
    puts "The code is #{@code}"
    puts display_player_guess(guess)
    guess.map!(&:to_i)
  end

  def check_right_pos(guess)
    temp_code = []
    @code.each_with_index do |digit, idx|
      if digit == guess[idx]
        add_solid_pin
        temp_code << nil
      else
        temp_code << digit
      end
    end
    winner?(temp_code)
    check_any_pos(guess, temp_code)
  end

  def check_any_pos(guess, temp_code)
    guess.uniq.each do |digit|
      add_empty_pin if temp_code.include?(digit)
    end
  end

  def display_pins
    p @@pins
    @@pins = []
  end

  def add_solid_pin
    puts "Solid Pin"
    @@pins << "SOLID"
  end

  def add_empty_pin
    puts "Empty pin"
    @@pins << "EMPTY"
  end

  def invalid_input
    puts display_invalid_input
    player_guess
  end

  def reset_game
    @rounds_played = 0
  end

  def announce_winner
    puts display_game_won
  end

  def winner?(temp_code)
    return unless temp_code.uniq.length == 1

    announce_winner
    @@winner = true
  end

  def game_lost
    puts display_game_lost
    another_game?
  end

  def another_game?
    puts display_another_game
    input = gets.chomp.upcase
    return puts 'Thanks for playing' unless input == 'Y'
  end
end
