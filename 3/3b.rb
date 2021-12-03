require "byebug"
lines = File.readlines("input.txt").map(&:chomp)

def count_a_column(list, column)
  counter = [0,0]

  count = list.reduce(counter) do |acc, line|
    bit = line.chars[column]

    if bit == "0"
      [acc[0] + 1, acc[1]]
    elsif bit == "1"
      [acc[0], acc[1] + 1]
    else
      acc
    end
  end
end

oxy_list = lines.dup
oxy_pos = 0

while oxy_list.length > 1
  counts = count_a_column(oxy_list, oxy_pos)
  bit = if counts[0] == counts[1]
    "1"
  elsif counts[0] > counts[1]
    "0"
  else
    "1"
  end

  oxy_list.select! do |line|
    line.chars[oxy_pos] == bit
  end
  oxy_pos += 1
end

co2_list = lines.dup
co2_pos = 0

while co2_list.length > 1
  counts = count_a_column(co2_list, co2_pos)
  bit = if counts[0] == counts[1]
    "0"
  elsif counts[0] < counts[1]
    "0"
  else
    "1"
  end

  co2_list.select! do |line|
    line.chars[co2_pos] == bit
  end
  co2_pos += 1
end

puts oxy_list.first.to_i(2) * co2_list.first.to_i(2)