class Board
  def initialize(width, height)
    @board = Array.new(height) { Array.new(width, nil) }
  end

  def coord(x, y)
    @board[y][x]
  end

  def set(x, y, token)
    @board[y][x] = token
  end

  def print_board
    @board.reverse.each  { |row| print_row(row) }
  end

  def print_row(row)
    row.each { |token| print_token(token)}
    print "\n"
  end

  def print_token(token)
    if token.nil?
      print '. '
    elsif token == 'B'
      print "\u26AB"
    else
      print "\u26AA"
    end
  end

end