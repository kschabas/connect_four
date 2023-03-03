# frozen_string_literal: true

# Connect 4 Game
class ConnectFour
  def initialize( board = Board.new)
    @board = board
  end

  def play_game
    until winner?
      move = user_input
      make_move(move)
      change_turn
      print_board
    end
  end
end
