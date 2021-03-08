{{ config(materialized='view') }}

with status as (
select Cmd	COMMAND_CODE,
command.COMMAND_NAME,
TStamp	STATUS_TS,
Id	DRIVER_ID,
RouteId	ROUTE_ID,
TruckId	TRUCK_ID,
StopId	STOP_ID,
CustomerSignatureFlag CUSTOMER_SIGNATURE_FLAG,
PrintedName	PRINTED_NAME,
ExceptionReason	EXCEPTION_REASON,
OrderlineID	HANDLING_UNIT_NUM
from {{ref('STD_STATUS_HIST')}} status left outer join {{ ref('commands') }} command on status.Cmd = command.command_code

)

select * from status