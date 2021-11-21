with circuits as (
  select *
    from {{ ref('circuits') }}
),
races as (
  select *
    from {{ ref('races') }}
),
joined as (
  select r.race_date,
         r.race_year,
         c.circuit_name,
         c.country,
         c.latitude,
         c.longitude         
    from races as r
    join circuits as c
   using (circuit_id)
),
lagged as (
  select *,
         lag(latitude) over (order by race_date) as previous_race_latitude,
         lag(longitude) over (order by race_date) as previous_race_longitude
    from joined
    order by race_date
),
distance as (
  select *,
         {{
           dbt_utils.haversine_distance(
             lat1='latitude',
             lon1='longitude',
             lat2='previous_race_latitude',
             lon2='previous_race_longitude',
             unit='mi'
           )
         }} as distance_miles
    from lagged
),
seasons as (
  select race_date,
         race_year,
         circuit_name,
         country,
         case
           when race_year <> lag(race_year) over (order by race_date)
             then null
             else distance_miles
         end as distance_miles
    from distance
),
grouped as (
  select race_year,
         count(*) as races,
         sum(distance_miles) as total_distance_traveled
    from seasons
   group by 1
),
final as (
  select race_year,
         races,
         total_distance_traveled::int
    from grouped
   order by race_year
)

select *
  from final
