#!/bin/sh

# throughput_test_stats.sh: run throuput test and collect database and system 
# statistics
#
# This file is released under the terms of the Artistic License.  Please see
# the file LICENSE, included in this package, for details.
#
# Copyright (C) 2003 Open Source Development Lab, Inc.
#
# 28 Jan 2003

if [ $# -lt 2 ]; then
        echo "usage: throughput_test_stats.sh <scale_factor> <num_stream> [-d duration -i interval]"
        exit
fi

scale_factor=$1
num_stream=$2
CPUS=`grep -c '^processor' /proc/cpuinfo`
echo $CPUS
exit

#estimated power test time
throughput_test_time=5379

duration=0
interval=0
shift 1
# process the command line parameters
while getopts ":d:i:" opt; do
	case $opt in
		d) duration=$OPTARG
				;;
		i) interval=$OPTARG
				;;
		?) echo "Usage: $0 <scale_factor> <num_stream> [-d duration -i interval]"
			exit ;;
		esac
done

#if not specified, then use default value
if [ $interval -eq 0 ] 
then 
	interval=60
fi

if [ $duration -eq 0 ] 
then 
	duration=$throughput_test_time
fi

#if interval is larger than duration, then reduce interval by half
while [ $interval -gt $duration ]
do
	let "interval = $interval/2"
done

_o=`cat <<EOF | dbmcli -d $SID -u dbm,dbm 2>&1
param_getvalue DATE_TIME_FORMAT
quit
EOF`
_test=`echo $_o | grep ISO`
#if DATE_TIME_FORMAT is not INTERANL
if [ "$_test" = "" ]; then
        echo "set date_time_format to ISO"
        _o=`cat <<EOF | dbmcli -d $SID -u dbm,dbm 2>&1
        param_startsession
        param_put DATE_TIME_FORMAT ISO
        param_checkall
        param_commitsession
        quit
        EOF`
        _test=`echo $_o | grep OK`
        if [ "$_test" = "" ]; then
                 echo "set parameters failed: $_o"
                exit 1
        fi
fi

sapdb_script_path=$DBT3_INSTALL_PATH/scripts/sapdb
dbdriver_path=$DBT3_INSTALL_PATH/dbdriver/scripts

#make output directory
output_dir=throughput
mkdir -p $output_dir

# restart the database
echo "stopping the database"
$sapdb_script_path/stop_db.sh
echo "starting the database"
$sapdb_script_path/start_db.sh

#get meminfo
cat /proc/meminfo > $output_dir/meminfo0.out
sleep 2

#start sys_stats.sh
./sys_stats.sh $interval $duration $CPUS $output_dir &

#execute the query
echo "run throughput test for scale factor $scale_factor perf_run_number 1"
$dbdriver_path/run_throughput_test.sh $scale_factor 1 $num_stream

#get meminfo
cat /proc/meminfo > $output_dir/meminfo1.out