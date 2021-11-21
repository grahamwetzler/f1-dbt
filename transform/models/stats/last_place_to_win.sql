with lap_times as (
  select *
    from {{ ref('lap_times') }}
),
drivers as (
  select *
    from {{ ref('drivers') }}
),
results as (
  select *
    from {{ ref('results') }}
),
races as (
  select *
    from {{ ref('races') }}
),
constructors as (
  select *
    from {{ ref('constructors') }}
),
winners as (
  select *
    from results
   where position_order = 1
),
last_place as (
  select driver_id,
         race_id,
         lap,
         row_number() over (partition by race_id, lap
                                order by position desc) = 1 as is_last_place
    from lap_times l
),
joined as (
  select driver_ref,
         driver_full_name,
         race_id,
         race_name,
         race_date,
         constructor_name,
         array_agg(lap) over (partition by race_id, driver_id) as laps_in_last
    from winners
    join last_place
   using (race_id, driver_id)
    join drivers
   using (driver_id)
    join races
   using (race_id)
    join constructors
   using (constructor_id)
   where is_last_place
),
deduplicated as (
  select distinct on (driver_ref, race_id)
         driver_full_name,
         constructor_name,
         race_name,
         race_date,
         laps_in_last
    from joined
   order by driver_ref,
         race_id
),
final as (
  select *
    from deduplicated
   order by race_date
)

select *
  from final
