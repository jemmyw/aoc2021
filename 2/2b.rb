lines = File.readlines("input.txt")

pos = lines.reduce([0,0,0]) do |acc, line|
  dir, n, _ = line.split(/\s+/)

  case dir
  when "forward"
    [acc[0] + n.to_i, acc[1], acc[2] + (acc[1] * n.to_i)]
  when "up"
    [acc[0], acc[1] - n.to_i, acc[2]]
  when "down"
    [acc[0], acc[1] + n.to_i, acc[2]]
  else
    acc
  end
end

puts pos.inspect
puts pos[0] * pos[2]