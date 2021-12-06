require "byebug"

fish = File.read("input.txt").chomp.split(",").map(&:to_i)

fish = fish.reduce([0] * 9) do |acc, n|
  acc[n] += 1
  acc
end

256.times do |day|
  fish = (fish.each_with_index).reduce([0] * 9) do |acc, (number_of_fish, fish_timer)|
    if fish_timer == 0
      acc[6] += number_of_fish
      acc[8] += number_of_fish
    else
      acc[fish_timer - 1] += number_of_fish
    end
    acc
  end
end

puts fish.sum