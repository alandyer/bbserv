-module(bbserv_achat_controller, [Req]).
-compile(export_all).
%-behaviour(gen_server).



<<<<<<< HEAD
login('GET', []) -> ok;

login('POST', []) ->
  LoginName = Req:post_param("login_name").
  

start_link('bbserv_achat_controller', _Args, _Options) -> ok.

init(Args) -> ok.
  

=======
%login('GET', []) -> ok;

%login('POST', []) ->
%  LoginName = Req:post_param("login_name"),
%  cast(bbserv_achat_controller, login). 
  

start_link(bbserv_achat_controller, _Args, _Options) -> ok.

init(Args) ->
  ok.

%handle_call(Request, State) ->
%  case Request of
%    {login} ->
      
  
  


>>>>>>> achat_merge
