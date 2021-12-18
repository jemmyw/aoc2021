require 'byebug'

target_x = 14..50
target_y = -267..-225
target_ranges = [target_x, target_y]

def x_pos(t, vx)
  if t > vx
    tx = vx + 1
    vx * tx - (0.5 * (tx**2) - 0.5 * tx)
  else
    vx * t - (0.5 * (t**2) - 0.5 * t)
  end
end

def y_pos(t,vy)
  vy * t - (0.5 * (t**2) - 0.5 * t)
end

def pos(t, velocity)
  tx = x = x_pos(t, velocity[0])
  y = (velocity[1] * t - (0.5 * (t**2) - 0.5 * t))
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

def possible_positions(velocity, ranges)
  t = 1
  positions = []
  while true
    position = pos(t, velocity)
    if after_range?(position, ranges) || in_range?(position, ranges)
      return positions + [position]
    end
    positions << position
    t += 1
  end
end

def valid_positions(velocity, ranges)
  t = 1
  positions = []
  while true
    position = pos(t, velocity)
    positions << position
    return [] if after_range?(position, ranges)
    return positions if in_range?(position, ranges)
    t += 1
  end
end

def valid_velocity?(velocity, ranges)
  valid_positions(velocity, ranges).any?
end

def max_y(velocity, ranges)
  positions = valid_positions(velocity, ranges)
  positions.map { |p| p[1] }.max
end

x = 60
y = -267
count = 0

every_x = 0.upto(target_x.last+1).select do |x|
  (1..x*5).any? do |t|
    target_x.include?(x_pos(t,x))
  end
end

every_y = (target_y.first-1).upto(266).select do |y|
  (1..600).any? do |t|
    target_y.include?(y_pos(t,y))
  end
end

ps = []
every_x.each do |x|
  every_y.each do |y|
    ps << [x,y] if valid_velocity?([x,y], target_ranges)
  end
end
puts ps.length

# -268.upto(10_000) do |y|
#   51.downto(0) do |x|
#     if valid_velocity?([x, y], target_ranges)
#       count += 1
#       puts "#{x}, #{y} => #{count}"
#     end
#   end
# end
