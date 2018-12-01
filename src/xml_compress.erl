-module(xml_compress).
-export([encode/3, decode/3]).

% This file was generated by xml_compress_gen
%
% Rules used:
%
%  [{<<"eu.siacs.conversations.axolotl">>,<<"key">>,
%    [{<<"prekey">>,[<<"true">>]},{<<"rid">>,[]}],
%    []},
%   {<<"jabber:client">>,<<"message">>,
%    [{<<"from">>,[j2,{j1}]},
%     {<<"id">>,[]},
%     {<<"to">>,[j1,j2,{j1}]},
%     {<<"type">>,[<<"chat">>,<<"groupchat">>,<<"normal">>]},
%     {<<"xml:lang">>,[<<"en">>]}],
%    []},
%   {<<"urn:xmpp:hints">>,<<"store">>,[],[]},
%   {<<"jabber:client">>,<<"body">>,[],
%    [<<73,32,115,101,110,116,32,121,111,117,32,97,110,32,79,77,69,77,79,32,101,
%       110,99,114,121,112,116,101,100,32,109,101,115,115,97,103,101,32,98,117,
%       116,32,121,111,117,114,32,99,108,105,101,110,116,32,100,111,101,115,110,
%       226,128,153,116,32,115,101,101,109,32,116,111,32,115,117,112,112,111,
%       114,116,32,116,104,97,116,46,32,70,105,110,100,32,109,111,114,101,32,
%       105,110,102,111,114,109,97,116,105,111,110,32,111,110,32,104,116,116,
%       112,115,58,47,47,99,111,110,118,101,114,115,97,116,105,111,110,115,46,
%       105,109,47,111,109,101,109,111>>]},
%   {<<"urn:xmpp:sid:0">>,<<"origin-id">>,[{<<"id">>,[]}],[]},
%   {<<"urn:xmpp:chat-markers:0">>,<<"markable">>,[],[]},
%   {<<"eu.siacs.conversations.axolotl">>,<<"encrypted">>,[],[]},
%   {<<"eu.siacs.conversations.axolotl">>,<<"header">>,[{<<"sid">>,[]}],[]},
%   {<<"eu.siacs.conversations.axolotl">>,<<"iv">>,[],[]},
%   {<<"eu.siacs.conversations.axolotl">>,<<"payload">>,[],[]},
%   {<<"urn:xmpp:eme:0">>,<<"encryption">>,
%    [{<<"name">>,[<<"OMEMO">>]},
%     {<<"namespace">>,[<<"eu.siacs.conversations.axolotl">>]}],
%    []},
%   {<<"urn:xmpp:delay">>,<<"delay">>,[{<<"from">>,[j1]},{<<"stamp">>,[]}],[]},
%   {<<"http://jabber.org/protocol/address">>,<<"address">>,
%    [{<<"jid">>,[{j1}]},{<<"type">>,[<<"ofrom">>]}],
%    []},
%   {<<"http://jabber.org/protocol/address">>,<<"addresses">>,[],[]},
%   {<<"urn:xmpp:chat-markers:0">>,<<"displayed">>,
%    [{<<"id">>,[]},{<<"sender">>,[{j1},{j2}]}],
%    []},
%   {<<"urn:xmpp:mam:tmp">>,<<"archived">>,[{<<"by">>,[]},{<<"id">>,[]}],[]},
%   {<<"urn:xmpp:sid:0">>,<<"stanza-id">>,[{<<"by">>,[]},{<<"id">>,[]}],[]},
%   {<<"urn:xmpp:receipts">>,<<"request">>,[],[]},
%   {<<"urn:xmpp:chat-markers:0">>,<<"received">>,[{<<"id">>,[]}],[]},
%   {<<"urn:xmpp:receipts">>,<<"received">>,[{<<"id">>,[]}],[]},
%   {<<"http://jabber.org/protocol/chatstates">>,<<"active">>,[],[]},
%   {<<"http://jabber.org/protocol/muc#user">>,<<"invite">>,
%    [{<<"from">>,[{j1}]}],
%    []},
%   {<<"http://jabber.org/protocol/muc#user">>,<<"reason">>,[],[]},
%   {<<"http://jabber.org/protocol/muc#user">>,<<"x">>,[],[]},
%   {<<"jabber:x:conference">>,<<"x">>,[{<<"jid">>,[j2]}],[]},
%   {<<"jabber:client">>,<<"subject">>,[],[]},
%   {<<"jabber:client">>,<<"thread">>,[],[]},
%   {<<"http://jabber.org/protocol/pubsub#event">>,<<"event">>,[],[]},
%   {<<"http://jabber.org/protocol/pubsub#event">>,<<"item">>,[{<<"id">>,[]}],[]},
%   {<<"http://jabber.org/protocol/pubsub#event">>,<<"items">>,
%    [{<<"node">>,[<<"urn:xmpp:mucsub:nodes:messages">>]}],
%    []},
%   {<<"p1:push:custom">>,<<"x">>,[{<<"key">>,[]},{<<"value">>,[]}],[]},
%   {<<"p1:pushed">>,<<"x">>,[],[]},
%   {<<"urn:xmpp:message-correct:0">>,<<"replace">>,[{<<"id">>,[]}],[]},
%   {<<"http://jabber.org/protocol/chatstates">>,<<"composing">>,[],[]}]

