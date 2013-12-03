-module(bbserv_tictactoerl_controller, [Reqs, SessionID]).
-compile(export_all).



login('GET', []) -> ok;
login('POST', []) ->
  LoggedInAlready = boss_session:get_session_data(SessionID, login),
  case LoggedInAlready of
    {OldLogName} ->
      {ok, [{loggedinalready, true}]};
    {error, Reason} ->
      Logname = Reqs:post_param("login_name"),
      boss_session:set_session_data(SessionID, login, Logname),
      {redirect, [{action, "list"}]}
  end.

list('GET', []) ->
  Sessionvars = boss_session:get_session_data(SessionID),
  {ok, [{sessionvars, Sessionvars}]}.




