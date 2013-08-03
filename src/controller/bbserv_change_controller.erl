-module(bbserv_change_controller, [Req]).
-compile(export_all).

change('GET', []) -> ok;
change('POST', []) ->
  ChangeRaw = Req:post_param("change_raw"),
  case io_lib:fread("~f", ChangeRaw) of
    {ok, [ChangeVal], _} ->
      erlang:display(ChangeVal),
      Change = get_change(ChangeVal),
      {ok, [{changes, Change}, {change_raw, ChangeRaw}]};
    {error, _} ->
      case io_lib:fread("~d", ChangeRaw) of
        {ok, [ChangeVal], _} ->
          Change = get_change(ChangeVal),
          {ok, [{changes, Change}, {change_raw, ChangeRaw}]};
        {error, _} ->
          {ok, [{badarg, ChangeRaw}]}
      end
  end.

get_change(RawChange) ->
  lists:reverse(get_change([200, 100, 25, 10, 5, 1], round(RawChange * 100), [])).

get_change([], _RawChange, Acc) ->
  Acc;
get_change([DIV|Tail], RawChange, Acc) ->
  ChangeCount = RawChange div DIV,
  %erlang:display(RawChange),
  get_change(Tail, RawChange rem DIV, [[{denomination, DIV}, {amount, ChangeCount}] | Acc]).

