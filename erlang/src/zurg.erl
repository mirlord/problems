%% ---------------------------------------------------------------------------
%% Copyright (c) 2013 Vladimir Chizhov <master@mirlord.com>
%% This work is licensed under WTFPL v.2 license.
%% See LICENSE and README for details.
%% ---------------------------------------------------------------------------

-module(zurg).
-export([main/1]).

-define (HEROES, [
        {buzz,  5},
        {woody, 10},
        {rex,   20},
        {hamm,  25}]).
-define (LIMIT, 60).

name_of(Idx) -> element(1, lists:nth(Idx, ?HEROES)).
time_of(Idx) -> element(2, lists:nth(Idx, ?HEROES)).

max_time(IdxA, IdxB) -> max(time_of(IdxA), time_of(IdxB)).

% shortcuts: forward/3 and backward/3

forward(Left, Right, Spent) ->
    forward(Left, Right, [], Spent).

backward(Left, Right, Spent) ->
    backward(Left, Right, [], Spent).

% */4

backward(_, [], _, _) -> not_ok;

backward(Left, [RightA | RightT], RightStay, Spent) ->
    ResultA = forward([RightA | Left],
                      lists:append(RightT, RightStay),
                      Spent + time_of(RightA)),
    case ResultA of
        not_ok ->
            backward(Left, RightT, [RightA | RightStay], Spent);
        _ -> [name_of(RightA) | ResultA]
    end.

forward([_], _, _, _) -> not_ok;

forward([LeftA, LeftB], _, [], Spent) ->
    FinalSpent = Spent + max_time(LeftA, LeftB),
    case FinalSpent of
        _ when FinalSpent > ?LIMIT -> not_ok;
        _                          -> [{name_of(LeftA), name_of(LeftB)}]
    end;

forward([LeftA, LeftB | LeftT], Right, LeftStay, Spent) ->
    ResultAB = backward(lists:append(LeftT, LeftStay),
                        [LeftA, LeftB | Right],
                        Spent + max_time(LeftA, LeftB)),
    case ResultAB of
        not_ok ->
            ResultAT = forward([LeftA | LeftT], Right, [LeftB | LeftStay], Spent),
            case ResultAT of
                not_ok ->
                    forward([LeftB | LeftT], Right, [LeftA | LeftStay], Spent);
                _ -> ResultAT
            end;
        _ -> [{name_of(LeftA), name_of(LeftB)} | ResultAB]
    end.

main(_) ->
    Left = lists:seq(1, length(?HEROES)),
    forward(Left, [], 0).

