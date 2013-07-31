-module(bbserv_change_controller, [Req]).
-compile(export_all).

change('GET', []) -> ok;
change('POST', []) -> 
  ChangeRaw = list_to_float(Req:post_param("change_raw")),
  %erlang:display(ChangeRaw),
  Change = get_change(ChangeRaw),
  {ok, [{changes, Change}]}.

get_change(RawChange) ->
  lists:reverse(get_change([200, 100, 25, 10, 5, 1], round(RawChange * 100), [])).

get_change([], _RawChange, Acc) ->
  Acc;
get_change([DIV|Tail], RawChange, Acc) ->
  ChangeCount = RawChange div DIV,
  erlang:display(RawChange),
  get_change(Tail, RawChange rem DIV, [[{denomination, DIV}, {amount, ChangeCount}] | Acc]).

