sql_execute create table supplier (s_suppkey  fixed(10), s_name char(25), s_address varchar(40), s_nationkey fixed(10), s_phone char(15), s_acctbal fixed(12,2),s_comment varchar(101), primary key ( s_suppkey ) )

sql_execute create table part (p_partkey fixed(10), p_name varchar(55), p_mfgr char(25), p_brand char(10), p_type varchar(25), p_size fixed(10), p_container char(10), p_retailprice fixed(12,2), p_comment varchar(23), primary key (p_partkey))

sql_execute create table partsupp (ps_partkey fixed(10), ps_suppkey fixed(10), ps_availqty fixed(10), ps_supplycost fixed(12,2), ps_comment varchar(199), primary key ( ps_partkey, ps_suppkey ) )

sql_execute create table customer (c_custkey fixed(10), c_name varchar(25), c_address varchar(40), c_nationkey fixed(10), c_phone char(15), c_acctbal fixed(12, 2), c_mktsegment char(10), c_comment varchar(117), primary key ( c_custkey ) )

sql_execute create table orders (o_orderkey fixed(10), o_custkey fixed(10), o_orderstatus char(1), o_totalprice fixed(12,2), o_orderdate date, o_orderpriority char(15), o_clerk char(15), o_shippriority fixed(10), o_comment varchar(79), primary key ( o_orderkey ) )

sql_execute create table lineitem (l_orderkey fixed(10), l_partkey fixed(10), l_suppkey fixed(10), l_linenumber fixed(10), l_quantity fixed(12,2), l_extendedprice fixed(12,2), l_discount fixed(12,2), l_tax fixed(12,2), l_returnflag char(1), l_linestatus char(1), l_shipdate date, l_commitdate date, l_receiptdate date, l_shipinstruct char(25), l_shipmode char(10), l_comment varchar(44), primary key ( l_orderkey, l_linenumber ) )

sql_execute create table nation (n_nationkey fixed(10), n_name char(25), n_regionkey fixed(10), n_comment varchar(152), primary key ( n_nationkey ) )

sql_execute create table region (r_regionkey fixed(10), r_name char(25), r_comment varchar(152), primary key ( r_regionkey ) )

sql_execute create table time_statistics (task_name varchar(40), s_time timestamp, e_time timestamp, int_time fixed(32))
