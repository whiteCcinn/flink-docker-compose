#!/bin/bash
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

export HDFS_DATANODE_USER=root
export HDFS_DATANODE_SECURE_USER=hdfs
export HDFS_NAMENODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root

echo -e "\n"

$HADOOP_HOME/sbin/start-dfs.sh

export YARN_RESOURCEMANAGER_USER=root
export HADOOP_SECURE_DN_USER=yarn
export YARN_NODEMANAGER_USER=root

echo -e "\n"

$HADOOP_HOME/sbin/start-yarn.sh

echo -e "\n"