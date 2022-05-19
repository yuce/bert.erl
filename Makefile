.PHONY: doc test test-property

test:
	rebar3 eunit
	
test-property:
	rebar3 as test proper
	
doc:
	rebar3 ex_doc --output edoc
