
problem :inversions do

  on 1, 1 do
    matches 0
  end

  on 2, [1, 2] do
    matches 0
  end

  on 2, [2, 1] do
    matches 1
  end

  on 3, [1, 2, 3] do
    matches 0
  end

  on 3, [1, 3, 2] do
    matches 1
  end

  on 3, [2, 1, 3] do
    matches 1
  end

  on 3, [2, 3, 1] do
    matches 2
  end

  on 3, [3, 1, 2] do
    matches 2
  end

  on 3, [3, 2, 1] do
    matches 3
  end

  on 6, [1, 2, 3, 4, 5, 6] do
    matches 0
  end

  on 6, [1, 3, 5, 2, 4, 6] do
    matches 3
  end

  on 6, [6, 5, 4, 3, 2, 1] do
    matches 15
  end

  on 9, [1, 7, 8, 3, 2, 5, 4, 6, 9] do
    matches 12
  end

end
