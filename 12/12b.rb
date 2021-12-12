require "byebug"
conns = File.readlines('input.txt').map { |line| line.chomp.split(/-/) }

paths = []

class Cave
  attr_reader :name, :conns

  def initialize(name)
    @name = name
    @conns = []
  end

  def <<(other)
    @conns << other
  end
end

caves =
  conns.reduce(
    Hash.new { |hash, key| hash[key] = Cave.new(key) },
  ) do |acc, (a, b)|
    acc[a] << b
    acc[b] << a
    acc
  end

start_cave = caves['start']
end_cave = caves['end']

to_explore = [['start']]

while to_explore.any?
  partial_path = to_explore.shift
  current_cave = caves[partial_path.last]

  if current_cave.name == "end"
    paths << partial_path
    next
  end

  next_caves = current_cave.conns.reject do |c|
    next true if c == "start"
    if c.downcase == c && partial_path.include?(c)
      small_caves = partial_path.select{|c|c.downcase == c}
      true if small_caves.uniq.size < small_caves.size
    end
  end

  to_explore.push(*next_caves.map { |c| partial_path + [c] })
  puts to_explore.length
end

puts paths.length