-module(smpp34).
-export([start/0, stop/0, hello/0]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start() ->
	application:start(smpp34).

stop() ->
	application:stop(smpp34).

hello() ->
	io:fwrite("Hello Working").