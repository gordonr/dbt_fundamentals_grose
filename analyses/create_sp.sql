CREATE OR REPLACE PROCEDURE ANALYTICS.A_LBK_SPROCS_WEBINAR.TPCH_PARTS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
begin

create
or replace table fct_tpch_parts(
    supplier_id string,
    nation_id string,
    part_id string,
    part_supplier_sk string,
    supplier_nation string,
    part_supplier_available_qty integer,
    part_supplier_cost float,
    part_supplier_comment string,
    supplier_name string,
    supplier_address string,
    supplier_phone_number string,
    supplier_account_balance float,
    supplier_comment string,
    part_name string,
    part_manufacturer string,
    part_brand string,
    part_type string,
    part_container string,
    part_retail_price float,
    part_material string,
    part_comment string,
    lowest_part_cost_in_region float
);
insert into
    fct_tpch_parts (
        supplier_id,
        nation_id,
        part_id,
        part_supplier_sk,
        supplier_nation,
        part_supplier_available_qty,
        part_supplier_cost,
        part_supplier_comment,
        supplier_name,
        supplier_address,
        supplier_phone_number,
        supplier_account_balance,
        supplier_comment,
        part_name,
        part_manufacturer,
        part_brand,
        part_type,
        part_container,
        part_retail_price,
        part_material,
        part_comment
    )
select
    suppliers.s_suppkey as supplier_id,
    suppliers.s_nationkey as nation_id,
    parts.p_partkey as part_id,
    concat(s_suppkey, parts.p_partkey) as part_supplier_sk,
    suppliers.s_nationkey as supplier_nation,
    part_suppliers.ps_availqty as part_supplier_available_qty,
    part_suppliers.ps_supplycost as part_supplier_cost,
    part_suppliers.ps_comment as part_supplier_comment,
    suppliers.s_name as supplier_name,
    suppliers.s_address as supplier_address,
    suppliers.s_phone as supplier_phone_number,
    suppliers.s_acctbal as supplier_account_balance,
    suppliers.s_comment as supplier_comment,
    parts.p_name as part_name,
    parts.p_mfgr as part_manufacturer,
    parts.p_brand as part_brand,
    parts.p_type as part_type,
    parts.p_container as part_container,
    parts.p_retailprice as part_retail_price,
    case
        when parts.p_type like ''%BRASS'' then ''brass''
        else p_type
    end as part_material,
    parts.p_comment as part_comment
from
    RAW.TPCH_SF001.SUPPLIER suppliers
    left join RAW.TPCH_SF001.PARTSUPP part_suppliers on suppliers.s_suppkey = part_suppliers.ps_suppkey
    left join RAW.TPCH_SF001.PART parts on parts.p_partkey = part_suppliers.ps_partkey;


ALTER TABLE
    fct_tpch_parts
ADD
    region string;
ALTER TABLE
    fct_tpch_parts
ADD
    nation string;
UPDATE
    fct_tpch_parts
SET
    region = locations.region,
    nation = locations.nation
FROM
    (
        SELECT
            n_nationkey::string as nation_id,
            n_regionkey::string as region_id,
            n_name as nation,
            n_comment as nation_comment,
            r_name as region,
            r_comment as region_comment
        from
            RAW.TPCH_SF001.NATION nations
            left join RAW.TPCH_SF001.REGION regions on nations.n_regionkey = regions.r_regionkey
    ) locations
WHERE
    fct_tpch_parts.nation_id = locations.nation_id;

UPDATE
    fct_tpch_parts
SET
    lowest_part_cost_in_region = min_parts.lowest_part_cost_in_region
FROM
    (
        SELECT
            part_id,
            region,
            min(part_supplier_cost) as lowest_part_cost_in_region
        FROM
            fct_tpch_parts
        GROUP BY
            part_id, region
    ) min_parts
WHERE
    fct_tpch_parts.part_id = min_parts.part_id;

DELETE FROM
    fct_tpch_parts
WHERE
    part_material not ilike ''%brass%'';

create or replace table fct_tpch_parts_log(part_id string, supplier_is_null string);

insert into fct_tpch_parts_log (
    part_id, supplier_is_null)
select part_id,''YES'' as supplier_is_null from fct_tpch_parts where supplier_id is null 
union all 
select ''00000'' as part_id, ''YES'' as supplier_is_null;

DELETE FROM
    fct_tpch_parts
    
WHERE
    part_id in (
        select 
            fct_tpch_parts.part_id
        from fct_tpch_parts 
        inner join fct_tpch_parts_log
        on fct_tpch_parts.part_id = fct_tpch_parts_log.part_id);

end;
';