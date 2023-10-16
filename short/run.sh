#!/bin/bash

unset CFLAGS
unset CXXFLAGS
unset FFLAGS

# make sure we don't re-use tests that were built with different flags
rm -rf $HOME/.phoronix-test-suite/installed-tests/

# get the download cache for the short test suite
if [ ! -f short-dl-cache.tar.xz ]; then
    wget https://people.canonical.com/~mckeesh/short-dl-cache.tar.xz
    tar xvf short-dl-cache.tar.xz
    mv download-cache $HOME/.phoronix-test-suite
fi

SCRIPT_DIR=$(dirname "$0")
source $SCRIPT_DIR/../set_test_env.sh
PTS_BIN=$SCRIPT_DIR/../pts-source/phoronix-test-suite

export TEST_RESULTS_IDENTIFIER=short-id 
export TEST_RESULTS_NAME=short-name 
export TEST_RESULTS_DESCRIPTION='A shorter version of a test suite which avoids\
       	Python wheels or prebuilt bins'

PTS_SILENT_MODE=1 $PTS_BIN batch-benchmark short

phoronix-test-suite result-file-raw-to-csv $TEST_RESULTS_NAME
