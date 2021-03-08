{{ config(materialized='view') }}

with edw_route_detail as (

select distinct
    route.route_id,
    route.route_ts,
    route.route_name,
    route.truck_id,
    route.driver_id,
    route.driver_name,
    trip.trip_id,
    trip.planned_miles,
    trip.weight trip_weight,
    trip.height,
    trip.width,
    trip.length,
    case when status_eot.command_code is not null then 'Complete' else 'Pending' end route_status,
    stop.stop_id,
    to_number(stop.sequence_num) stop_seq_num,
    stop.type_code stop_type_code,
    stop.type_desc stop_type_desc,
    stop.contact_name,
    stop.contact_phone_num,
    case 
        when status_c.command_code is not null then 'Complete' 
        when status_m.command_code is not null then 'Missed' 
        when status_a.command_code is not null then 'Arrive'
        when status_e.command_code is not null then 'EnRoute'
        end stop_status,
    status_m.exception_reason,
    stop.planned_arrival_ts,
    status_a.status_ts actual_arrival_ts,
    package.sales_order_id,
    package.delivery_id,
    package.handling_unit_num,
    package.weight package_weight,
    to_number(package.sequence_num) package_seq_num
from
    {{ref('CUR_ROUTE')}} route
    left outer join {{ref('CUR_TRIP')}}  trip on route.route_id = trip.route_id
    left outer join {{ref('CUR_STOP')}}  stop on route.route_id = stop.route_id
    left outer join {{ref('CUR_STATUS_HIST')}}  status on stop.stop_id = status.stop_id 
    left outer join {{ref('CUR_PACKAGE')}} package on stop.stop_id = package.stop_id
    left outer join {{ref('CUR_STATUS_HIST')}} status_d on stop.stop_id = status_d.stop_id and status_d.command_code='5' -- depart    
    left outer join {{ref('CUR_STATUS_HIST')}} status_e on stop.stop_id = status_e.stop_id and status_e.command_code='6' -- enroute  
    left outer join {{ref('CUR_STATUS_HIST')}} status_a on stop.stop_id = status_a.stop_id and status_a.command_code='7' -- arrive  
    left outer join {{ref('CUR_STATUS_HIST')}} status_c on stop.stop_id = status_c.stop_id and status_c.command_code='8' -- complete
    left outer join {{ref('CUR_STATUS_HIST')}} status_m on stop.stop_id = status_m.stop_id and status_m.command_code='9' -- missed
    left outer join {{ref('CUR_STATUS_HIST')}} status_eot on route.route_id = status_eot.route_id and status_eot.command_code='19' -- endoftrip
  order by to_number(stop.sequence_num),to_number(package.sequence_num)

)

select * from edw_route_detail