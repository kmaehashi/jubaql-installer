#!/bin/bash -ue

# Start JubaQL Gateway in Production Mode

JUBAQL_ROOT="$(dirname ${0})"

. "${JUBAQL_ROOT}/config"

pushd "${JUBAQL_ROOT}/build/jubaql-server"
  java \
    -Drun.mode="production" \
    -Dspark.distribution="${SPARK_DIST}" \
    -Djubaql.processor.fatjar="processor/target/scala-${SCALA_VERSION}/jubaql-processor-assembly-${JUBAQL_PROCESSOR_VERSION}.jar" \
    -Djubaql.zookeeper="${JUBAQL_ZOOKEEPER}" \
    -jar "gateway/target/scala-${SCALA_VERSION}/jubaql-gateway-assembly-${JUBAQL_GATEWAY_VERSION}.jar" \
    -i "${JUBAQL_BIND_IP}" \
    "${@}"
popd
