# frozen_string_literal: true

require_relative 'Display'

# Gets the player's input: guesses and input.
class Player
  include Display

  def input_code
    puts display_input_code
    player_code = gets.chomp
    return invalid_code_input unless player_code.chars.uniq.length == 4 && player_code.match(/[1-6]/)

    player_code.chars.map!(&:to_i)
  end

  def invalid_code_input
    puts display_invalid_input
    input_code
  end

  def input_guess
    guess = gets.chomp.chars
    return invalid_guess_input unless guess.length == 4

    guess.each do |digit|
      return invalid_guess_input unless digit.match(/[1-6]/)
    end
    guess.map!(&:to_i)
  end

  def invalid_guess_input
    puts display_invalid_input
    input_guess
  end
end
