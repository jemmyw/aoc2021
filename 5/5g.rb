e=[0,1];puts File.readlines("input.txt").map{|l|l.chomp.split(/,|\s+\->\s+/).map(&:to_i)}
  .select{|l|e.any?{|p|l[p]==l[p+2]}}
  .flat_map{|l|d=e.map{|p|l[p+2]<=>l[p]};(e.map{|p|(l[p]-l[p+2]).abs}.max+1).times.map{|t|e.map{|p|l[p]+t*d[p]}}}
  .reduce({}){|h,p|h[p]=h[p].to_i+1;h}.select{|_,v|v>1}.size
