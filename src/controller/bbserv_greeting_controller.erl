-module(bbserv_greeting_controller, [Req]).
-compile(export_all).

hello('GET', []) -> {ok, [{greeting, "Hello World!"}]}.


list('GET', []) -> Greetings = boss_db:find(greeting, []), {ok, [{greetings, Greetings}]}.

create('GET', []) -> ok;
create('POST', []) ->
  GreetingText = Req:post_param("greeting_text"),
  NewGreeting = greeting:new(id, GreetingText),
  case NewGreeting:save() of
    {ok, SavedGreeting} ->
      {redirect, [{action, "list"}]};
    {error, ErrorList} ->
      {ok, [{errors, ErrorList}, {new_msg, NewGreeting}]}
  end.

goodbye('POST', []) ->
  boss_db:delete(Req:post_param("greeting_id")),
  {redirect, [{action, "list"}]}.

send_test_message('GET', []) ->
  TestMessage = "Free at last!",
  boss_mq:push("testchan", TestMessage),
  {output, TestMessage}.

pull('GET', [LastTimestamp]) ->
  {ok, Timestamp, Greetings} = boss_mq:pull("new-greetings", list_to_integer(LastTimestamp)),
  {json, [{timestamp, Timestamp}, {greetings, Greetings}]}.

live('GET', []) ->
  Greetings = boss_db:find(greeting, []),
  Timestamp = boss_mq:now("new-greetings"),
  {ok, [{greetings, Greetings}, {timestamp, Timestamp}]}.

