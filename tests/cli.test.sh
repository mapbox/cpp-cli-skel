#!/usr/bin/env bash

set -e
set -o pipefail

# run cli command directly in bash, capture the result and test it
PWD=$(pwd)
RESULT=$($PWD/cli waka)
if [ $RESULT == "!waka!" ]
then
  echo "Success."
  exit 0
else
  echo "Test failed: cli output is not as expected."
  echo "EXPECTED: !waka! - ACTUAL: $RESULT"
  exit -1
fi