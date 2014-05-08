
problem :stone_pile do

  on [6, '1 2 3 4 5 6'] do
    matches 1
  end

  on [5, '65 66 67 99 100'] do
    matches 1
  end

  on [1, '14'] do
    matches 14
  end

  on [2, '1 15'] do
    matches 14
  end

end

