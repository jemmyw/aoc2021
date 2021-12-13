x =
  IO
    .readlines('input.txt')
    .map { |line| line.chomp.split(/-/) }
    .reduce(Hash.new { |hash, key| hash[key] = [] }){|c, (a, b)|c[a]<<b;c[b]<<a;c}

p = []
t = [['start']]

while t.any?
  a = t.shift
  c = a.last
  p << a and next if c == 'end'

  n =
    x[c].reject{|c|
      next true if c == 'start'
      if c.downcase == c && a.include?(c)
        s = a.select { |c| c.downcase == c }
        s.uniq.size < s.size ? 1 : nil
      end
    }

  t.push(*n.map{|c|a+[c]})
end

p p.size