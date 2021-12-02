data = File.read("input_1.txt").chomp
lines = data.lines

numbers = lines.map do |string|
  string.to_i
end

count = 0
previous_number = nil

numbers.each do |number|
  if previous_number && number > previous_number
    count = count + 1
  end

  previous_number = number
end

puts count