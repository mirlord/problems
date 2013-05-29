// ---------------------------------------------------------------------------
// Copyright (c) 2013 Vladimir Chizhov <master@mirlord.com>
// This work is licensed under WTFPL v.2 license.
// See LICENSE and README for details.
// ---------------------------------------------------------------------------

package problems;

public class Staircases {

    private static long ncols(int bricks, int columns, long result) {
        if (bricks <= 0) return result;
        if (columns == 1) return result + 1;

        result = ncols(bricks - columns, columns - 1, result);
        return ncols(bricks - columns, columns, result);
    }

    private static long solve(int bricks) {
        long maxColumns = maxColumns(bricks);
        long result = 0;
        for (int i = 2; i <= maxColumns; i++) {
            result += ncols(bricks, i, 0);
        }
        return result;
    }

    private static long maxColumns(int bricks) {
        return Math.round(Math.sqrt(bricks * 2)) + 1;
    }

    public static void main(String[] args) throws Exception {
        System.out.println(solve(Integer.parseInt(args[0])));
    }
}

