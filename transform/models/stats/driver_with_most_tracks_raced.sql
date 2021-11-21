with drivers as (
  select *
    from {{ ref('drivers') }}
),
races as (
  select *
    from {{ ref('races') }}
),
results as (
  select *
    from {{ ref('results') }}
),
circuits as (
  select *
    from {{ ref('circuits') }}
),
joined as (
  select d.driver_ref,
         d.driver_full_name,
         c.circuit_ref,
         c.circuit_name

    from drivers as d
    join results as res
   using (driver_id)
    join races as r
   using (race_id)
    join circuits c
   using (circuit_id)
),
final as (
  select driver_ref,
         circuit_ref,
         circuit_name,
         driver_full_name,
         count(*) as races
    from joined
   group by 1, 2, 3, 4
   order by races desc
   limit 20
)

select driver_full_name,
       circuit_name,
       races
  from final
