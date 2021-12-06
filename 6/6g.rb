f=File.read("input.txt").chomp.split(",").map(&:to_i).reduce([0]*9){|c,n|c[n]+=1;c}
80.times{f=f.each_with_index.reduce([0]*9){|c,(n,t)|t==0?c[6]+=n&&c[8]+=n:c[t-1]+=n;c}}
p f.sum