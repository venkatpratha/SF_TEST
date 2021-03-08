{{ config(materialized='view') }}

with edw_driver_on_time as (

select 
    route_ts,
    driver_name,
    count(distinct handling_unit_num) total_packages,
    count(distinct case when stop_status = 'Complete' then handling_unit_num end) delivered_packages,
    count(distinct case when stop_status not in ('Complete','Missed') then handling_unit_num end) undelivered_packages,
    count(distinct case when stop_status = 'Missed' then handling_unit_num end) missed_packages,
    count(distinct case when stop_status = 'Missed' and exception_reason = 'Customer Refused' then handling_unit_num end) customer_refused
from
    {{ref('EDW_ROUTE_DETAIL')}}
)

select * from edw_driver_on_time
