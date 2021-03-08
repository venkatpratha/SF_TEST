{{ config(materialized='view') }}

with stop as (

select
    id STOP_ID,
    routeid ROUTE_ID,
    tripid TRIP_ID,
    name STOP_NAME,
    type TYPE_CODE,
    stop_type.STOP_TYPE_DESC type_desc,
    status STATUS_CODE,
    cname CONTACT_NAME,
    pnum CONTACT_PHONE_NUM,
    address ADDRESS,
    city CITY,
    pcode POSTAL_CODE,
    state STATE,
    plandep PLANNED_DEPART_TS,
    planarr PLANNED_ARRIVAL_TS,
    planbegin PLANNED_BEGIN_TS,
    seq SEQUENCE_NUM,
    geostop GEOSTOP_SEQUENCE_NUM,
    latitude LATITUDE,
    longitude LONGITUDE
from 
{{ref('STD_STOP')}} stop left outer join {{ ref('stop_type') }} stop_type on stop.type = stop_type.stop_type_code
)

select *
from stop
