#! /bin/sh

# create_db.sh
#
# This file is released under the terms of the Artistic License.  Please see
# the file LICENSE, included in this package, for details.
#
# Copyright (C) 2002 Open Source Development Lab, Inc.
#
# History:
# June-4-2003: Jenny Zhang

./drop_db.sh
./set_db_env.sh

# create database
echo "create database $SID..."
_o=`createdb -U $USER $SID 2>&1`
_test=`echo $_o | grep CREATE`
if [ "$_test" = "" ]; then
	echo "create $SID failed: $_o $_test"
	exit 1
fi

# create database user 'dbt'
echo "create database user..."
_o=`psql -c "create user dbt" $SID 2>&1`
_test=`echo $_o | grep CREATE`
if [ "$_test" = "" ]; then
	echo "create db user failed: $_o"
	exit 1
fi

exit 0