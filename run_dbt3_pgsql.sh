#!/bin/bash

sudo apt update
sudo apt-get install -y  build-essential autoconf
./autogen.sh
./configure --with-postgresql
make && sudo make install
sudo apt install -y postgresql libpq-dev r-base bc sysstat
sudo cp -R ../dbt3/ /opt/
sudo chown -R postgres:postgres /opt/dbt3
sudo -u postgres /bin/bash -c "source /opt/dbt3/dbt3_pgsql_profile && rm -rf /tmp/results && dbt3-run-workload -a pgsql -f 1 -o /tmp/results"
