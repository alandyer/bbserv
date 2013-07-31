-module(changetest).
-compile(export_all).


get_change(RawChange) ->
  lists:reverse(get_change([200, 100, 25, 10, 5, 1], trunc(RawChange * 100), [])).

get_change([], _RawChange, Acc) ->
  Acc;
get_change([DIV|Tail], RawChange, Acc) ->
  ChangeCount = RawChange div DIV,
  get_change(Tail, RawChange rem DIV, [{DIV / 100, ChangeCount} | Acc]).

