require "byebug"
poss = File.read("input.txt").scan(/\d+/).map(&:to_i).sort


f = poss.reduce(nil) do |m,n|
  fuel = poss.reduce(0) do |a,c|
    a += (n-c).abs
  end

  if m.nil?
    fuel
  else
    [fuel,m].min
  end
end
puts f