lines = File.readlines("input.txt").map(&:chomp)
draw = lines.shift.split(",").map(&:to_i)
lines.shift

class Board
  attr_reader :marked

  def initialize(board)
    @rows = board
    @cols = 5.times.map do |n|
      @rows.map do |r|
        r.at(n)
      end
    end
    @lines = @rows + @cols
    @drawn = []
    @marked = @lines.map do |line|
      line.map { |_| false }
    end
  end

  def draw(number)
    @drawn << number
    @lines.each_with_index do |line, line_index|
      line.each_with_index do |n, n_index|
        if n == number
          @marked[line_index][n_index] = true
        end
      end
    end

    if won?
      unmarked.sum * number
    else
      nil
    end
  end

  def won?
    @marked.any? do |marks|
      marks.all?
    end
  end

  def unmarked
    @rows.reduce([]) do |acc, row|
      row.each do |n|
        if !@drawn.include?(n)
          acc << n
        end
      end
      acc
    end
  end
end

boards = []
current_board = []

lines.each do |line|
  if line == ""
    boards << Board.new(current_board)
    current_board = []
  else
    current_board << line.strip.split(/\s+/).map(&:to_i)
  end
end

if current_board.any?
  boards << Board.new(current_board)
end

winners = []

draw.each do |number|
  boards.reject! do |board|
    if score = board.draw(number)
      winners << score
      true
    else
      false
    end
  end
end

puts winners.last.inspect