-module(bbserv_achat_controller, [Req]).
-compile(export_all).


pull('GET', [LastTimestamp]) ->
  {ok, Timestamp, Messages} = boss_mq:pull("achat-channel", list_to_integer(LastTimestamp)),
  {json, [{timestamp, Timestamp}, {messages, Messages}]}.

push('GET', [Message]) ->
  NewMessage = achatMessage:new(id, Message),
  case NewMessage:save() of
    {ok, SavedMessage} ->
      {json, [{message, Message}]};
    {error, ErrorList} ->
      {json, [{errors, ErrorList}, {message, NewMessage}]}
  end.
apush('GET', [Message]) ->
  NewMessage = achatMessage:new(id, Message),
  {json, [{message, Message}]}.

chatscreen('GET', []) ->
  Messages = boss_db:find(achatMessage, []),
  Timestamp = boss_mq:now("achat-channel"),
  {ok, [{messages, Messages}, {timestamp, Timestamp}]};

chatscreen('POST', []) ->
  MessageText = Req:post_param("message_text"),
  NewMessage = achatMessage:new(id, MessageText),
  case NewMessage:save() of
    {ok, SavedMessage} ->
      {redirect, [{action, "chatscreen"}]};
    {error, ErrorList} ->
      {ok, [{errors, ErrorList}, {new_msg, NewMessage}]}
  end.

