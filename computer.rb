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

  # def make_move

  # end

  def compare_guess(_hints, _guess)
    @temp_pegs = @pegs

    # make the initial guess and get the first set of pegs.
    # assign the value of @pegs to another instance variable, called @temp_pegs
    # take the @all candidates array of arrays (or possible codes)
    # assign Each of them as the @code
    # call the check_right_pos method
    # after getting the number and type of pegs (another array) compare it to the @temp_pegs (initial guess)
    # if the number and type of pegs are different (arrays are not equal),
    # delete the currently assessed code from the @all candidates array
    # 
  end

  def self.generate_code
    (1..6).to_a.sample(4)
  end
end
