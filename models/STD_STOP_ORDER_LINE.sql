{{ config(materialized='view') }}

with stoporderline as (

    select * from edp_sbx.std_descartes.stoporderline
)

select * from stoporderline