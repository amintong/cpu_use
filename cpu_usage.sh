#!/bin/sh
# Power by amintong 2021-08-13 22:18:03

# Destription: test cpu usage
# Example    : sh cpu_usage.sh consume 8 | sh cpu_usage.sh release

FILE_NAME=`basename $0`
cpunum=$2

function usage()
{
echo "Usage:$FILE_NAME consume cpu_number|release -----the value of cpu_number is an integer,such as 1,2,3"
echo "Example: $FILE_NAME consume 12"
echo "         $FILE_NAME release"
}

function endless_loop()
{
/bin/sh endless_loop.sh &
}


function consume()
{
for i in `seq $1`
do
    endless_loop
done
}

function release()
{
for pid in $(ps -ef |grep 'endless_loop' |grep -v grep |awk '{print $1}' |sort |xargs)
do
    echo "kill "$pid"..."
    kill -9 $pid
done
}

case "$1" in
    consume) consume $cpunum;;
    release) release;;
    *) usage;;
esac
