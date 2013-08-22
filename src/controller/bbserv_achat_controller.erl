-module(bbserv_achat_controller, [Req]).
-compile(export_all).
-behaviour(gen_server).


login('GET', []) -> ok;

login('POST', []) ->
  LoginName = Req:post_param("login_name").

init(Args) -> ok.

start_link(bbserv_achat_controller, _Args, _Options) -> ok.

init(Args) ->
  ok.

handle_call(Request, From, State) ->
  case Request of
    {login, LoginName} ->
      [{{pid, From}, {login, LoginName}} | State];
    {send_msg, Msg} ->
      export_msg(Msg, State)
  end.
      

export_msg(Msg, []) -> ok.
export_msg(Msg, [User |State]) ->
  [{pid, UserPid}, {login, LoginName}] = User,
  UserPid ! [{login, LoginName}, {msg, Msg}].

