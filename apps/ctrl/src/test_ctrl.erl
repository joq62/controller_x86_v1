%%%-------------------------------------------------------------------
%%% @author c50 <joq62@c50>
%%% @copyright (C) 2024, c50
%%% @doc
%%%
%%% @end
%%% Created : 24 Sep 2024 by c50 <joq62@c50>
%%%-------------------------------------------------------------------
-module(test_ctrl).

%% API
-export([start/0]).

%%%

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include("log.api").

-define(NodeName,"ctrl").
%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% 
%% @end
%%--------------------------------------------------------------------
start()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    ok=test_1(),
    loop(),
    ok.
 


%%--------------------------------------------------------------------
%% @doc
%% 
%% @end
%%--------------------------------------------------------------------

loop()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    timer:sleep(10*1000),
    Vm=lib_vm:get_node(?NodeName),

    Nodes=rpc:call(Vm,erlang,nodes,[],5000),
    io:format("Nodes = ~p~n",[Nodes]),
    ResourceTypes=rpc:call(Vm,rd_store,get_resource_types,[],5000),
    io:format("ResourceTypes = ~p~n",[ResourceTypes]),
    
    case rpc:call(Vm,rd,fetch_resources,[add_test],5000) of
	[]->
	    do_nothing;
	[{add_test,AddVm}|_]->
	    io:format("add_test:add(20,22)= ~p~n",[rpc:call(AddVm,add_test,add,[20,22],5000)]),
	     io:format("rd:call(add_test,add,[20,22],5000)= ~p~n",[rd:call(add_test,add,[20,22],5000)])
    end,
    loop().

%%--------------------------------------------------------------------
%% @doc
%% 
%% @end
%%--------------------------------------------------------------------

test_1()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    
    Vm=lib_vm:get_node(?NodeName),
    io:format("Vm = ~p~n",[Vm]),
    LocalResources=rpc:call(Vm,rd_store, get_local_resource_tuples,[],5000),
    io:format("LocalResources = ~p~n",[LocalResources]),
    TargetResources=rpc:call(Vm,rd_store,get_target_resource_types,[],5000),
    io:format("TargetResources = ~p~n",[TargetResources]),

    ResourceTypes=rpc:call(Vm,rd_store,get_resource_types,[],5000),
    io:format("ResourceTypes = ~p~n",[ResourceTypes]),

    ok.


    

%%%===================================================================
%%% Internal functions
%%%===================================================================
