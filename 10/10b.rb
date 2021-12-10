lines = File.readlines('input.txt')

op = ['(', '[', '{', '<']
cl = [')', ']', '}', '>']
points = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }

scores = lines.reduce([]) do |scores, line|
  stack = []

  catch(:skip) do
    score = 0

    line.chars.each do |c|
      if op.include?(c)
        stack.push(c)
      elsif cl.include?(c)
        last = stack.pop
        expected = op[cl.index(c)]
        throw(:skip) if last != expected
      end
    end

    stack.reverse.each do |c|
      closing = cl[op.index(c)]
      score = score * 5 + points[closing]
    end

    scores << score
  end

  scores
end.sort

puts scores[scores.length/2]