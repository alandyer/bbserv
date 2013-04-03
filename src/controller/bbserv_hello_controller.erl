-module(bbserv_hello_controller, [Req]).
-compile(export_all).
world('GET', []) -> {output, "Hello, World!"}.

