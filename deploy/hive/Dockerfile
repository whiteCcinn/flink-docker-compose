FROM flinkjob_hadoop-master:latest

ARG HIVE_VERSION=3.1.0

MAINTAINER caiwenhui <github.com/whiteCcinn>

COPY apache-hive-${HIVE_VERSION}-bin.tar.gz ./
#RUN wget https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz

# install hive ${HIVE_VERSION}
RUN mkdir -p /usr/local/hive && \
    tar -xzvf apache-hive-${HIVE_VERSION}-bin.tar.gz --strip-components 1 -C /usr/local/hive && \
    rm apache-hive-${HIVE_VERSION}-bin.tar.gz

COPY mysql-connector-java-8.0.26.jar /usr/local/hive/lib/
#RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.26/mysql-connector-java-8.0.26.jar -O /usr/local/hive/lib/mysql-connector-java-8.0.26.jar

# set environment variable
ENV HIVE_HOME=/usr/local/hive
ENV PATH=$PATH:/usr/local/hive/bin:/usr/local/hive/sbin

EXPOSE 9083 10000 10002 50111

COPY conf/* /tmp/

RUN mv /tmp/hive-env.sh /usr/local/hive/conf/hive-env.sh && \
    mv /tmp/hive-site.xml /usr/local/hive/conf/hive-site.xml && \
    mv /tmp/start-hive.sh ~/start-hive.sh && \
    mv /tmp/wait-for-it.sh ~/wait-for-it.sh

RUN chmod +x ~/start-hive.sh && chmod +x ~/wait-for-it.sh

WORKDIR /root

CMD [ "sh", "-c", "service ssh start; bash"]