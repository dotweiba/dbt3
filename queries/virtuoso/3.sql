-- @(#)3.sql	2.1.8.1
-- TPC-H/TPC-R Pricing Summary Report Query (Q3)
-- Functional Query Definition
-- Approved February 1998
:b
:x
:o
select
    :n 10
	l_orderkey,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	o_orderdate,
	o_shippriority
from
	customer,
	orders,
	lineitem
where
	c_mktsegment = ':1'
	and c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and o_orderdate < cast (':2' as date)
	and l_shipdate > cast (':2' as date)
group by
	l_orderkey,
	o_orderdate,
	o_shippriority
order by
	revenue desc,
	o_orderdate;
:e
