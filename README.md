# bert

An updated Erlang BERT encode/decoder, based on Tom Preston-Werner's *bert.erl*. This library uses maps instead of dicts, so requires Erlang/OTP R17 and higher.

See [BERT RPC specification](https://web.archive.org/web/20200413110437/http://bert-rpc.org/) for the specs.

Thanks to [contributors](CONTRIBUTORS.txt).

### Requirements

- Erlang R17+
- rebar3


## Include in Your Project

Add `{deps, [bert]}.` to `rebar.config`


## Build

```
    $ rebar3 compile
```

## Test

### Run EUnit tests

```
    $ rebar3 eunit
```

### Run Property-based tests

```
    $ rebar3 as test proper
```

## Usage


Encode a term:

```
    Term = #{key => [{some, "tuple"}, {true, 42}]},
    bert:encode(Term).
    > <<131,104,3,100,0,4,98,101,114,116,100,0,4,100,105,99,116,
      108,0,0,0,1,104,2,100,0,3,107,101,...>>
```

Decode a binary:

```
    Bin = <<131,104,3,100,0,4,98,101,114,116,100,0,4,100,105,99,116,108,0,0,0,1,104,2,
            100,0,3,107,101,121,108,0,0,0,2,104,2,100,0,4,115,111,109,101,107,0,5,116,
            117,112,108,101,104,2,104,2,100,0,4,98,101,114,116,100,0,4,116,114,117,101,
            97,42,106,106>>,
    bert:decode(Bin).
    > #{key => [{some, "tuple"}, {true, 42}]}
```

## Documentation generation

### Edoc

#### Generate public API

```
    $ rebar3 edoc
```

#### Generate private API

```
    $ rebar3 as edoc_private edoc
```

### ExDoc

```
    $ rebar3 ex_doc --output edoc
```

## License

Copyright (c) 2016-2022, Yuce Tekol <yucetekol@gmail.com>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.

* The names of its contributors may not be used to endorse or promote
  products derived from this software without specific prior written
  permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
