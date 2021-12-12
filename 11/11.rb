lines = File.readlines("input.txt").map{|line|line.chomp.split("").map(&:to_i)}

flashes = 0
100.times do |n|
  flashed = []

  lines = lines.each_with_index.map do |line, ri|
    line.each_with_index.map do |o,ci|
      o += 1
      if o == 10
        o = 0
        flashes += 1
        flashed << [ri,ci]
      end
      o
    end
  end

  while p = flashed.shift
    [
      [p[0]-1,p[1]],
      [p[0],p[1]-1],
      [p[0]+1,p[1]],
      [p[0],p[1]+1],
      [p[0]-1,p[1]-1],
      [p[0]+1,p[1]-1],
      [p[0]-1,p[1]+1],
      [p[0]+1,p[1]+1]
    ].each do |(ri,ci)|
      next if ri < 0 || ci < 0
      o = lines.dig(ri,ci)
      next if o.nil?
      next if o == 0
      o = o + 1
      if o == 10
        o = 0
        flashes += 1
        flashed << [ri,ci]
      end
      lines[ri][ci] = o
    end
  end

  lines.each do |line|
    puts(line.map do |o|
      if o == 0
        "\33[1m#{o}\33[0m"
      else
        o.to_s
      end
    end.join(""))
  end
  puts "After #{n+1} seconds, there are #{flashes} lights lit."
end