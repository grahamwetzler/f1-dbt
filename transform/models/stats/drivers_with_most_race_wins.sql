with results as (
  select *
    from {{ ref('results') }}
),
races as (
  select *
    from {{ ref('races') }}
),
drivers as (
  select *
    from {{ ref('drivers') }}
),
joined as (
  select *
    from results
    join races
   using (race_id)
    join drivers
   using (driver_id)
),
wins as (
  select driver_ref,
         driver_full_name,
         count(*) as wins
    from joined
   where position_order = 1
   group by 1, 2
   order by wins desc
),
final as (
  select rank() over (order by wins desc) as rank,
         driver_full_name,
         wins
    from wins
)

select *
  from final
 limit 20
