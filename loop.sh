#!/bin/bash
set -e

N=$1
FRAMEWORK=$2

for i in $(seq 1 $N)
do
  echo $i
  rm -rf app.git
  npx create-snowpack-app --template @snowpack/app-template-$FRAMEWORK app.git
  pushd app.git
      npm run build
  popd
done
