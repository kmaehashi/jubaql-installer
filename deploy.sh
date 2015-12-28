#!/bin/bash -uex

JUBAQL_ROOT="$(dirname ${0})"

. "${JUBAQL_ROOT}/config"

####################################################
# Deploy onto HDFS (only for Production Mode)

pushd "${JUBAQL_ROOT}/jubatus-on-yarn/jubatusonyarn"
  hadoop fs -mkdir -p \
    "${JUBATUS_ON_YARN_HDFS_ROOT}/application-master" \
    "${JUBATUS_ON_YARN_HDFS_ROOT}/container"

  hadoop fs -copyFromLocal -f \
    "jubatus-on-yarn-application-master/target/scala-${SCALA_VERSION}/jubatus-on-yarn-application-master${JUBATUS_ON_YARN_VERSION}.jar" \
    "${JUBATUS_ON_YARN_HDFS_ROOT}/application-master/jubatus-on-yarn-application-master.jar"

  hadoop fs -copyFromLocal -f \
    "jubatus-on-yarn-client/src/test/resources/entrypoint.sh" \
    "${JUBATUS_ON_YARN_HDFS_ROOT}/application-master/entrypoint.sh"

  hadoop fs -copyFromLocal -f \
    "jubatus-on-yarn-container/target/scala-${SCALA_VERSION}/jubatus-on-yarn-container${JUBATUS_ON_YARN_VERSION}.jar" \
    "${JUBATUS_ON_YARN_HDFS_ROOT}/container/jubatus-on-yarn-container.jar"

  hadoop fs -copyFromLocal -f \
    "jubatus-on-yarn-application-master/src/test/resources/entrypoint.sh" \
    "${JUBATUS_ON_YARN_HDFS_ROOT}/container/entrypoint.sh"
popd

echo "Done!"
