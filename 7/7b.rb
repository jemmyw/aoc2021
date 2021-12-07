require "byebug"
poss = File.read("input.txt").scan(/\d+/).map(&:to_i)

f = (poss.min..poss.max).reduce(nil) do |m,n|
  fuel = poss.reduce(0.0) do |a,c|
    steps = (n-c).abs.to_f
    a + ((steps*(steps+1))/2)
  end

  if m.nil?
    fuel
  else
    [fuel,m].min
  end
end
puts f