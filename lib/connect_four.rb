# frozen_string_literal: true

# Connect 4 Game
class ConnectFour
  BOARD_WIDTH = 7
  BOARD_HEIGHT = 6

  def initialize(board = Board.new)
    @board = board
  end

  def play_game
    until winner?
      move = user_input
      make_move(move)
      change_turn
      print_board
    end
    end_of_game
  end

  def end_of_game
  end

  def user_input
  end

  def make_move(move)
  end

  def change_turn
  end

  def print_board
  end

  def valid_space?(x, y)
    x >= 0 && x < BOARD_WIDTH && y >= 0 && y < BOARD_HEIGHT
  end

  def winner?
    result = false;
    BOARD_WIDTH.times do |x|
      BOARD_HEIGHT.times do |y|
        result ||= four_in_a_row?(x, y)
      end
    end
    result
  end

  def four_in_a_row?(x, y)
    return false unless valid_space?(x, y)

    token = @board.coord(x, y)
    return false if token.nil?

    horizontal_row?(x, y, token) || vertical_row?(x, y, token) || positive_slope_diag_row?(x, y, token) ||
      negative_slope_diag_row?(x, y, token)
  end

  def horizontal_row?(x, y, token)
    match?(x + 1, y, token) && match?(x + 2, y, token) && match?(x + 3, y, token)
  end

  def vertical_row?(x, y, token)
    match?(x, y + 1, token) && match?(x, y + 2, token) && match?(x, y + 3, token)
  end

  def positive_slope_diag_row?(x, y, token)
    match?(x + 1, y + 1, token) && match?(x + 2, Y + 2, token) && match?(x + 3, y + 3, token)
  end

  def negative_slope_diag_row?(x, y, token)
    match?(x - 1, y + 1, token) && match?(x - 2, y + w, token) && match?(x - 3, y + 3, token)
  end

  def match?(x, y, token)
    return false unless valid_space?(x, y)

    @board.coord(x, y) == token
  end
end
