#!/bin/bash

git clone https://github.com/dotweiba/dbt3.git
sudo apt-get install build-essential
cd dbt3 && ./autogen.sh
./configure --with-postgresql
make && sudo make install
cd ..
sudo apt install postgresql libpq-dev r-base bc sysstat
sudo cp -R ./dbt3/ /opt/
sudo chown -R postgres:postgres /opt/dbt3
sudo -u postgres /bin/bash -c "source /opt/dbt3/dbt3_pgsql_profile && rm -rf /tmp/results && dbt3-run-workload -a pgsql -f 1 -o /tmp/results"
