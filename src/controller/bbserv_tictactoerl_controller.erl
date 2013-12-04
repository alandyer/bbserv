-module(bbserv_tictactoerl_controller, [Reqs, SessionID]).
-compile(export_all).



login('GET', []) -> ok;
login('POST', []) ->
  Logname = Reqs:post_param("login_name"),
  LoggedInAlready = boss_db:count(tictactoerl, [login = LogName]),
  if LoggedInAlready > 0 ->
      {ok, [{loggedinalready, true}]};
    true ->
      NewLogin = boss_db:new(id, Logname, SessionID),
      case NewLogin:save() of
        {ok, SavedLogin} ->
          {redirect, [{action, "list"}]};
        {error, ErrorList} ->
          {ok, [{errors, ErrorList}, {new_login, NewLogin}]}
  end.

list('GET', []) ->
  Sessionvars = boss_session:get_session_data(SessionID),
  {ok, [{sessionvars, Sessionvars}]}.




