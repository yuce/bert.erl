-module(bert).
-version('0.1.0').
-author("Yuce Tekol").

%% API exports
-export([encode/1,
         decode/1]).


%%====================================================================
%% API functions
%%====================================================================

%%@doc Encode Erlang term to a binary data.

-spec encode(Term) -> Result when
	Term :: term(),
	Result :: binary().
encode(Term) ->
    term_to_binary(encode_term(Term)).

%%@doc Decode a binary data to Erlang term.

-spec decode(Bin) -> Result when
	Bin :: binary(),
	Result :: term().
decode(Bin) ->
    decode_term(binary_to_term(Bin)).


%%====================================================================
%% Internal functions
%%====================================================================

-spec encode_term(term()) -> term().

encode_term([]) -> {bert, nil};
encode_term(true) -> {bert, true};
encode_term(false) -> {bert, false};

encode_term(Map) when is_map(Map) ->
    {bert, dict, encode_term(maps:to_list(Map))};

encode_term(List) when is_list(List) ->
    % TODO: Handle improper lists
    lists:map(fun encode_term/1, List);

encode_term(Tuple) when is_tuple(Tuple), Tuple =/={} ->
    list_to_tuple(encode_term(tuple_to_list(Tuple)));

encode_term(Term) -> Term.

-spec decode_term(term()) -> term().

decode_term({bert, nil}) -> [];
decode_term({bert, true}) -> true;
decode_term({bert, false}) -> false;

decode_term({bert, dict, {bert, nil}}) ->
    #{};

decode_term({bert, dict, KeysValues}) when is_list(KeysValues) ->
    maps:from_list(decode_term(KeysValues));

decode_term(List) when is_list(List) ->
    lists:map(fun decode_term/1, List);

decode_term(Tuple) when is_tuple(Tuple) ->
    list_to_tuple(decode_term(tuple_to_list(Tuple)));

decode_term(Term) -> Term.

%%====================================================================
%% Tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

encode_nil_test() ->
    ?assertEqual({bert, nil}, encode_term([])).

encode_bool_test() ->
    ?assertEqual({bert, true}, encode_term(true)),
    ?assertEqual({bert, false}, encode_term(false)).

encode_tuple_test() ->
    Tuple = {"a", true},
    Expected = {"a", {bert, true}},
    ?assertEqual(Expected, encode_term(Tuple)).
	
encode_empty_tuple_test() ->
    Tuple = {},
    Expected = {},
    ?assertEqual(Expected, encode_term(Tuple)).	

encode_list_test() ->
    List = [{"a", true}, {<<"bbb">>, 42}],
    Expected = [{"a", {bert, true}}, {<<"bbb">>, 42}],
    ?assertEqual(Expected, encode_term(List)).

encode_dict_test() ->
    Dict = maps:from_list([{"a", true}, {<<"bbb">>, 42}]),
    {bert, dict, EncodeDict} = encode_term(Dict),
    ExpectedSortedKV = [{"a",{bert,true}}, {<<"bbb">>,42}],
    ?assertEqual(ExpectedSortedKV, lists:sort(EncodeDict)).


encode_number_test() ->
    ?assertEqual(42, encode_term(42)).

encode_binary_test() ->
    ?assertEqual(<<"bin">>, encode_term(<<"bin">>)).


decode_nil_test() ->
    ?assertEqual([], decode_term({bert, nil})).

decode_bool_test() ->
    ?assertEqual(true, decode_term({bert, true})).

decode_tuple_test() ->
    Tuple = {"a", {bert, true}},
    Expected = {"a", true},
    ?assertEqual(Expected, decode_term(Tuple)).

decode_list_test() ->
    List = [{"a", {bert, true}}, {<<"bbb">>, 42}],
    Expected = [{"a", true}, {<<"bbb">>, 42}],
    ?assertEqual(Expected, decode_term(List)).


decode_dict_test() ->
    Dict = {bert,dict,[{<<"bbb">>,42},{"a",{bert,true}}]},
    Expected = maps:from_list([{"a", true}, {<<"bbb">>, 42}]),
    ?assertEqual(Expected, decode_term(Dict)).

decode_empty_dict_test() ->
    ?assertEqual(#{}, decode_term(encode_term(#{}))).

decode_number_test() ->
    ?assertEqual(42, decode_term(42)).

decode_binary_test() ->
    ?assertEqual(<<"bin">>, decode_term(<<"bin">>)).


-endif.
