# frozen_string_literal: true

require 'rainbow/refinement'
using Rainbow
require 'pry-byebug'

# Contains the messages displayed to the player.
module Display
  def display_instructions
    puts <<~HEREDOC.strip
      Welcome to Mastermind!

      The computer will create a code of 4 colors.
      You will have 12 rounds to guess that code by inputting a combination of 4 of the colors below.
      #{display_all_options}

      After each round you will be getting #{'hints'.underline}:
      #{solid_peg} - means that you have placed the right color in the right position.
      #{empty_peg} - means that you have placed the right color in the wrong position.

      Good luck!
      ----------
    HEREDOC
  end

  def display_all_options
    options = []
    6.times do |i|
      options << colors((i + 1).to_s)
    end
    options.join('')
  end

  def display_select_game_mode
    puts 'Pick the game mode 1)Code-Maker or 2)Code-Breaker (input 1/2):'
  end

  def display_prompt_guess
    rounds = @rounds_played.to_s
    <<~HEREDOC

      #{"Round #{rounds}".underline}
      Input your combination of choice. Use digits between 1 and 6 only.
    HEREDOC
  end

  def display_input_code
    "You're the Code-Maker. Create a code by inputting digits between 1 and 6. No duplicates allowed."
  end

  def display_player_guess(guess)
    "Your guess is: #{guess}"
  end

  def display_game_won_code_maker
    'The computer has won.'
  end

  def display_game_won_code_breaker
    'Congrats! You have won.'
  end

  def display_game_lost_code_maker
    "\nThe computer didn't manage to crack your code. Your code was:"
  end

  def display_game_lost_code_breaker
    "\nShucks! You don't seem to have cracked the code. The code was:"
  end

  def display_another_game
    "\nWould you like to play again? (Y/N)"
  end

  def display_invalid_input
    'Your input is invalid.'
  end

  def solid_peg
    '●'
  end

  def empty_peg
    '○'
  end

  def display_pegs
    puts "HINTS: #{@pegs.shuffle.join(' ')}"
    @pegs = []
  end

  def colors(color)
    colors = {
      '1' => '   1   '.white.bright.bg(:red),
      '2' => '   2   '.white.bright.bg(:yellow),
      '3' => '   3   '.white.bright.bg(:magenta),
      '4' => '   4   '.white.bright.bg(:cyan),
      '5' => '   5   '.black.bright.bg(:silver),
      '6' => '   6   '.white.bright.bg(:black)
    }
    colors[color]
  end

  def apply_color(code)
    code.each do |digit|
      print colors(digit.to_s)
    end
    puts
  end
end
