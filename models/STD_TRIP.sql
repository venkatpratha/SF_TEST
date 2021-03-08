{{ config(materialized='view') }}

with trip as (

    select * from edp_sbx.std_descartes.trip
)

select * from trip