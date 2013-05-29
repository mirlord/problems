%% ---------------------------------------------------------------------------
%% Copyright (c) 2013 Vladimir Chizhov <master@mirlord.com>
%% This work is licensed under WTFPL v.2 license.
%% See LICENSE and README for details.
%% ---------------------------------------------------------------------------

-module(discrete).
-export([main/1, start/0]).

-record(line, {x1, y1, x2, y2}).

%% ---------------------------------------------------------------------------
%% Solution

incl(L) ->
    (L#line.y2 - L#line.y1) / (L#line.x2 - L#line.x1).

solve2(Line, []) -> Line;
solve2(LineAB, [{Cx, Cy} | T]) ->
    LineBC = #line{ x1=LineAB#line.x2, y1=LineAB#line.y2, x2=Cx, y2=Cy },
    case (incl(LineAB) > incl(LineBC)) of
        true  -> solve2(LineAB, T);
        false ->
            LineAC = LineAB#line{ x2=Cx, y2=Cy },
            solve2(LineAC, T)
    end.

solve1([{X1, Y1}, {X2, Y2} | T]) ->
    L = #line{x1=X1, y1=Y1, x2=X2, y2=Y2},
    solve2(L, T).

%% ---------------------------------------------------------------------------
%% Lifecycle & I/O

read_num() ->
    {Int, _} = string:to_integer(io:get_line("")),
    Int.

read_nums(Q) ->
    lists:map(
        fun (Idx) ->
            {Int, _} = string:to_integer(io:get_line("")),
            {Idx, Int}
        end,
        lists:seq(1, Q)).

main(_) ->
    N = read_num(),
    Points = read_nums(N),
    L = solve1(Points),
    io:format("~w ~w~n", [L#line.x1, L#line.x2]).

start() ->
    main([]).

