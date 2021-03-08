{{ config(materialized='view') }}

with std_route as (

    select * from edp_sbx.std_descartes.route

)

select *
from std_route

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
