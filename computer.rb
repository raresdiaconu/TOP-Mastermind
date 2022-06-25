# frozen_string_literal: true

require_relative 'Display'
require_relative 'Game'
require 'pry-byebug'

# Generates a random code when player is guessing and contains the computer guessing logic.
class Computer
  include Display
  attr_accessor :all_permutations, :all_candidates, :new_candidates, :initial_guess, :guess, :current_pegs

  def initialize
    @range = [1, 2, 3, 4, 5, 6]
    @all_permutations = create_all_permutations(@range)
    # @all_permutations = [[1, 1, 2, 2], [1, 2, 3, 4], [1, 2, 1, 1]]
    @all_candidates = @all_permutations.clone
    @new_candidates = @all_candidates.clone
    @initial_guess = [1, 1, 2, 2]
    @guess = []
    @current_pegs = []
  end

  def create_all_permutations(range)
    range.repeated_permutation(4).to_a
  end

  def make_guess(rounds_played)
    # return @guess = initial_guess if rounds_played == 1
    if rounds_played == 1
      @guess = initial_guess
      apply_color(@guess)
      return @guess
    end
    @guess = @all_candidates.sample(1).flatten
    apply_color(@guess)
    @guess
  end

  def sort_new_candidates(pegs)
    @all_candidates.each do |candidate|
      computer_check_right_pos(candidate, @guess)
      @new_candidates.delete(candidate) unless current_pegs == pegs
      current_pegs.clear
    end
    @all_candidates = @new_candidates.clone

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

  def computer_check_right_pos(candidate, current_guess)
    temp_code = []
    temp_guess = []
    candidate.each_with_index do |digit, idx|
      if digit == current_guess[idx]
        current_pegs << solid_peg
        temp_code << nil
        temp_guess << nil
      else
        temp_code << digit
        temp_guess << current_guess[idx]
      end
    end
    computer_check_any_pos(temp_guess, temp_code)
  end

  def computer_check_any_pos(current_guess, temp_code)
    current_guess.uniq.each do |digit|
      current_pegs << empty_peg if temp_code.include?(digit) && !digit.nil?
    end
  end

  def generate_code
    (1..6).to_a.sample(4)
  end
end
