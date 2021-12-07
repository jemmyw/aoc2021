r=IO.read("input.txt").scan(/\d+/).map(&:to_i)
p (r.min..r.max).map{|n|r.reduce(0){|a,c|s=(n-c).abs;a+s*(s+1)/2}}.min