encode(El, J1, J2) ->
  encode_child(El, <<"jabber:client">>,
    J1, J2, byte_size(J1), byte_size(J2), <<1:8>>).

encode_attr({<<"xmlns">>, _}, Acc) ->
  Acc;
encode_attr({N, V}, Acc) ->
  <<Acc/binary, 1:8, (encode_string(N))/binary,
    (encode_string(V))/binary>>.

encode_attrs(Attrs, Acc) ->
  lists:foldl(fun encode_attr/2, Acc, Attrs).

encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  E1 = if
    PNs == Ns -> encode_attrs(Attrs, <<Pfx/binary, 2:8, (encode_string(Name))/binary>>);
    true -> encode_attrs(Attrs, <<Pfx/binary, 3:8, (encode_string(Ns))/binary, (encode_string(Name))/binary>>)
  end,
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E1/binary, 2:8>>),
  <<E2/binary, 4:8>>.

encode_child({xmlel, Name, Attrs, Children}, PNs, J1, J2, J1L, J2L, Pfx) ->
  case lists:keyfind(<<"xmlns">>, 1, Attrs) of
    false ->
      encode(PNs, PNs, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx);
    {_, Ns} ->
      encode(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
  end;
encode_child({xmlcdata, Data}, _PNs, _J1, _J2, _J1L, _J2L, Pfx) ->
  <<Pfx/binary, 1:8, (encode_string(Data))/binary>>.

encode_children(Children, PNs, J1, J2, J1L, J2L, Pfx) ->
  lists:foldl(
    fun(Child, Acc) ->
      encode_child(Child, PNs, J1, J2, J1L, J2L, Acc)
    end, Pfx, Children).

encode_string(Data) ->
  <<V1:4, V2:6, V3:6>> = <<(byte_size(Data)):16/unsigned-big-integer>>,
  case {V1, V2, V3} of
    {0, 0, V3} ->
      <<V3:8, Data/binary>>;
    {0, V2, V3} ->
      <<(V3 bor 64):8, V2:8, Data/binary>>;
    _ ->
      <<(V3 bor 64):8, (V2 bor 64):8, V1:8, Data/binary>>
  end.

encode(PNs, <<"eu.siacs.conversations.axolotl">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"key">> ->
      E = lists:foldl(fun
        ({<<"prekey">>, AVal}, Acc) ->
          case AVal of
            <<"true">> -> <<Acc/binary, 3:8>>;
            _ -> <<Acc/binary, 4:8, (encode_string(AVal))/binary>>
          end;
        ({<<"rid">>, AVal}, Acc) ->
          <<Acc/binary, 5:8, (encode_string(AVal))/binary>>;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 5:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"encrypted">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 12:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"header">> ->
      E = lists:foldl(fun
        ({<<"sid">>, AVal}, Acc) ->
          <<Acc/binary, 3:8, (encode_string(AVal))/binary>>;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 13:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"iv">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 14:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"payload">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 15:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"jabber:client">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"message">> ->
      E = lists:foldl(fun
        ({<<"from">>, AVal}, Acc) ->
          case AVal of
            J2 -> <<Acc/binary, 3:8>>;
            <<J1:J1L/binary, Rest/binary>> -> <<Acc/binary, 4:8, (encode_string(Rest))/binary>>;
            _ -> <<Acc/binary, 5:8, (encode_string(AVal))/binary>>
          end;
        ({<<"id">>, AVal}, Acc) ->
          <<Acc/binary, 6:8, (encode_string(AVal))/binary>>;
        ({<<"to">>, AVal}, Acc) ->
          case AVal of
            J1 -> <<Acc/binary, 7:8>>;
            J2 -> <<Acc/binary, 8:8>>;
            <<J1:J1L/binary, Rest/binary>> -> <<Acc/binary, 9:8, (encode_string(Rest))/binary>>;
            _ -> <<Acc/binary, 10:8, (encode_string(AVal))/binary>>
          end;
        ({<<"type">>, AVal}, Acc) ->
          case AVal of
            <<"chat">> -> <<Acc/binary, 11:8>>;
            <<"groupchat">> -> <<Acc/binary, 12:8>>;
            <<"normal">> -> <<Acc/binary, 13:8>>;
            _ -> <<Acc/binary, 14:8, (encode_string(AVal))/binary>>
          end;
        ({<<"xml:lang">>, AVal}, Acc) ->
          case AVal of
            <<"en">> -> <<Acc/binary, 15:8>>;
            _ -> <<Acc/binary, 16:8, (encode_string(AVal))/binary>>
          end;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 6:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"body">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 8:8>>),
  E2 = lists:foldl(fun
    ({xmlcdata, <<73,32,115,101,110,116,32,121,111,117,32,97,110,32,79,77,69,
                  77,79,32,101,110,99,114,121,112,116,101,100,32,109,101,115,
                  115,97,103,101,32,98,117,116,32,121,111,117,114,32,99,108,
                  105,101,110,116,32,100,111,101,115,110,226,128,153,116,32,
                  115,101,101,109,32,116,111,32,115,117,112,112,111,114,116,32,
                  116,104,97,116,46,32,70,105,110,100,32,109,111,114,101,32,
                  105,110,102,111,114,109,97,116,105,111,110,32,111,110,32,104,
                  116,116,112,115,58,47,47,99,111,110,118,101,114,115,97,116,
                  105,111,110,115,46,105,109,47,111,109,101,109,111>>}, Acc) -> <<Acc/binary, 9:8>>;
    (El, Acc) -> encode_child(El, Ns, J1, J2, J1L, J2L, Acc)
  end, <<E/binary, 2:8>>, Children),
  <<E2/binary, 4:8>>;
    <<"subject">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 31:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"thread">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 32:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"urn:xmpp:hints">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"store">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 7:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"urn:xmpp:sid:0">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"origin-id">> ->
      E = lists:foldl(fun
        ({<<"id">>, AVal}, Acc) ->
          <<Acc/binary, 3:8, (encode_string(AVal))/binary>>;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 10:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"stanza-id">> ->
      E = lists:foldl(fun
        ({<<"by">>, AVal}, Acc) ->
          <<Acc/binary, 3:8, (encode_string(AVal))/binary>>;
        ({<<"id">>, AVal}, Acc) ->
          <<Acc/binary, 4:8, (encode_string(AVal))/binary>>;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 22:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"urn:xmpp:chat-markers:0">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"markable">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 11:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"displayed">> ->
      E = lists:foldl(fun
        ({<<"id">>, AVal}, Acc) ->
          <<Acc/binary, 3:8, (encode_string(AVal))/binary>>;
        ({<<"sender">>, AVal}, Acc) ->
          case AVal of
            <<J1:J1L/binary, Rest/binary>> -> <<Acc/binary, 4:8, (encode_string(Rest))/binary>>;
            <<J2:J2L/binary, Rest/binary>> -> <<Acc/binary, 5:8, (encode_string(Rest))/binary>>;
            _ -> <<Acc/binary, 6:8, (encode_string(AVal))/binary>>
          end;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 20:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"received">> ->
      E = lists:foldl(fun
        ({<<"id">>, AVal}, Acc) ->
          <<Acc/binary, 3:8, (encode_string(AVal))/binary>>;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 24:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"urn:xmpp:eme:0">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"encryption">> ->
      E = lists:foldl(fun
        ({<<"name">>, AVal}, Acc) ->
          case AVal of
            <<"OMEMO">> -> <<Acc/binary, 3:8>>;
            _ -> <<Acc/binary, 4:8, (encode_string(AVal))/binary>>
          end;
        ({<<"namespace">>, AVal}, Acc) ->
          case AVal of
            <<"eu.siacs.conversations.axolotl">> -> <<Acc/binary, 5:8>>;
            _ -> <<Acc/binary, 6:8, (encode_string(AVal))/binary>>
          end;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 16:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"urn:xmpp:delay">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"delay">> ->
      E = lists:foldl(fun
        ({<<"from">>, AVal}, Acc) ->
          case AVal of
            J1 -> <<Acc/binary, 3:8>>;
            _ -> <<Acc/binary, 4:8, (encode_string(AVal))/binary>>
          end;
        ({<<"stamp">>, AVal}, Acc) ->
          <<Acc/binary, 5:8, (encode_string(AVal))/binary>>;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 17:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"http://jabber.org/protocol/address">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"address">> ->
      E = lists:foldl(fun
        ({<<"jid">>, AVal}, Acc) ->
          case AVal of
            <<J1:J1L/binary, Rest/binary>> -> <<Acc/binary, 3:8, (encode_string(Rest))/binary>>;
            _ -> <<Acc/binary, 4:8, (encode_string(AVal))/binary>>
          end;
        ({<<"type">>, AVal}, Acc) ->
          case AVal of
            <<"ofrom">> -> <<Acc/binary, 5:8>>;
            _ -> <<Acc/binary, 6:8, (encode_string(AVal))/binary>>
          end;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 18:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"addresses">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 19:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"urn:xmpp:mam:tmp">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"archived">> ->
      E = lists:foldl(fun
        ({<<"by">>, AVal}, Acc) ->
          <<Acc/binary, 3:8, (encode_string(AVal))/binary>>;
        ({<<"id">>, AVal}, Acc) ->
          <<Acc/binary, 4:8, (encode_string(AVal))/binary>>;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 21:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"urn:xmpp:receipts">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"request">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 23:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"received">> ->
      E = lists:foldl(fun
        ({<<"id">>, AVal}, Acc) ->
          <<Acc/binary, 3:8, (encode_string(AVal))/binary>>;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 25:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"http://jabber.org/protocol/chatstates">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"active">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 26:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"composing">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 39:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"http://jabber.org/protocol/muc#user">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"invite">> ->
      E = lists:foldl(fun
        ({<<"from">>, AVal}, Acc) ->
          case AVal of
            <<J1:J1L/binary, Rest/binary>> -> <<Acc/binary, 3:8, (encode_string(Rest))/binary>>;
            _ -> <<Acc/binary, 4:8, (encode_string(AVal))/binary>>
          end;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 27:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"reason">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 28:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"x">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 29:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"jabber:x:conference">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"x">> ->
      E = lists:foldl(fun
        ({<<"jid">>, AVal}, Acc) ->
          case AVal of
            J2 -> <<Acc/binary, 3:8>>;
            _ -> <<Acc/binary, 4:8, (encode_string(AVal))/binary>>
          end;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 30:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"http://jabber.org/protocol/pubsub#event">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"event">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 33:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"item">> ->
      E = lists:foldl(fun
        ({<<"id">>, AVal}, Acc) ->
          <<Acc/binary, 3:8, (encode_string(AVal))/binary>>;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 34:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
    <<"items">> ->
      E = lists:foldl(fun
        ({<<"node">>, AVal}, Acc) ->
          case AVal of
            <<"urn:xmpp:mucsub:nodes:messages">> -> <<Acc/binary, 3:8>>;
            _ -> <<Acc/binary, 4:8, (encode_string(AVal))/binary>>
          end;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 35:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"p1:push:custom">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"x">> ->
      E = lists:foldl(fun
        ({<<"key">>, AVal}, Acc) ->
          <<Acc/binary, 3:8, (encode_string(AVal))/binary>>;
        ({<<"value">>, AVal}, Acc) ->
          <<Acc/binary, 4:8, (encode_string(AVal))/binary>>;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 36:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"p1:pushed">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"x">> ->
      E = encode_attrs(Attrs, <<Pfx/binary, 37:8>>),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, <<"urn:xmpp:message-correct:0">> = Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  case Name of
    <<"replace">> ->
      E = lists:foldl(fun
        ({<<"id">>, AVal}, Acc) ->
          <<Acc/binary, 3:8, (encode_string(AVal))/binary>>;
    (Attr, Acc) -> encode_attr(Attr, Acc)
  end, <<Pfx/binary, 38:8>>, Attrs),
  E2 = encode_children(Children, Ns, J1, J2, J1L, J2L, <<E/binary, 2:8>>),
  <<E2/binary, 4:8>>;
  _ -> encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx)
end;
encode(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx) ->
  encode_el(PNs, Ns, Name, Attrs, Children, J1, J2, J1L, J2L, Pfx).

decode(<<$<, _/binary>> = Data, _J1, _J2) ->
  fxml_stream:parse_element(Data);
decode(<<1:8, Rest/binary>>, J1, J2) ->
  {El, _} = decode(Rest, <<"jabber:client">>, J1, J2),
  El.

decode_string(Data) ->
  case Data of
    <<0:2, L:6, Str:L/binary, Rest/binary>> ->
      {Str, Rest};
    <<1:2, L1:6, 0:2, L2:6, Rest/binary>> ->
      L = L2*64 + L1,
    <<Str:L/binary, Rest2/binary>> = Rest,
      {Str, Rest2};
    <<1:2, L1:6, 1:2, L2:6, L3:8, Rest/binary>> ->
      L = (L3*64 + L2)*64 + L1,
    <<Str:L/binary, Rest2/binary>> = Rest,
      {Str, Rest2}
  end.

decode_child(<<1:8, Rest/binary>>, _PNs, _J1, _J2) ->
  {Text, Rest2} = decode_string(Rest),
  {{xmlcdata, Text}, Rest2};
decode_child(<<2:8, Rest/binary>>, PNs, J1, J2) ->
  {Name, Rest2} = decode_string(Rest),
  {Attrs, Rest3} = decode_attrs(Rest2),
  {Children, Rest4} = decode_children(Rest3, PNs, J1, J2),
  {{xmlel, Name, Attrs, Children}, Rest4};
decode_child(<<3:8, Rest/binary>>, PNs, J1, J2) ->
  {Name, Rest2} = decode_string(Rest),
  {Ns, Rest3} = decode_string(Rest2),
  {Attrs, Rest4} = decode_attrs(Rest3),
  {Children, Rest5} = decode_children(Rest4, Ns, J1, J2),
  {{xmlel, Name, add_ns(PNs, Ns, Attrs), Children}, Rest5};
decode_child(<<4:8, Rest/binary>>, _PNs, _J1, _J2) ->
  {stop, Rest};
decode_child(Other, PNs, J1, J2) ->
  decode(Other, PNs, J1, J2).

decode_children(Data, PNs, J1, J2) ->
  prefix_map(fun(Data2) -> decode(Data2, PNs, J1, J2) end, Data).

decode_attr(<<1:8, Rest/binary>>) ->
  {Name, Rest2} = decode_string(Rest),
  {Val, Rest3} = decode_string(Rest2),
  {{Name, Val}, Rest3};
decode_attr(<<2:8, Rest/binary>>) ->
  {stop, Rest}.

decode_attrs(Data) ->
  prefix_map(fun decode_attr/1, Data).

prefix_map(F, Data) ->
  prefix_map(F, Data, []).

prefix_map(F, Data, Acc) ->
  case F(Data) of
    {stop, Rest} ->
      {lists:reverse(Acc), Rest};
    {Val, Rest} ->
      prefix_map(F, Rest, [Val | Acc])
  end.

add_ns(Ns, Ns, Attrs) ->
  Attrs;
add_ns(_, Ns, Attrs) ->
  [{<<"xmlns">>, Ns} | Attrs].

decode(<<5:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"eu.siacs.conversations.axolotl">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {{<<"prekey">>, <<"true">>}, Rest3};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"prekey">>, AVal}, Rest4};
    (<<5:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"rid">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"key">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<12:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"eu.siacs.conversations.axolotl">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"encrypted">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<13:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"eu.siacs.conversations.axolotl">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"sid">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"header">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<14:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"eu.siacs.conversations.axolotl">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"iv">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<15:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"eu.siacs.conversations.axolotl">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"payload">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<6:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"jabber:client">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {{<<"from">>, J2}, Rest3};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"from">>, <<J1/binary, AVal/binary>>}, Rest4};
    (<<5:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"from">>, AVal}, Rest4};
    (<<6:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"id">>, AVal}, Rest4};
    (<<7:8, Rest3/binary>>) ->
      {{<<"to">>, J1}, Rest3};
    (<<8:8, Rest3/binary>>) ->
      {{<<"to">>, J2}, Rest3};
    (<<9:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"to">>, <<J1/binary, AVal/binary>>}, Rest4};
    (<<10:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"to">>, AVal}, Rest4};
    (<<11:8, Rest3/binary>>) ->
      {{<<"type">>, <<"chat">>}, Rest3};
    (<<12:8, Rest3/binary>>) ->
      {{<<"type">>, <<"groupchat">>}, Rest3};
    (<<13:8, Rest3/binary>>) ->
      {{<<"type">>, <<"normal">>}, Rest3};
    (<<14:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"type">>, AVal}, Rest4};
    (<<15:8, Rest3/binary>>) ->
      {{<<"xml:lang">>, <<"en">>}, Rest3};
    (<<16:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"xml:lang">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"message">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<8:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"jabber:client">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = prefix_map(fun    (<<9:8, Rest5/binary>>) ->
      {{xmlcdata, <<73,32,115,101,110,116,32,121,111,117,32,97,110,32,79,77,69,
                    77,79,32,101,110,99,114,121,112,116,101,100,32,109,101,115,
                    115,97,103,101,32,98,117,116,32,121,111,117,114,32,99,108,
                    105,101,110,116,32,100,111,101,115,110,226,128,153,116,32,
                    115,101,101,109,32,116,111,32,115,117,112,112,111,114,116,
                    32,116,104,97,116,46,32,70,105,110,100,32,109,111,114,101,
                    32,105,110,102,111,114,109,97,116,105,111,110,32,111,110,
                    32,104,116,116,112,115,58,47,47,99,111,110,118,101,114,115,
                    97,116,105,111,110,115,46,105,109,47,111,109,101,109,111>>}, Rest5};
    (Other) ->
      decode_child(Other, Ns, J1, J2)
  end, Rest2),
  {{xmlel, <<"body">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<31:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"jabber:client">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"subject">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<32:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"jabber:client">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"thread">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<7:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:hints">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"store">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<10:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:sid:0">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"id">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"origin-id">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<22:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:sid:0">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"by">>, AVal}, Rest4};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"id">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"stanza-id">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<11:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:chat-markers:0">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"markable">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<20:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:chat-markers:0">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"id">>, AVal}, Rest4};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"sender">>, <<J1/binary, AVal/binary>>}, Rest4};
    (<<5:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"sender">>, <<J2/binary, AVal/binary>>}, Rest4};
    (<<6:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"sender">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"displayed">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<24:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:chat-markers:0">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"id">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"received">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<16:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:eme:0">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {{<<"name">>, <<"OMEMO">>}, Rest3};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"name">>, AVal}, Rest4};
    (<<5:8, Rest3/binary>>) ->
      {{<<"namespace">>, <<"eu.siacs.conversations.axolotl">>}, Rest3};
    (<<6:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"namespace">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"encryption">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<17:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:delay">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {{<<"from">>, J1}, Rest3};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"from">>, AVal}, Rest4};
    (<<5:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"stamp">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"delay">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<18:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"http://jabber.org/protocol/address">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"jid">>, <<J1/binary, AVal/binary>>}, Rest4};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"jid">>, AVal}, Rest4};
    (<<5:8, Rest3/binary>>) ->
      {{<<"type">>, <<"ofrom">>}, Rest3};
    (<<6:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"type">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"address">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<19:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"http://jabber.org/protocol/address">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"addresses">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<21:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:mam:tmp">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"by">>, AVal}, Rest4};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"id">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"archived">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<23:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:receipts">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"request">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<25:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:receipts">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"id">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"received">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<26:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"http://jabber.org/protocol/chatstates">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"active">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<39:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"http://jabber.org/protocol/chatstates">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"composing">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<27:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"http://jabber.org/protocol/muc#user">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"from">>, <<J1/binary, AVal/binary>>}, Rest4};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"from">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"invite">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<28:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"http://jabber.org/protocol/muc#user">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"reason">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<29:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"http://jabber.org/protocol/muc#user">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"x">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<30:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"jabber:x:conference">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {{<<"jid">>, J2}, Rest3};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"jid">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"x">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<33:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"http://jabber.org/protocol/pubsub#event">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"event">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<34:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"http://jabber.org/protocol/pubsub#event">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"id">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"item">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<35:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"http://jabber.org/protocol/pubsub#event">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {{<<"node">>, <<"urn:xmpp:mucsub:nodes:messages">>}, Rest3};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"node">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"items">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<36:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"p1:push:custom">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"key">>, AVal}, Rest4};
    (<<4:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"value">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"x">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<37:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"p1:pushed">>,
  {Attrs, Rest2} = decode_attrs(Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"x">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(<<38:8, Rest/binary>>, PNs, J1, J2) ->
  Ns = <<"urn:xmpp:message-correct:0">>,
  {Attrs, Rest2} = prefix_map(fun
    (<<3:8, Rest3/binary>>) ->
      {AVal, Rest4} = decode_string(Rest3),
      {{<<"id">>, AVal}, Rest4};
    (<<2:8, Rest3/binary>>) ->
      {stop, Rest3};
    (Data) ->
      decode_attr(Data)
  end, Rest),
  {Children, Rest6} = decode_children(Rest2, Ns, J1, J2),
  {{xmlel, <<"replace">>, add_ns(PNs, Ns, Attrs), Children}, Rest6};
decode(Other, PNs, J1, J2) ->
  decode_child(Other, PNs, J1, J2).

