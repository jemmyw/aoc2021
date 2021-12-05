require "byebug"
input_lines = File.readlines("input.txt").map(&:strip)

class Line
  attr_reader :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
  end

  def straight?
    @start[0] == @finish[0] || @start[1] == @finish[1]
  end

  def x1
    @start[0]
  end

  def x2
    @finish[0]
  end

  def y1
    @start[1]
  end

  def y2
    @finish[1]
  end

  def points
    # 0,9 -> 5,9

    start_point = [x1,y1]
    finish_point = [x2,y2]

    point = start_point.dup
    points = [point.dup]

    x_inc = x1 == x2 ? 0 : (x1 < x2 ? 1 : -1)
    y_inc = y1 == y2 ? 0 : (y1 < y2 ? 1 : -1)

    while point != finish_point
      point[0] += x_inc
      point[1] += y_inc
      points << point.dup
    end

    points
  end
end

class Grid
  def initialize
    @grid = []
  end

  def add(point)
    x,y = point
    line = @grid[y] || []
    line[x] = line[x].to_i + 1
    @grid[y] = line
  end

  def count_overlaps
    count = 0
    @grid.each do |line|
      if line.nil?
        next
      end

      line.each do |number|
        if number.to_i > 1
          count += 1
        end
      end
    end
    count
  end

  def to_s
    @grid.map do |line|
      (line || []).map do |n|
        "  #{n || 0}  "
      end.join("")
    end.join("\n")
  end
end


lines = input_lines.map do |input_line|
  start, finish = input_line.split(" -> ")
  Line.new(
    start.split(",").map(&:to_i),
    finish.split(",").map(&:to_i)
  )
end.select(&:straight?)

grid = Grid.new

lines.each do |line|
  line.points.each do |point|
    grid.add(point)
  end
end

puts grid.count_overlaps