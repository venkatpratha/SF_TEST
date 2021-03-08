{{ config(materialized='view') }}

with trip as (

    select 
    id TRIP_ID,
    name ROUTE_ID,
    seq SEQUENCE_NUM,
    pmiles PLANNED_MILES,
    deptime DEPART_TIME,
    arrtime ARRIVE_TIME,
    status STATUS_CODE,
    weight WEIGHT,
    height HEIGHT,
    width WIDTH,
    length LENGTH
 from {{ref('STD_TRIP')}}

)

select *
from trip

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
--limit 500
/* limit added automatically by dbt cloud */