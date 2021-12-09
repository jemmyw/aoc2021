require "set"
map = File.readlines("input.txt").map(&:strip).map{|l|l.strip.split("").map(&:to_i)}

low_points = []

def adj(map,p)
  [
    p[0]>0&&[p[0]-1, p[1]],
    p[0]<map.length-1&&[p[0]+1, p[1]],
    p[1]>0&&[p[0], p[1]-1],
    p[1]<map[0].length-1&&[p[0], p[1]+1]
  ].select(&:itself)
end

def values(map,points)
  points.map{|p|map.dig(*p)}
end

def adj_w_v(map,p)
  adj_p = adj(map,p)
  adj_v = values(map,adj_p)
  adj_p.each_with_index.map do |p,i|
    [p, adj_v[i]]
  end
end

map.each_with_index do |row, ri|
  row.each_with_index do |col, ci|
    adj_v = values(map, adj(map, [ri, ci]))

    if col < adj_v.min
      low_points << [ri,ci]
      # $stdout.write "\033[31;1m#{col}\033[0m"
    else
      # $stdout.write col
    end
  end

  # $stdout.write "\n"
end

puts low_points.map{|l|map.dig(*l)+1}.sum

basins = []
checked = Set.new

low_points.each do |p|
  check = [p] - checked.to_a
  next if check.empty?
  b = []

  while p = check.pop
    b << p
    checked.add(p)
    next_points = adj_w_v(map, p)
      .reject{|p,v|v==9}
      .map(&:first) - checked.to_a

    check = (check - next_points).push(*next_points)
  end

  basins << b
end

colors = 300.times.map do |n|
  3.times.map { Random.rand(255) }
end

map.each_with_index do |row,ri|
  row.each_with_index do |col,ci|
    basin = basins.index {|b|b.include?([ri,ci])}

    if basin
      r,g,b = colors[basin]
      $stdout.write "\033[48;2;#{r};#{g};#{b}m#{col}\033[0m"
    else
      $stdout.write "#{col}"
    end
  end
  $stdout.write "\n"
end

puts ""
puts basins.sort_by(&:size).reverse.take(3).map(&:size)