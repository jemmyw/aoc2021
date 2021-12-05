e=[0,1];puts File.readlines("input.txt").map{|l|l.chomp.split(/,|\s+\->\s+/).map(&:to_i)}
  .select{|l|e.any?{|p|l[p]==l[p+2]}}
  .flat_map{|l|d=e.map{|p|l[p+2]<=>l[p]};(e.map{|p|(l[p]-l[p+2]).abs}.max+1).times.map{|t|e.map{|p|l[p]+t*d[p]}}}
  .reduce([]){|g,(x,y)|r=(g[y]||=[]);r[x]=r[x].to_i+1;g[y]=r;g}.reduce(0){|c,r|c+r&.select{|n|n&&n>1}&.size.to_i}