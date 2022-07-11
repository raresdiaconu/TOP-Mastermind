# frozen_string_literal: true

require_relative 'Display'
require_relative 'Position_Checker'
require_relative 'Game'
require 'pry-byebug'

# Generates a random code when player is guessing and contains the computer guessing logic.
class Computer
  include Display
  include PositionChecker
  attr_accessor :all_permutations, :all_candidates, :new_candidates, :initial_guess, :guess, :pegs

  def initialize
    @range = [1, 2, 3, 4, 5, 6]
    @all_permutations = create_all_permutations(@range)
    @all_candidates = @new_candidates = @all_permutations.clone
    @initial_guess = [1, 1, 2, 2]
    @guess = []
    @pegs = []
  end

  def create_all_permutations(range)
    range.repeated_permutation(4).to_a
  end

  def make_guess(rounds_played)
    return @guess = initial_guess if rounds_played == 1

    @guess = @all_candidates.sample(1).flatten
  end

  def sort_new_candidates(current_rounds_pegs)
    @all_candidates.each do |candidate|
      check_right_position(candidate, @guess)
      @new_candidates.delete(candidate) unless pegs == current_rounds_pegs
      pegs.clear
    end
    @all_candidates = @new_candidates.clone
  end

  def generate_code
    (1..6).to_a.sample(4)
  end

  def reset_permutations
    @all_candidates = @new_candidates = @all_permutations.clone
  end
end
