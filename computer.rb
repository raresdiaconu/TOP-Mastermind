# frozen_string_literal: true

require_relative 'Game'

# Generates a random code when player is guessing and contains the computer guessing logic.
class Computer
  attr_accessor :all_permutations, :all_candidates

  def initialize
    @range = %w[1 2 3 4 5 6]
    @all_permutations = create_all_permutations(@range)
    @all_candidates = @all_permutations
    @initial_guess = %w[1 1 2 2]
  end

  def create_all_permutations(range)
    range.repeated_permutation(4).to_a
  end

  def computer_guess
    return @guess = @initial_guess if @rounds_played == 1

    @guess = @all_candidates.sample(1)
  end

  def compare_guess(hints, guess)
    
  end

  def self.generate_code
    (1..6).to_a.sample(4)
  end
end
