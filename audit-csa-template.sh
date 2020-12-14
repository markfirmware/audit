#!/bin/bash
set -e

templates=$(npm search --json --searchlimit 100 keywords:csa-template | jq '.[] | .name' | sort)
for template in $templates
do
    rm -rf app
    clear
    echo $template
    npx create-snowpack-app --template $template app
    pushd app
        npm run build
    popd
done
