lines = File.readlines('input.txt').map(&:chomp)

folds =
  lines
    .select { |l| l.start_with?('fold along') }
    .map { |l| l[11..-1].split('=') }

dots = lines.select { |l| l =~ /^\d/ }.map { |l| l.split(',').map(&:to_i) }

cols = dots.map(&:first).max
grid = (0..dots.map(&:last).max).to_a.map { |r| (0..cols).to_a.map { false } }

dots.each { |(x, y)| grid[y][x] = true }

def merge_lines(l1, l2)
  l1.zip(l2).map { |(a, b)| a || b }
end

def rot90(grid)
  grid.transpose.map(&:reverse)
end

def rotm90(grid)
  grid.map(&:reverse).transpose
end

def foldy(grid, y)
  before = grid[0..y - 1]
  after = grid[y + 1..-1]

  before.reverse!

  (0..[before.size, after.size].max - 1)
    .to_a
    .map { |i| merge_lines(before[i] || [], after[i] || []) }
    .reverse
end

def foldx(grid, x)
  rotm90(foldy(rot90(grid), x))
end

def fold(grid, f)
  f[0] == 'x' ? foldx(grid, f[1].to_i) : foldy(grid, f[1].to_i)
end

def print_grid(grid)
  grid.each { |row| puts row.map { |c| c ? '#' : '.' }.join }
end

def count_dots(grid)
  grid.flatten.count { |c| c }
end

while fold = folds.shift
  # print_grid(grid)
  grid = fold(grid, fold)
  break
end

# print_grid(grid)
puts count_dots(grid)
