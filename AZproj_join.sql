--JOINING TABLES: JOINING CUST_INFO WITH LOCATION TABLE
--CREATING VIEW WITH JOINED TABLES
create view crm.joint_cust as 
select
	l.cus_key,
	c.cst_id,
	c.cst_firstname,
	c.cst_lastname,
	c.cst_gndr,
	c.cst_marital_status,
	c.cst_create_date,
	l.country
from crm.cust_clean c
left join crm.loc_clean l
on cast(c.cst_id as varchar)  = l.cst_id;

--JOINING PRODUCT AND PRODUCT CATEGORY TABLE
--CREATE VIEW WITH JOINED TABLE
create view crm.joint_prd as
select 
	p.prd_id,
	p.cat_id,
	p.prd_key,
	p.prd_nm,
	p.prd_cost,
	p.prd_line,
	p.prd_start_dt,
	p.prd_end_date,
	c.maintenance,
	c.prod_cat,
	c.prod_subcat
from crm.prd_clean p
left join crm.cat_clean c
on p.cat_id  = c.id;

create view crm.joint as
select
	jp.prd_start_dt,
	jp.prd_end_date,
	jp.maintenance,
	jp.prd_line,
	jp.prd_nm,
	jp.prod_cat,
	jp.prod_subcat,
	jc.cst_create_date,
	jc.cst_firstname,
	jc.cst_lastname,
	jc.cst_gndr,
	jc.cst_marital_status,
	jc.country,
	s.sls_order_dt,
	s.sls_due_dt,
	s.sls_ord_num,
	s.sls_quantity,
	jp.prd_cost,
	s.sls_price,
	s.sls_ship_dt
from crm.sales_clean s
left join crm.joint_cust jc
on s.sls_cust_id = jc.cst_id 
left join crm.joint_prd jp
on s.sls_prd_key = jp.prd_key;



alter table crm.joint
add column sales_price decimal;

alter table crm.joint 
add column cost_price decimal;

alter table crm.joint 
add column profit decimal;
