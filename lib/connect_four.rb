# frozen_string_literal: true

# Connect 4 Game
require './lib/board'

class ConnectFour
  BOARD_WIDTH = 7
  BOARD_HEIGHT = 6

  def initialize(board = Board.new(BOARD_WIDTH, BOARD_HEIGHT))
    @board = board
    @turn = 1
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
    change_turn
    puts "Player #{@turn} is the winner. Congratulations!"
  end

  def user_input
    puts "Player #{@turn}: please input your move x,y\n"
    gets.chomp.split(',').map(&:to_i)
  end

  def make_move(move)
    @board.set(move[0], move[1], token)
  end

  def token
    @turn == 1 ? 'B' : 'W'
  end

  def change_turn
    @turn == 1 ? @turn = 2 : @turn = 1
  end

  def print_board
    @board.print_board
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
