require "byebug"
lines = File.readlines('input.txt')

rules = lines.select { |l| l =~ /->/ }.map { |l| l.chomp.split(' -> ') }.to_h
template = lines.first.chomp.split('')

current = template
pairs = current.each_cons(2).to_a
pairs = pairs.map{|p| [p,pairs.count(p)]}.to_h
counts = current.uniq.map { |c| [c, current.count(c)] }.to_h
counts.default = 0

40.times do |n|
  new_pairs = pairs.reduce(Hash.new{0}) do |acc, ((a, b), c)|
    d = rules[[a, b].join]
    counts[d] += c
    acc[[a, d]] += c
    acc[[d, b]] += c
    acc
  end
  pairs = new_pairs
end

puts counts.sort.inspect
puts counts.values.max
puts counts.values.min
puts counts.values.max - counts.values.min
