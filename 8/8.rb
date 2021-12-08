unique=[2,4,3,7]
lines=File.readlines("input.txt")
count=0
lines.each do |line|
  output=line.split("|")[1].strip.split(" ")
  output.each do |group|
    if unique.include?(group.size)
      count+=1
    end
  end
end

puts count