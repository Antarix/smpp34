%%%-------------------------------------------------------------------
%%% @author antarix
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Nov 2017 7:12 PM
%%%-------------------------------------------------------------------
-module(smpp34module).
-include_lib("smpp34pdu/include/smpp34pdu.hrl").
-author("antarix").

%% API
-export([start/0]).

start() ->

% Then connect to an SMSC to obtain an ESME object
{ok, Esme} = smpp34_esme:connect("localhost", 13013),
  io:fwrite("Connected to ESME ~p ESME : ~p", [ok, Esme]),


 ReceiverPdu = #bind_receiver{system_id="simple",
    password="simple123", system_type="FAKE",
    interface_version=?VERSION, addr_ton=2,
    addr_npi=1,address_range=""},

% Bind as a transceiver
TrxPdu = #bind_transceiver{system_id="simple", password="simple123"},

  Payload = #submit_sm{service_type="FAKE",
    source_addr_ton=2,
    source_addr_npi=1,
    source_addr="666888",
    dest_addr_ton=2,
    dest_addr_npi=1,
    destination_addr="444555",
    esm_class=1,
    protocol_id=2,
    priority_flag=1,
    %schedule_delivery_time="100716133059001+",
    %validity_period="000014000000000R",
    schedule_delivery_time="",
    validity_period="",
    registered_delivery=1,
    replace_if_present_flag=1,
    data_coding=1,
    sm_default_msg_id=1,
    sm_length=11,
    short_message="hello erlang"},
 {ok,Resp} = smpp34_esme:send(Esme, Payload),
  %{ok, Resp} = smpp34_esme:send(Esme, TrxPdu),
%  {ok, Resp} = smpp34_esme:send(Esme, ReceiverPdu),
  io:fwrite("~n Sent ~p Resp : ~p",[ok, Resp]),

% Retrieve our response
{ok, #pdu{}} = smpp34_esme:recv(Esme),

  io:fwrite("~n Response ~p Result : ~p",[ok, #pdu{}]),

%close the connection
smpp34_esme:close(Esme),
  io:fwrite("Connection closed").

