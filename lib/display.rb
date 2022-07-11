# frozen_string_literal: true

require 'rainbow/refinement'
using Rainbow

# Contains the messages displayed to the player.
module Display
  def display_instructions
    puts <<~HEREDOC

      #{'Welcome to Mastermind!'.underline}
      Immerse yourself in a world of code-breaking, mind-stimulating adventure!

      Two players: the Code-Maker and the Code-Breaker
      One code: the Code-Maker creates a code using a unique combination of 4 out of the 6 possible colors, displayed below:
      #{display_options(6)}

      CODE EXAMPLE:
      #{display_options(4)}

      Want to challenge yourself? Take a crack at being the #{'Code-Breaker'.underline}.
      The computer will generate the code and you will have 12 rounds to break it.

      Fancy testing the boundaries of the computer's wits?
      Hit it with your best shot by being the #{'Code-Maker'.underline}!
      You will be inputting a code of your choice and the computer will attempt to crack it.
      Heads up! The computer is kind of #{'smart'.underline}.
      It uses a strategy first presented by P.F.Swaszek in 2000 and it usually takes an average of 5 guesses to win.

      After each round the Code-Breaker will be getting #{'hints'.underline}:
      #{solid_peg.red} - means that the right color has been placed in its right position.
      #{empty_peg.red} - means that one of the colors is part of the code, however it's not in its right position.

      Use them to navigate through the game.

      Good luck!
      ----------
    HEREDOC
  end

  def display_options(num)
    options = []
    num.times do |i|
      options << colors((i + 1).to_s)
    end
    options.join('')
  end

  def display_select_game_mode
    "Pick the game mode #{'1 - Code-Maker'.underline} or #{'2 - Code-Breaker'.underline} (input 1/2):"
  end

  def display_guessing_prompt
    <<~HEREDOC
      #{display_round_number}
      Input your combination of choice. Use digits between 1 and 6 only.
    HEREDOC
  end

  def display_round_number
    rounds = @rounds_played.to_s
    "\n#{"Round #{rounds}".underline}"
  end

  def display_input_code
    "\nYou're the #{'Code-Maker'.underline}. Create a code by inputting 4 unique digits between 1 and 6."
  end

  def display_player_code(code)
    puts 'The code you chose is:'
    apply_color(code)
  end

  def display_player_guess(guess)
    "Your guess is: #{guess}"
  end

  def display_game_won_code_maker
    "\nThe computer has cracked your code!"
  end

  def display_game_won_code_breaker
    "\nYes lawd! You have won."
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
    @pegs.map!(&:red)
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
