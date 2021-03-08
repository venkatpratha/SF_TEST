{{ config(materialized='view') }}

with stop as (

    select * from edp_sbx.std_descartes.stop
)

select * from stop