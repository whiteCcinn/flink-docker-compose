FROM anapsix/alpine-java

ARG kafka_version=0.9.0.1
ARG scala_version=2.11
ARG mirror=https://archive.apache.org

MAINTAINER wurstmeister

RUN apk add --update unzip wget curl docker jq coreutils

RUN echo "kafka-version: ${scala_version}-${kafka_version}"
ENV KAFKA_VERSION=$kafka_version SCALA_VERSION=$scala_version MIRROR=$mirror
COPY download-kafka.sh /tmp/download-kafka.sh
#RUN chmod a+x /tmp/download-kafka.sh && sync && /tmp/download-kafka.sh
# If you have the Kafka source code, you can comment line 14 and open line 16.
# 可以提前下载好：https://archive.apache.org/dist/kafka/2.4.0/kafka_2.11-2.4.0.tgz
COPY kafka_2.11-2.4.0.tgz /tmp/
RUN tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
RUN ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka
ENV PATH ${PATH}:${KAFKA_HOME}/bin
ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh
ADD create-topics.sh /usr/bin/create-topics.sh
# The scripts need to have executable permission
RUN chmod a+x /usr/bin/start-kafka.sh && \
    chmod a+x /usr/bin/broker-list.sh && \
    chmod a+x /usr/bin/create-topics.sh
# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]
