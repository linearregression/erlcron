#!/bin/sh
# -*- tab-width:4;indent-tabs-mode:nil -*-
# ex: ts=4 sw=4 et

CALLER_DIR=$PWD

# Test if REMSH_NAME contains a @ and set REMSH_HOSTNAME_PART 
# and REMSH_NAME_PART according REMSH_TYPE
MAYBE_FQDN_HOSTNAME=`hostname`
HOSTNAME=`echo $MAYBE_FQDN_HOSTNAME | awk -F. '{print $1}'`

eval "erl \
    -name erlcron@${HOSTNAME} \
    -pa deps/*/ebin -pa ./ebin -pa lib/erlang/lib/*/ebin -pa lib/erlang/lib/*/include  \
    -eval \"application:start(sasl)\" \
    -eval \"application:start(os_mon)\" \
    -eval \"application:start(crypto)\" \
    -eval \"application:start(eunit)\" \
    -eval \"application:start(erlcron)\"\
    -config \"priv/erlcron.config\""
