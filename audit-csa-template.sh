#!/bin/bash

ok="@hisystems/snowpack-app-template-11ty @hisystems/snowpack-app-template-blank @hisystems/snowpack-app-template-blank-typescript @idangazit/snowbank @joist/starter-snowpack @joshnuss/svelte-snowpack-template @martel/heat-template @martel/hyperapp-snowpack martel/tql-template @snowpack/app-template-11ty @snowpack/app-template-blank @snowpack/app-template-blank-typescript snowpack-app-template-crank-typescript snowpack-app-template-glimmer @snowpack/app-template-lit-element @snowpack/app-template-lit-element-typescript @snowpack/app-template-minimal @snowpack/app-template-preact @snowpack/app-template-preact-typescript @snowpack/app-template-react @snowpack/app-template-react-typescript @snowpack/app-template-vue @snowpack/app-template-vue-typescript @unlockdep/app-template-react-sass @unlockdep/app-template-react-typescript-sass"
templates=$(npm search --json --searchlimit 100 keywords:csa-template | jq '.[] | .name' | sort)
for template in $templates
do
    exclude=0
    for t in ok
    do
        if [[ "$template" == "$t" ]]
	then
            exclude=1
            break
	fi
    done
    if [[ "$exclude" == "1" ]]
    then
        break
    fi
    rm -rf app
    echo template $template
    npx create-snowpack-app --template $template app
    pushd app > /dev/null
        npm run build
    popd > /dev/null
done
