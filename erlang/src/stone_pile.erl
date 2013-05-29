%% ---------------------------------------------------------------------------
%% Copyright (c) 2013 Vladimir Chizhov <master@mirlord.com>
%% This work is licensed under WTFPL v.2 license.
%% See LICENSE and README for details.
%% ---------------------------------------------------------------------------

-module(stone_pile).
-export([main/1, start/0]).

combinations(1, L) -> [[E] || E <- L];
combinations(N, L) when N == length(L) -> [L];
combinations(N, [H | T]) ->
    combinations(N - 1, H, T) ++ combinations(N, T).

combinations(N, A, List) ->
    [[A | L] || L <- combinations(N, List) ].

nstones(N, Stones, TotalWeight) ->
    lists:min(
        lists:map(
            fun(LeftList) ->
                abs(TotalWeight - lists:sum(LeftList) * 2)
            end,
            combinations(N, Stones))).

solve(1, [Stone]) -> Stone;
solve(N, Stones) ->
    % use total weight instead of average to avoid division
    % and floating point values
    TotalWeight = lists:sum(Stones),
    lists:min(
        lists:map(
            fun(NLeft) -> nstones(NLeft, Stones, TotalWeight) end,
            lists:seq(1, N div 2))).

read_nums() ->
    lists:map(
        fun (I) ->
            element(1, string:to_integer(I))
        end,
        string:tokens(io:get_line(""), " \t\r\n")).

main(_) ->
    [N] = read_nums(),
    Stones = read_nums(),
    io:format("~w~n", [solve(N, Stones)]).

start() ->
    main([]).

