#!/bin/bash

~/wait-for-it.sh mysql:3306 -t 30

if [[ ! -e initd ]];then
  schematool -dbType mysql -initSchema
  touch initd
fi

nohup hive --service metastore 2>&1 > /dev/null &

nohup hiveserver2  2>&1 > /dev/null &