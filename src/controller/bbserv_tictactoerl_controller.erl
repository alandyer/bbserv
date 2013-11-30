-module(bbserv_tictactoe_controller, [Reqs, SessionID]).
-compile(export_all).



login('GET', []) -> ok;
login('POST', []) ->
  Logname = Reqs:post_param("login_name"),
  boss_session:set_session_data(SessionID, Logname, self()),
  {redirect, [{action, "list"}]}.

list('GET', []) ->
  Sessions = boss_session:get_session_data(SessionID),
  {ok, [{sessions, Sessions}]}.


