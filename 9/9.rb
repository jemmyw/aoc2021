map = File.readlines("input.txt").map(&:strip).map{|l|l.strip.split("").map(&:to_i)}

low_points = []

map.each_with_index do |row, ri|
  row.each_with_index do |col, ci|
    adj = [
      ri>0&&map.dig(ri-1, ci),
      map.dig(ri+1, ci),
      ci>0&&map.dig(ri, ci-1),
      map.dig(ri, ci+1)
    ].select(&:itself)

    if col < adj.min
      low_points << col
      $stdout.write "\033[31;1m#{col}\033[0m"
    else
      $stdout.write col
    end
  end

  $stdout.write "\n"
end
