# frozen_string_literal: true

# Contains the messages displayed to the player.
module Display
  def display_prompt_guess
    'Input your 4 digits guess. Numbers between 1 and 6 only.'
  end

  def display_player_guess(guess)
    "Your guess is: #{guess}"
  end

  def display_game_won
    'Congrats! You have won.'
  end

  def display_game_lost
    'Try again. Game lost.'
  end

  def display_another_game
    'Would you like to play again?'
  end

  def display_invalid_input
    'Your input is invalid.'
  end
end
