h=->{Hash.new(0)};f=IO.read("input.txt").scan(/\d+/).reduce(h[]){|c,n|c[n.to_i]+=1;c}
80.times{r=h[];r[6]=r[8]=f[0];f.each{|t,n|t>0&&r[t-1]+=n};f=r};p f.values.sum