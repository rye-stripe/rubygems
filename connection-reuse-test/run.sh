#!/usr/bin/env bash

function run_test() {
  local -r REUSE="$1"
  local -r JOBS="$2"

  echo "Testing with REUSE=$REUSE and JOBS=$JOBS"
  rm -rf -- vendor .bundle
  export USE_FETCHER_CACHE="$REUSE"
  export BUNDLE_PATH=vendor/bundle
  /usr/bin/time ruby ../bundler/spec/support/bundle.rb install --redownload --jobs "$JOBS" > /dev/null
}

run_test false 1
run_test true 1

run_test false $(nproc)
run_test true $(nproc)
