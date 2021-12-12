conns =
  File
    .readlines('input.txt')
    .map { |line| line.chomp.split(/-/) }
    .reduce(Hash.new { |h, k| h[k] = [] }) do |acc, (a, b)|
      acc[a] << b
      acc[b] << a
      acc
    end

paths = []
to_explore = [['start']]

while to_explore.any?
  partial_path = to_explore.shift
  current_cave = partial_path.last

  if current_cave == 'end'
    paths << partial_path
    next
  end

  next_caves =
    conns[current_cave].reject do |c|
      c.downcase == c && partial_path.include?(c)
    end

  to_explore.push(*next_caves.map { |c| partial_path + [c] })
end

paths.each { |path| puts path.join('->') }
puts paths.length
