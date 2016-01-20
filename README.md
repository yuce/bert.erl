bert
=====

An updated Erlang BERT encode/decoder, based on Tom Preston-Werner's *bert.erl*. This library uses maps instead of dicts, so requires Erlang/OTP R17 and higher.

See [BERT RPC specification](http://bert-rpc.org/) for the specs.

Requirements
------------

- Erlang R17+
- rebar3

Build
-----

    $ rebar3 compile


Test
----

    $ rebar3 eunit

Usage
-----

Encode a term:

    Term = #{key => [{some, "tuple"}, {true, 42}]},
    bert:encode(Term).
    > <<131,104,3,100,0,4,98,101,114,116,100,0,4,100,105,99,116,
      108,0,0,0,1,104,2,100,0,3,107,101,...>>

Decode a binary:

    Bin = <<131,104,3,100,0,4,98,101,114,116,100,0,4,100,105,99,116,108,0,0,0,1,104,2,
            100,0,3,107,101,121,108,0,0,0,2,104,2,100,0,4,115,111,109,101,107,0,5,116,
            117,112,108,101,104,2,104,2,100,0,4,98,101,114,116,100,0,4,116,114,117,101,
            97,42,106,106>>,
    bert:decode(Bin).
    > #{key => [{some, "tuple"}, {true, 42}]}
