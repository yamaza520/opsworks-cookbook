#!/bin/sh
# http://qiita.com/n_slender/items/ca17a1389446b650b3d4
# chkconfig:345 99 1
# description: play-app
# processname: $APP

IP_ADDRESS=`ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1`

APP=api
APP_USER=root
APP_HOME=/var/play/${APP}

CONF="-Dconfig.file=conf/env/prd.conf"

MEM="-J-Xms1024M -J-Xmx1024M -XX:MaxPermSize=256m -XX:PermSize=256m"

GC="-J-Xloggc:/var/log/${APP}/gc_%p_%t.log
-J-XX:+UseGCLogFileRotation -J-XX:NumberOfGCLogFiles=10 -J-XX:GCLogFileSize=100k
-J-XX:+PrintGCDetails
-J-XX:+PrintGCTimeStamps"

HEAPDUMP="-J-XX:+HeapDumpOnOutOfMemoryError"

JMX="-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
-Dcom.sun.management.jmxremote.port=1111
-Djava.rmi.server.hostname=${IP_ADDRESS}"

HEAPSTATS="-J-agentlib:heapstats"


JAVA_OPTIONS="$CONF $MEM $GC $HEAPDUMP $JMX $HEAPSTATS"

# Source function library.
. /etc/rc.d/init.d/functions

prog=$(basename $APP)
lockfile=${LOCKFILE-/var/lock/subsys/${APP_NAME}}
pidfile=${APP_HOME}/RUNNING_PID
RETVAL=0

start(){
    echo  "starting ${prog}:"
    su - $APP_USER -c "cd ${APP_HOME}; ./bin/${APP} ${CONF} &"
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && touch ${lockfile}
    return $RETVAL
}

stop(){
    killproc -p ${pidfile} ${prog} -QUIT
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -f ${lockfile} ${pidfile}
}

status(){
    status -p ${pidfile} ${prog}
    RETVAL=$?
}

case "$1" in
  start)
    start
      ;;
  stop)
    stop
     ;;
  status)
     status
     ;;
  restart)
    stop
    start
     ;;
     *)
      echo $"Usage: $0 {start|stop|status|restart}"
      exit 2
esac
