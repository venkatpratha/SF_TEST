{{ config(materialized='view') }}

with route as (

    select * from edp_sbx.std_descartes.route
)

select * from route