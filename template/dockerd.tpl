#!/bin/bash

#
# ip       : 网桥地址
# mask     : 掩码数
#
# user     : 用户
# listen   : xx.xx.xx.xx:8080
#
. {{home}}/.dockerdata/etc/dockerd.conf


# 设置网桥
setup_bridge() {
    brctl addbr br-{{user}};
    ip address add $ip/$mask dev br-{{user}}
    ip link set dev br-{{user}} up
    su {{user}} -c "mkdir -p {{home}}/.dockerdata/{docker,run,log}"
}

# 清除网桥
teardown_bridge() {
    ip address del $ip/$mask dev br-{{user}};
    ip link set dev br-{{user}} down;
    brctl delbr br-{{user}};
}

# 运行服务
start_daemon() {
    /usr/bin/docker -d \
       -g {{home}}/.dockerdata/data \
       -b br-{{user}} \
       -p {{home}}/.dockerdata/run/docker.pid \
       -H tcp://$listen \
       -H unix://{{home}}/.dockerdata/run/docker.sock > {{home}}/.dockerdata/log/docker.log 2>&1 &
}

# 
stop_daemon() {
    kill `cat {{home}}/.dockerdata/run/docker.pid`;
}

case $1 in
    start) setup_bridge; start_daemon;
    ;;

    stop) stop_daemon; teardown_bridge;
    ;;
esac 

