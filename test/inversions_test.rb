
problem :inversions do |p|

  p.on 1, 1 do |out|
    out.exactly 0
  end

  p.on 2, [1, 2] do |out|
    out.exactly 0
  end

  p.on 2, [2, 1] do |out|
    out.exactly 1
  end

  p.on 3, [1, 2, 3] do |out|
    out.exactly 0
  end

  p.on 3, [1, 3, 2] do |out|
    out.exactly 1
  end

  p.on 3, [2, 1, 3] do |out|
    out.exactly 1
  end

  p.on 3, [2, 3, 1] do |out|
    out.exactly 2
  end

  p.on 3, [3, 1, 2] do |out|
    out.exactly 2
  end

  p.on 3, [3, 2, 1] do |out|
    out.exactly 3
  end

  p.on 6, [1, 2, 3, 4, 5, 6] do |out|
    out.exactly 0
  end

  p.on 6, [1, 3, 5, 2, 4, 6] do |out|
    out.exactly 3
  end

  p.on 6, [6, 5, 4, 3, 2, 1] do |out|
    out.exactly 15
  end

  p.on 9, [1, 7, 8, 3, 2, 5, 4, 6, 9] do |out|
    out.exactly 12
  end

end
