FROM flinkjob_hive:latest

ARG FLINK_VERSION=1.12.0
ARG SCALA_VERSION=2.11
ARG HIVE_VERSION=3.1.0
ARG KAFKA_VERSION=2.4.0

MAINTAINER caiwenhui <github.com/whiteCcinn>

COPY flink-${FLINK_VERSION}-bin-scala_${SCALA_VERSION}.tgz ./
#RUN wget https://archive.apache.org/dist/flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_${SCALA_VERSION}.tgz

# install flink ${FLINK_VERSION}
RUN mkdir -p /usr/local/flink && \
    tar -xzvf flink-${FLINK_VERSION}-bin-scala_${SCALA_VERSION}.tgz --strip-components 1 -C /usr/local/flink && \
    rm flink-${FLINK_VERSION}-bin-scala_${SCALA_VERSION}.tgz

# adjust configuration
RUN sed -i -e 's/parallelism.default: 1/parallelism.default: 2/g' \
    -e 's/taskmanager.numberOfTaskSlots: 1/taskmanager.numberOfTaskSlots: 4/g' /usr/local/flink/conf/flink-conf.yaml;

# download sql-client-hive depend on some jar
# client
COPY flink-connector-hive_${SCALA_VERSION}-${FLINK_VERSION}.jar /usr/local/flink/lib/
COPY hive-exec-${HIVE_VERSION}.jar /usr/local/flink/lib/
COPY libfb303-0.9.3.jar /usr/local/flink/lib/
# server
COPY flink-connector-kafka_${SCALA_VERSION}-${FLINK_VERSION}.jar /usr/local/flink/lib/
COPY kafka-clients-${KAFKA_VERSION}.jar /usr/local/flink/lib/
COPY flink-streaming-scala_${SCALA_VERSION}-${FLINK_VERSION}.jar /usr/local/flink/lib/
COPY flink-table-api-java-bridge_${SCALA_VERSION}-${FLINK_VERSION}.jar /usr/local/flink/lib/
COPY flink-table-common-${FLINK_VERSION}.jar /usr/local/flink/lib/
COPY flink-connector-jdbc_${SCALA_VERSION}-${FLINK_VERSION}.jar /usr/local/flink/lib/

# from hive images
RUN cp /usr/local/hive/lib/mysql-connector-java-8.0.26.jar /usr/local/flink/lib/

#RUN wget https://repo1.maven.org/maven2/org/apache/flink/flink-connector-hive_${SCALA_VERSION}/${FLINK_VERSION}/flink-connector-hive_${SCALA_VERSION}-${FLINK_VERSION}.jar -O /usr/local/flink/lib/flink-connector-hive_${SCALA_VERSION}-${FLINK_VERSION}.jar && \
#    wget https://repo1.maven.org/maven2/org/apache/hive/hive-exec/${HIVE_VERSION}/hive-exec-${HIVE_VERSION}.jar -O /usr/local/flink/lib/hive-exec-${HIVE_VERSION}.jar && \
#    wget https://repo1.maven.org/maven2/org/apache/thrift/libfb303/0.9.3/libfb303-0.9.3.jar  -O /usr/local/flink/lib/libfb303-0.9.3.jar && \
#    wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-kafka_${SCALA_VERSION}/${FLINK_VERSION}/flink-sql-connector-kafka_${SCALA_VERSION}-${FLINK_VERSION}.jar  -O /usr/local/flink/lib/flink-sql-connector-kafka_${SCALA_VERSION}-${FLINK_VERSION}.jar && \
#    wget https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/${KAFKA_VERSION}/kafka-clients-${KAFKA_VERSION}.jar  -O /usr/local/flink/lib/kafka-clients-${KAFKA_VERSION}.jar && \
#    wget https://repo1.maven.org/maven2/org/apache/flink/flink-streaming-scala_${SCALA_VERSION}/${FLINK_VERSION}/flink-streaming-scala_${SCALA_VERSION}-${FLINK_VERSION}.jar  -O /usr/local/flink/lib/flink-streaming-scala_${SCALA_VERSION}-${FLINK_VERSION}.jar && \
#    wget https://repo1.maven.org/maven2/org/apache/flink/flink-table-api-java-bridge_${SCALA_VERSION}/${FLINK_VERSION}/flink-table-api-java-bridge_${SCALA_VERSION}-${FLINK_VERSION}.jar  -O /usr/local/flink/lib/flink-table-api-java-bridge_${SCALA_VERSION}-${FLINK_VERSION}.jar && \
#    wget https://repo1.maven.org/maven2/org/apache/flink/flink-table-common/${FLINK_VERSION}/flink-table-common-${FLINK_VERSION}.jar  -O /usr/local/flink/lib/flink-table-common-${FLINK_VERSION}.jar
#    wget https://repo1.maven.org/maven2/org/apache/flink/flink-connector-jdbc_${SCALA_VERSION}/${FLINK_VERSION}/flink-connector-jdbc_${SCALA_VERSION}-${FLINK_VERSION}.jar  -O /usr/local/flink/lib/flink-connector-jdbc_${SCALA_VERSION}-${FLINK_VERSION}.jar


# set environment variable
ENV FLINK_HOME=/usr/local/flink
ENV PATH=$PATH:/usr/local/flink/bin:/usr/local/flink/sbin

RUN echo "export HADOOP_CLASSPATH=`hadoop classpath`" >> ~/.bashrc

EXPOSE 8081

WORKDIR /root

COPY wait-for-it.sh ~/wait-for-it.sh

CMD [ "sh", "-c", "service ssh start;bash"]
