{{ config(materialized='view') }}

with package as (
select 
    lineid HANDLING_UNIT_NUM,
    stopid STOP_ID,
    salesorder SALES_ORDER_ID,
    id DELIVERY_ID,
    seq SEQUENCE_NUM,
    wt WEIGHT
 from {{ref('STD_STOP_ORDER_LINE')}}
)

select * from package