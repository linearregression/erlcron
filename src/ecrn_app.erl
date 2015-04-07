%%% @copyright Erlware, LLC. All Rights Reserved.
%%%
%%% This file is provided to you under the BSD License; you may not use
%%% this file except in compliance with the License.
%%%----------------------------------------------------------------
%%% @doc
%%%  erlcron app system
-module(ecrn_app).

-behaviour(application).

%% Api
-export([start/0, stop/0]).

%% Application callbacks
-export([start/2, stop/1]).

%%%===================================================================
%%% API
%%%===================================================================

%%%===================================================================
%%% Application callbacks
%%%===================================================================

%% @private
start() -> start(normal, []).

start(_StartType, _StartArgs) ->
    {ok, Pid} = ecrn_sup:start_link(),
    ok = setup(),
    {ok, Pid}.

%% @private
stop() -> stop([]).

stop(_State) ->
    ok.

spawnJob([])-> ok;
spawnJob([Job|Rest]) ->
    erlcron:cron(Job),
    spawnJob(Rest).

setup() ->
    case application:get_env(erlcron, crontab) of 
        {ok, Crontab} -> spawnJob(Crontab);
        undefined ->
            ok
    end.
