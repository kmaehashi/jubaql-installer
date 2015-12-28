#!/bin/bash -ue

# Start JubaQL Client

JUBAQL_ROOT="$(dirname ${0})"

. "${JUBAQL_ROOT}/config"

pushd "${JUBAQL_ROOT}/build/jubaql-client"
  target/start "$@"
popd
