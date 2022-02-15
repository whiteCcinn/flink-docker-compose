# flink-docker-compose
🚀Docker environment mainly used for Flink development, including Hadoop /hive/kafka/mysql

By default, Flink uses hive-Catalog, so hive is installed here.
Hive uses mysql as an external data store, so mysql is used here.

Where flink-job is the task where a sink is written to mysql.

## Download each version of the source package

```shell
./download.sh all
```

## ENV

You can modify some of the environment variable parameters by modifying the `.env` file, which will be recognized by `docker-compose`.

### kafka-network

Because the internal and external network is configured to the two networks.
So kafka's network can be directly linked to your local Flink for local development. (But you need to add hosts to your local)

```shell
echo "127.0.0.1 kafka1 kafka2 kafka3 kafka4" >> /etc/hosts
```

## Install

```go
docker-compose up
```

