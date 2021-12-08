# 0    ====
# 1 2 =    =
# 3    ====
# 4 5 =    =
# 6    ====

lines=File.readlines("input.txt")
count=0
numbers = {
  0 => [0,1,2,4,5,6],
  1 => [2,5],
  2 => [0,2,3,4,6],
  3 => [0,2,3,5,6],
  4 => [1,2,3,5],
  5 => [0,1,3,5,6],
  6 => [0,2,3,4,5,6],
  7 => [0,2,5],
  8 => [0,1,2,3,4,5,6,7],
  9 => [0,1,2,3,5,6]
}
unique = [1,7,4,8]

lines.each do |line|
  random,output = line.split("|")
  random = random.strip.split(" ")
  output = output.strip.split(" ")
  all = (random + output).map {|g| g.split("")}
  chars = all.flatten.uniq
  segments = ([[]]*8).map(&:dup)

  unique.each do |n|
    all.select{|g|g.size == numbers[n].size}.take(1).each do |g|
      puts g.inspect
      ms = numbers[n]
      puts ms.inspect

      g.dup.each do |c|
        ms.dup.each do |s|
          if segments[s] == [c]
            g = g - [c]
            break
          end

          if segments[s].size == 2
            if segments.select{|o| o==segments[s]}.size > 2
              puts "must be an error"
            elsif segments.select{|o| o==segments[s]}.size == 2
              g = g - segments[s]
              ms = ms - [s]
              break
            else
              puts "also error"
            end
          end

        end
      end

      ms.each do |s|
        segments[s] = (segments[s] | g).sort
      end
      puts segments.inspect
    end
  end

  segments.each {|s| s.sort!}

  puts segments.inspect
  exit
end