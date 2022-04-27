-module(prop_bert).
-include_lib("proper/include/proper.hrl").

%%%%%%%%%%%%%%%%%%
%%% Properties %%%
%%%%%%%%%%%%%%%%%%
prop_term() ->
    ?FORALL(Term, bert_term(), 
				Term =:= bert:decode(bert:encode(Term))
			).

%%%%%%%%%%%%%%%%%%
%%% Generators %%%
%%%%%%%%%%%%%%%%%%
bert_term() ->
	?SUCHTHAT(Term, term(), Term =/= {}).
