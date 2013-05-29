%% ---------------------------------------------------------------------------
%% Copyright (c) 2013 Vladimir Chizhov <master@mirlord.com>
%% This work is licensed under WTFPL v.2 license.
%% See LICENSE and README for details.
%% ---------------------------------------------------------------------------

-module(staircases).
-export([main/1, start/0]).

ncols(Bricks, _, Return) when Bricks =< 0 ->
    Return;

ncols(_, 1, Return) ->
    Return + 1;

ncols(Bricks, Columns, Return) ->
    ncols(Bricks - Columns, Columns,
        ncols(Bricks - Columns, Columns - 1, Return)).

max_cols(Bricks) ->
    round(math:sqrt(Bricks * 2)) + 1.

solve(Bricks) ->
    lists:sum(
        lists:map(
            fun(Columns) ->
                ncols(Bricks, Columns, 0)
            end,
            lists:seq(2, max_cols(Bricks)))).

% Lifecycle & I/O

main([]) ->
    main([io:get_line("")]);

main([Arg | _]) ->
    {Bricks, _} = string:to_integer(Arg),
    io:format("~w~n", [solve(Bricks)]).

start() ->
    main([]).

