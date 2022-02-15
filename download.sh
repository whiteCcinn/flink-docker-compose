#!/usr/bin/env bash

if [[ -e .env ]];then
   source .env
fi

HADOOP_VERSION=${HADOOP_VERSION:-3.1.1}
HIVE_VERSION=${HIVE_VERSION:-3.1.0}
SCALA_VERSION=${SCALA_VERSION:-2.11}
FLINK_VERSION=${FLINK_VERSION:-1.12.0}
KAFKA_VERSION=${KAFKA_VERSION:-2.4.0}

BASE_DIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)

function download_hadoop() {
  local dir=${BASE_DIR}/hadoop
  curl -o ${dir}/hadoop-${HADOOP_VERSION}.tar.gz \
      http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
}

function download_hive() {
  local dir=${BASE_DIR}/hive
  curl -o ${dir}/apache-hive-${HIVE_VERSION}-bin.tar.gz \
      https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz

  curl -o ${dir}/mysql-connector-java-8.0.26.jar \
      https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.26/mysql-connector-java-8.0.26.jar
}

function download_kafka() {
  local dir=${BASE_DIR}/kafka
  curl -o ${dir}/kafka_${SCALA_VERSION}-${KAFKA_VERSION} \
      https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
}

function download_flink() {
  local dir=${BASE_DIR}/flink
  curl -o ${dir}/flink-${FLINK_VERSION}-bin-scala_${SCALA_VERSION}.tgz \
      https://archive.apache.org/dist/flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_${SCALA_VERSION}.tgz

  curl -o ${dir}/flink-connector-hive_${SCALA_VERSION}-${FLINK_VERSION}.jar \
      https://repo1.maven.org/maven2/org/apache/flink/flink-connector-hive_${SCALA_VERSION}/${FLINK_VERSION}/flink-connector-hive_${SCALA_VERSION}-${FLINK_VERSION}.jar
  curl -o ${dir}/hive-exec-${HIVE_VERSION}.jar \
      https://repo1.maven.org/maven2/org/apache/hive/hive-exec/${HIVE_VERSION}/hive-exec-${HIVE_VERSION}.jar
  curl -o ${dir}/libfb303-0.9.3.jar \
      https://repo1.maven.org/maven2/org/apache/thrift/libfb303/0.9.3/libfb303-0.9.3.jar
  curl -o ${dir}/flink-connector-kafka_${SCALA_VERSION}-${FLINK_VERSION}.jar \
      https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-kafka_${SCALA_VERSION}/${FLINK_VERSION}/flink-sql-connector-kafka_${SCALA_VERSION}-${FLINK_VERSION}.jar
  curl -o ${dir}/kafka-clients-${KAFKA_VERSION}.jar \
      https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/${KAFKA_VERSION}/kafka-clients-${KAFKA_VERSION}.jar
  curl -o ${dir}/flink-table-api-java-bridge_${SCALA_VERSION}-${FLINK_VERSION}.jar \
      https://repo1.maven.org/maven2/org/apache/flink/flink-streaming-scala_${SCALA_VERSION}/${FLINK_VERSION}/flink-streaming-scala_${SCALA_VERSION}-${FLINK_VERSION}.jar
  curl -o ${dir}/flink-table-common-${FLINK_VERSION}.jar \
      https://repo1.maven.org/maven2/org/apache/flink/flink-table-common/${FLINK_VERSION}/flink-table-common-${FLINK_VERSION}.jar
  curl -o ${dir}/flink-connector-jdbc_${SCALA_VERSION}-${FLINK_VERSION}.jar \
      https://repo1.maven.org/maven2/org/apache/flink/flink-connector-jdbc_${SCALA_VERSION}/${FLINK_VERSION}/flink-connector-jdbc_${SCALA_VERSION}-${FLINK_VERSION}.jar
}

function download_all() {
    download_hadoop
    download_hive
    download_kafka
    download_flink
}

cmdname=$(basename $0)

echoerr() { if [[ $QUIET -ne 1 ]]; then echo "$@" 1>&2; fi }

usage()
{
    cat << USAGE >&2
Usage:
    $cmdname [all |[--hadoop] |[--hive] |[--kafka] |[--flink]]
    all            下载全部
    --hadoop       下载hadoop相关
    --hive         下载hive相关
    --kafka        下载kafka相关
    --flink        下载flink相关
USAGE
    exit 1
}

if [[ $# -eq 0 ]];then
  echoerr "Unknown argument: $1"
  usage
fi

while [[ $# -gt 0 ]]
do
    case "$1" in
        all )
        download_all
        shift 1
        ;;
        --hadoop)
        download_hadoop
        shift 1
        ;;
        --hive)
        download_hive
        shift 1
        ;;
        --kafka)
        download_kafka
        shift 1
        ;;
        --flink)
        download_flink
        shift 1
        ;;
        --help)
        usage
        ;;
        *)
        echoerr "Unknown argument: $1"
        usage
        ;;
    esac
done