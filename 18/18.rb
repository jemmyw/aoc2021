require 'byebug'

def flatten(n, d = 1)
  n
    .each_slice(2)
    .reduce([]) do |acc, (a, b)|
      if a.is_a?(Array)
        acc = acc + flatten(a, d + 1)
      elsif a.is_a?(Numeric)
        acc << { v: a, d: d }
      end

      if b.is_a?(Array)
        acc = acc + flatten(b, d + 1)
      elsif b.is_a?(Numeric)
        acc << { v: b, d: d }
      end

      acc
    end
end

def explode(n)
  index =
    n.each_with_index.find_index do |v, i|
      v[:d] > 4 && n.dig(i + 1, :d) == v[:d]
    end

  if index && index > -1
    e = n.dup
    e[index - 1][:v] += e[index][:v] if index > 0
    e[index + 2][:v] += e[index + 1][:v] if e[index + 2]
    e.delete_at(index + 1)
    e[index] = { v: 0, d: e[index][:d] - 1 }
    return e
  end

  n
end

def split(n)
  index = n.find_index { |v| v[:v] > 9 }

  if index && index > -1
    e = n.dup
    e[index] = [
      { v: (n[index][:v].to_f / 2).floor.to_i, d: n[index][:d] + 1 },
      { v: (n[index][:v].to_f / 2).ceil.to_i, d: n[index][:d] + 1 },
    ]

    return e.flatten
  end

  n
end

def reduce(n)
  done = false
  while !done
    exploded = explode(n)
    if (exploded) == n
      splitted = split(exploded)
      if (splitted) == exploded
        done = true
        return splitted
      else
        # puts "after split #{splitted.inspect}"
        n = splitted
      end
    else
      n = exploded
      # puts "after explode #{n.inspect}"
    end
  end
  n
end

def add(a, b)
  a = flatten(a) if (!a[0].is_a?(Hash))
  b = flatten(b) if (!b[0].is_a?(Hash))

  a.each { |v| v[:d] += 1 }
  b.each { |v| v[:d] += 1 }

  added = a + b
  # puts "after addition #{added.inspect}"
  reduce(added)
end

def add_list(*n)
  n.reduce { |acc, v| add(acc, v) }
end

def magnitude(n)
  hd = n.map { |v| v[:d] }.max

  while hd > 0
    n =
      n
        .each_with_index
        .reduce([]) do |acc, (v, i)|
          if acc.empty?
            acc << v
            next acc
          end

          if v[:d] == hd && acc.last[:d] == hd
            acc[-1] = { v: acc.last[:v] * 3 + v[:v] * 2, d: v[:d] - 1 }
          else
            acc << v
          end

          acc
        end

    hd -= 1
  end

  n
end

def print(n)
  puts n.map { |v| v[:v] }.join(', ')
end

list = File.readlines('input.txt').map { |l| eval(l) }

puts magnitude(add_list(*list)).inspect
