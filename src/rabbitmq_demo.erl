%%%-------------------------------------------------------------------
%%% @author antarix
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. Dec 2017 1:11 PM
%%%-------------------------------------------------------------------
-module(rabbitmq_demo).
-author("antarix").

%% API
-export([send/0]).


-include_lib("amqp_client/include/amqp_client.hrl").


send() ->
  {ok, Connection} =
    amqp_connection:start(#amqp_params_network{host = "localhost"}),
  {ok, Channel} = amqp_connection:open_channel(Connection),

  amqp_channel:call(Channel, #'queue.declare'{queue = <<"hello">>}),

  amqp_channel:cast(Channel,
    #'basic.publish'{
      exchange = <<"">>,
      routing_key = <<"hello">>},
    #amqp_msg{payload = <<"Hello World! new">>}),
  io:format(" [x] Sent 'Hello World!'~n"),
  ok = amqp_channel:close(Channel),
  ok = amqp_connection:close(Connection),
  ok.