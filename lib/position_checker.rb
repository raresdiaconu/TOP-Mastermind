# frozen_string_literal: true

# handles comparing the code to the current guess
# computer: helps compare the current computer guess to all still available possible solution candidates
module PositionChecker
  def check_right_position(code, guess)
    temp_code = []
    temp_guess = []
    code.each_with_index do |digit, idx|
      if digit == guess[idx]
        pegs << solid_peg
        temp_code << nil
        temp_guess << nil
      else
        temp_code << digit
        temp_guess << guess[idx]
      end
    end
    check_any_position(temp_guess, temp_code)
  end

  def check_any_position(current_guess, temp_code)
    current_guess.uniq.each do |digit|
      pegs << empty_peg if temp_code.include?(digit) && !digit.nil?
    end
  end
end
