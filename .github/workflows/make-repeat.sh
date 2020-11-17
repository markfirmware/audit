#!/bin/bash

N=$1
FRAMEWORK=$2
YML=repeat-$N-$FRAMEWORK.yml

cat << __EOF__ > $YML
name: $N times - test snowpack $FRAMEWORK template

on:
  push:
  schedule:
    - cron: '20 10 * * *'

jobs:

__EOF__

for i in $(seq 1 $N)
do
  JOB=${FRAMEWORK}_${i}
  cat << __EOF__ >> $YML

    ${JOB}:
      strategy:
        matrix:
          os: [ubuntu-latest, windows-2016]
      runs-on: \${{ matrix.os }}
      steps:
        - uses: actions/checkout@v1
        - name: create-snowpack-app
          run: |
            npx create-snowpack-app --template @snowpack/app-template-$FRAMEWORK app
        - name: npm run build
          run:  |
            cd app
            npm run build
__EOF__
done
