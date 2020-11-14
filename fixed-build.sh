#!/bin/bash
set -x

ok=1
while [[ $ok != 0 ]]
do
    npm run build
    ok=$?
done
