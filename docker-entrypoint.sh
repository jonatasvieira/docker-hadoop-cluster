#!/bin/bash
set -e

export HDFS_NAMENODE_USER="root"
export HDFS_DATANODE_USER="root"
export HADOOP_USER_NAME="root"
export HDFS_SECONDARYNAMENODE_USER="root"
export YARN_RESOURCEMANAGER_USER="root"
export YARN_NODEMANAGER_USER="root"
export HADOOP_HOME="/opt/hadoop"
export HIVE_HOME="/opt/apache-hive"

if [ "$1" == 'hadoop' ]; then
    echo "Starting sshd service..."
    /etc/init.d/ssh start

    if [ "$(hostname)" == 'node-master' ]; then
        echo "Starting HDFS.."
        /bin/bash /opt/hadoop/sbin/start-dfs.sh
        
        # Create non-existing folders
        /bin/bash /opt/hadoop/bin/hadoop fs -mkdir -p /user/hive/warehouse

        /bin/bash  /opt/apache-hive/bin/init-hive-dfs.sh

        # tells hive to use derby database as its metastore database.
        $HIVE_HOME/bin/schematool -initSchema -dbType derby

        echo "Starting HIVESERVER.."
        $HIVE_HOME/bin/hive --service hiveserver2 &

        echo "Starting webhttp hadoop service..."
        /bin/bash /opt/hadoop/bin/hdfs httpfs &
    fi

fi
# To prevent containers exit
tail -F /opt/hadoop/logs/*.log