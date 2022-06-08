# frozen_string_literal: true

# Generates a random code when player is guessing and contains the computer guessing logic.
class Computer
  def self.generate_code
    (1..6).to_a.sample(4)
  end
end
