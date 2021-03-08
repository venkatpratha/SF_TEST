{{ config(materialized='view') }}

with status as (

    select * from edp_sbx.std_descartes.status
    
    )

select * from status