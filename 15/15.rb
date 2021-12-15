require 'byebug'
map =
  File.readlines('input.txt').map(&:chomp).map { |l| l.split('').map(&:to_i) }

def neighbours(map, point)
  [
    point[1] > 0 && [point[0], point[1] - 1],
    [point[0], point[1] + 1],
    point[0] > 0 && [point[0] - 1, point[1]],
    [point[0] + 1, point[1]],
  ].select(&:itself)
end

def reconstruct_path(from, current)
  total_path = [current]
  while from.include?(current)
    current = from[current]
    total_path.unshift current
  end
  total_path
end

def d(map, current, neighbor)
  map.dig(*neighbor.reverse) || Float::INFINITY
end

def h(current, goal)
  (goal[0] - current[0]).abs + (goal[1] - current[1]).abs
end

# A* finds a path from start to goal.
# h is the heuristic function. h(n) estimates the cost to reach goal from node n.
def a_star(map, start, goal)
  # The set of discovered nodes that may need to be (re-)expanded.
  # Initially, only the start node is known.
  # This is usually implemented as a min-heap or priority queue rather than a hash-set.
  open_set = [start]

  # For node n, cameFrom[n] is the node immediately preceding it on the cheapest path from start
  # to n currently known.
  from = {}

  # For node n, gScore[n] is the cost of the cheapest path from start to n currently known.
  gScore = Hash.new { |h, k| h[k] = Float::INFINITY }
  gScore[start] = 0

  # For node n, fScore[n] := gScore[n] + h(n). fScore[n] represents our current best guess as to
  # how short a path from start to finish can be if it goes through n.
  fScore = Hash.new { |h, k| h[k] = Float::INFINITY }
  fScore[start] = h(start, goal)

  while open_set.any?
    # This operation can occur in O(1) time if openSet is a min-heap or a priority queue
    current = open_set.reduce { |min, n| fScore[n] < fScore[min] ? n : min }

    return reconstruct_path(from, current) if current == goal

    open_set.delete(current)

    neighbours(map, current).each do |neighbor|
      # d(current,neighbor) is the weight of the edge from current to neighbor
      # tentative_gScore is the distance from start to the neighbor through current
      tentative_gScore = gScore[current] + d(map, current, neighbor)
      if tentative_gScore < gScore[neighbor]
        # This path to neighbor is better than any previous one. Record it!
        from[neighbor] = current
        gScore[neighbor] = tentative_gScore
        fScore[neighbor] = tentative_gScore + h(neighbor, goal)
        open_set << neighbor unless open_set.include?(neighbor)
      end
    end
  end

  # Open set is empty but goal was never reached
  return failure
end

def risk(map, path)
  path.drop(1).map { |p| map.dig(*p.reverse) }.sum
end

start = [0, 0]
goal = [map.first.size - 1, map.size - 1]
path = a_star(map, start, goal)
puts path.inspect
puts risk(map, path)
