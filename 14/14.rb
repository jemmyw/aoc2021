lines = File.readlines('input.txt')

rules = lines.select { |l| l =~ /->/ }.map { |l| l.chomp.split(' -> ') }.to_h
template = lines.first.chomp.split('')

current = template

1.times do |n|
  current =
    current
      .each_cons(2)
      .each_with_index
      .reduce([]) do |acc, ((a, b), idx)|
        acc << a if idx == 0
        acc << rules[[a, b].join]
        acc << b
        acc
      end
end

types = current.uniq
counts = types.map { |t| [t, current.count(t)] }.to_h
puts counts.sort.inspect
puts counts.values.max
puts counts.values.min
puts counts.values.max - counts.values.min
