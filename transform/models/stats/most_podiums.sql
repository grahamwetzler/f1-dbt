with drivers as (
  select *
    from {{ ref('drivers') }}
),
results as (
  select *
    from {{ ref('results') }}
),
podiums as (
  select d.driver_id,
         d.driver_full_name,
         r.position_order
    from results as r
    join drivers as d
   using (driver_id)
   where r.position_order between 1 and 3
),
grouped as (
  select driver_id,
         driver_full_name,
         count(*) as podiums,
         {% for p in range(1, 4) %}
         sum(case
               when position_order = {{ p }}
                 then 1
                 else 0
             end) as p{{ p }}
         {% if not loop.last %},{% endif %}
         {% endfor %}
    from podiums
   group by 1, 2
),
final as (
  select rank() over (order by podiums desc) as rank,
         driver_full_name,
         podiums,
         p1,
         p2,
         p3
    from grouped
   order by podiums desc
   limit 20
)

select *
  from final
