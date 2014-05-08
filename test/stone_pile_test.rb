
problem :stone_pile do |p|

  p.on [6, '1 2 3 4 5 6'] do |out|
    out.exactly 1
  end

  p.on [5, '65 66 67 99 100'] do |out|
    out.exactly 1
  end

  p.on [1, '14'] do |out|
    out.exactly 14
  end

  p.on [2, '1 15'] do |out|
    out.exactly 14
  end

end

