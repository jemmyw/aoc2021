require "byebug"
lines = File.readlines("input.txt").map(&:chomp)

counter = [[0,0]] * lines.first.chars.length

count = lines.reduce(counter) do |acc, line|
  line.chars.each_with_index.map do |bit, index|
    if bit == "0"
      [acc[index][0] + 1, acc[index][1]]
    elsif bit == "1"
      [acc[index][0], acc[index][1] + 1]
    else
      acc
    end
  end
end

gamma = count.map do |(z,o)|
  z > o ? 0 : 1
end.join("").to_i(2)

epsilon = count.map do |(z,o)|
  z < o ? 0 : 1
end.join("").to_i(2)

puts gamma * epsilon
