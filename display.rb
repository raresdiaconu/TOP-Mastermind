# frozen_string_literal: true

# Contains the messages displayed to the player.
module Display
  def input_guess
    'Input your 4 digits guess.'
  end

  def game_won
    'Congrats! You have won.'
  end

  def game_lost
    'Try again. Game lost.'
  end

  def another_game
    'Would you like to play again?'
  end
end
