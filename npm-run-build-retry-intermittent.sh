#!/bin/bash
set -x

cat << __EOF__ > intermittent-error.log

TypeError: undefined is not a function
    at parseJsForInstallTargets (/home/runner/work/audit/audit/app/node_modules/snowpack/lib/scan-imports.js:114:19)
    at parseFileForInstallTargets (/home/runner/work/audit/audit/app/node_modules/snowpack/lib/scan-imports.js:150:24)
    at /home/runner/work/audit/audit/app/node_modules/snowpack/lib/scan-imports.js:237:30
    at Array.map (<anonymous>)
    at Object.scanImportsFromFiles (/home/runner/work/audit/audit/app/node_modules/snowpack/lib/scan-imports.js:237:10)
    at Object.getInstallTargets (/home/runner/work/audit/audit/app/node_modules/snowpack/lib/commands/install.js:47:57)
    at installOptimizedDependencies (/home/runner/work/audit/audit/app/node_modules/snowpack/lib/commands/build.js:69:44)
    at installDependencies (/home/runner/work/audit/audit/app/node_modules/snowpack/lib/commands/build.js:327:37)
    at Object.command (/home/runner/work/audit/audit/app/node_modules/snowpack/lib/commands/build.js:381:31)
    at async cli (/home/runner/work/audit/audit/app/node_modules/snowpack/lib/index.js:157:9)

__EOF__

ok=1
while [[ $ok != 0 ]]
do
    npm run build >& npm-run-build.log
    ok=$?
    if [[ $ok != 0 ]]
    then
        cat npm-run-build.log | sed 1,/index.html/d | sed /npm.ERR!.code.ELIFECYCLE/,\$d > error.log
        echo diff error.log intermittent-error.log
        diff error.log intermittent-error.log
        if [[ $? == 0 ]]
        then
            echo
	    echo retry intermittent error ...
        else
            cat npm-run-build.log
            exit 1
	fi
    fi
done
