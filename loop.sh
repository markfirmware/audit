#!/bin/bash
set -e

for i in $(seq 1 20)
do
  echo $i
  rm -rf app.git
  npx create-snowpack-app --template @snowpack/app-template-blank app.git
  pushd app.git
      npm run build
  popd
done
