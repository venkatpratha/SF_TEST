{{ config(materialized='view') }}

with route as (

    select 
        id ROUTE_ID,
        name ROUTE_NAME,
        truckid TRUCK_ID,
        did DRIVER_ID,
        crewname DRIVER_NAME,
        deptime DEPART_TS,
        arrtime ARRIVE_TS,
        tstamp ROUTE_TS
    from 
    {{ref('STD_ROUTE')}}
)

select *
from route

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
--limit 500
/* limit added automatically by dbt cloud */