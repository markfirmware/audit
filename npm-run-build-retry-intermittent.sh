#!/bin/bash
set -x

ok=1
while [[ $ok != 0 ]]
do
    npm run build >& npm.run.build.log
    ok=$?
    if [[ $ok != 0 ]]
        cat raw | sed 1,/npx:.installed/d | sed s/.*Z// | sed /added/d > error.log
        cat error.log
    then
    fi
done
