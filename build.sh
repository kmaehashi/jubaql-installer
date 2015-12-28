#!/bin/bash -uex

JUBAQL_ROOT="$(dirname ${0})"

. "${JUBAQL_ROOT}/config"

####################################################
# Download source

if [ "${1:-}" != "--skip-download" ]; then
  rm -rf "${JUBAQL_ROOT}/build"
  mkdir -p "${JUBAQL_ROOT}/build"

  pushd "${JUBAQL_ROOT}/build"
    curl -L "https://github.com/jubatus/jubatus-on-yarn/archive/${JUBATUS_ON_YARN_GIT_BRANCH}.tar.gz" | tar xz
    curl -L "https://github.com/jubatus/jubaql-server/archive/${JUBAQL_SERVER_GIT_BRANCH}.tar.gz" | tar xz
    curl -L "https://github.com/jubatus/jubaql-client/archive/${JUBAQL_CLIENT_GIT_BRANCH}.tar.gz" | tar xz
    mv "jubatus-on-yarn-${JUBATUS_ON_YARN_GIT_BRANCH}" "jubatus-on-yarn"
    mv "jubaql-server-${JUBAQL_SERVER_GIT_BRANCH}" "jubaql-server"
    mv "jubaql-client-${JUBAQL_CLIENT_GIT_BRANCH}" "jubaql-client"
  popd
fi

####################################################
# Clean up

find "${JUBAQL_ROOT}/build" -path "${JUBAQL_ROOT}/build/*/target/*.jar" -delete

####################################################
# Build all modules

DISABLE_TESTS='set test in Test := {}'

pushd "${JUBAQL_ROOT}/build/jubatus-on-yarn/jubatusonyarn"
  for COMPONENT in common application-master client container; do
    ./sbt "project jubatus-on-yarn-${COMPONENT}" "${DISABLE_TESTS}" assembly
  done
  ./sbt publishLocal
popd

pushd "${JUBAQL_ROOT}/build/jubaql-server"
  for COMPONENT in gateway processor; do
    pushd "${COMPONENT}"
    sbt assembly
    popd
  done
popd

pushd "${JUBAQL_ROOT}/build/jubaql-client"
  sbt start-script
popd

echo "Done!"
