lines = File.readlines('input.txt')

op = ['(', '[', '{', '<']
cl = [')', ']', '}', '>']
points = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137 }

il = []

lines.each do |line|
  catch(:skip) do
    stack = []

    line.chars.each do |c|
      if op.include?(c)
        stack.push(c)
      elsif cl.include?(c)
        last = stack.pop
        expected = op[cl.index(c)]

        il.push(c) if last != expected
      end
    end
  end
end

puts il.map { |c| points[c] }.sum
