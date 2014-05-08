
problem :staircases do |p|

  p.on 3, {} do |out|
    out.exactly '1'
  end

  p.on 6, {} do |out|
    out.exactly '3'
  end

  p.on 7, {} do |out|
    out.exactly '4'
  end

  p.on 20, {} do |out|
    out.exactly '63'
  end

  p.on 80, {} do |out|
    out.exactly '77311'
  end

end

