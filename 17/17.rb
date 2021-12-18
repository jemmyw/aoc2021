require 'byebug'

target_x = 14..50
target_y = -267..-225
target_ranges = [target_x, target_y]

def pos(t, velocity)
  return 0, 0 if t == 0
  tx = (0.5 * (t**2) - 0.5 * t)

  x =
    if t > velocity[0]
      vx = velocity[0] + 1
      velocity[0] * vx - (0.5 * (vx**2) - 0.5 * vx)
    else
      velocity[0] * t - tx
    end
  y = (velocity[1] * t - tx)
  [x, y]
end

def in_range?(position, ranges)
  ranges[0].include?(position[0]) && ranges[1].include?(position[1])
end

def after_range?(position, ranges)
  position[0] > ranges[0].last || position[1] < ranges[1].first
end

def before_range?(position, ranges)
  position[0] < ranges[0].first
end

def valid_positions(velocity, ranges)
  t = 1
  positions = []
  while true
    position = pos(t, velocity)
    if positions.any? && position[0] == positions.last[0] &&
         before_range?(position, ranges)
      return []
    end
    return [] if after_range?(position, ranges)
    return positions if in_range?(position, ranges)
    positions << position
    t += 1
  end
end

def max_y(velocity, ranges)
  positions = valid_positions(velocity, ranges)
  positions.map { |p| p[1] }.max
end

x = 60
y = -267
ys = []

-267.upto(100_000) do |y|
  100.downto(0) do |x|
    my = max_y([x, y], target_ranges)
    ys << my if my
    puts "#{x},#{y}: #{my} :: #{ys.max}" if my
  end
end
