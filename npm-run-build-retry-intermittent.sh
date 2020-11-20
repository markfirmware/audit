#!/bin/bash

#   ok=1
#   while [[ $ok != 0 ]]
#   do
    npm run build >& npm.run.build.log
    ok=$?
    if [[ $ok != 0 ]]
    then
        echo npm.run.build.log ...........................................
        cat npm.run.build.log
        echo npm.run.build.log ...........................................
#       cat npm.run.build.log | sed 1,/npx:.installed/d | sed s/.*Z// | sed /added/d > error.log
        cat npm.run.build.log | sed 1,/TypeError/d | sed /npm.ERR!.code.ELIFECYCLE/,$d > error.log
        echo error.log ...................................................
        cat error.log
        echo error.log ...................................................
        exit 1
    fi
#   done
