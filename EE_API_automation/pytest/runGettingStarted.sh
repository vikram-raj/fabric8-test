#!/bin/bash
set -e
# Do not reveal secrets
set +x

JENKINSLOG=$(pwd)/pytest_junit_logs.xml
CLILOG=$(pwd)/pytest_cli_logs.log
echo ""
echo Using logfile $JENKINSLOG and $CLILOG
echo ""
if test ! $(which pytest)
    then
        echo "==> Check pre-requisites: python and pytest should be installed"
else
    echo "==> Running GettingStarted API tests"
    if [ $# -lt 3 ]
    then
        echo "==> Insufficient arguments provided! Need minimum 3. Exiting."
        exit

    elif [ -z "$4" ] || [ "$4" = "False" ] || [ "$4" = "false" ]
    then
        echo "==> Launching the GettingStarted API tests to generate TestDB..."
        echo ""
        cd src/
        pytest test_getting_started.py -s -v --junitxml=$JENKINSLOG --sut=$1 --userid=$2 --offline_token=$3 2>&1 | tee $CLILOG
        echo ""

    elif [ "$4" = "True" ] || [ "$4" = "true" ]
    then
        echo "==> Launching the GettingStarted API tests to check GettingStarted sanity..."
        echo ""
        cd src/
        pytest test_getting_started.py -s -v --junitxml=$JENKINSLOG --sut=$1 --userid=$2 --offline_token=$3 --cleanup=$4 2>&1 | tee $CLILOG
        echo $?
    fi
fi
