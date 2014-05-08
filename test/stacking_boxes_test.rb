
problem :stacking_boxes do

  # Simple test
  on ['5 2', '3 7', '8 10', '5 2', '9 11', '21 18'] do
    matches [5, '3 1 2 4 5']
  end

  # Should support several input box sequences
  on ['2 2', '1 2', '3 4',
        '2 2', '5 6', '7 8'] do
    matches [2, '1 2', 2, '1 2']
  end

  # Should support more than one correct result
  on ['8 6', '5 2 20 1 30 10',
               '23 15 7 9 11 3',
               '40 50 34 24 14 4',
               '9 10 11 12 13 14',
               '31 4 18 8 27 17',
               '44 32 13 19 41 19',
               '1 2 3 4 5 6',
               '80 37 47 18 21 9'] do
    matches [4, any('7 2 5 6', '7 2 5 8')]
  end

end

