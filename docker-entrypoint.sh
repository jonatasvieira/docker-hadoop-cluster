#!/bin/bash
set -e

export HDFS_NAMENODE_USER="root"
export HDFS_DATANODE_USER="root"
export HDFS_SECONDARYNAMENODE_USER="root"
export YARN_RESOURCEMANAGER_USER="root"
export YARN_NODEMANAGER_USER="root"

if [ "$1" == 'hadoop' ]; then
    echo "Starting sshd service..."
    /etc/init.d/ssh start

    if [ "$(hostname)" == 'node-master' ]; then
        echo "Starting hdfs.."
        /bin/bash /opt/hadoop/sbin/start-dfs.sh
    fi

fi
# To prevent containers exit
tail -F ./opt/hadoop/logs/*.log