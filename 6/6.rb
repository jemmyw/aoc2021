require "byebug"

fish = File.read("input.txt").chomp.split(",").map(&:to_i)

puts fish.inspect

80.times do |day|
  new_fish = fish.map do |n|
    if n == 0
      6
    else
      n - 1
    end
  end

  fish.each do |n|
    if n == 0
      new_fish << 8
    end
  end

  fish = new_fish
end

puts fish.length