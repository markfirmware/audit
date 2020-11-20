#!/bin/bash

#   ok=1
#   while [[ $ok != 0 ]]
#   do
    npm run build >& npm.run.build.log
    ok=$?
    if [[ $ok != 0 ]]
    then
        cat npm.run.build.log | sed 1,/index.html/d | sed /npm.ERR!.code.ELIFECYCLE/,\$d > error.log
        echo error.log ...................................................
        cat error.log
        echo error.log ...................................................
        exit 1
    fi
#   done
