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
         r.position_order,
         r.position_desc
    from results as r
    join drivers as d
   using (driver_id)
),
grouped as (
  select driver_id,
         driver_full_name,
         count(*) filter (where position_order between 1 and 3) as podiums,
         {% for p in range(1, 21) %}
         sum(case
               when position_order = {{ p }}
                 then 1
                 else 0
             end) as p{{ p }},
         {% endfor %}
         sum(case
               when position_order > 20
                 then 1
                 else 0
             end) as "p21+",
         {{
           dbt_utils.pivot(
             'position_desc',
             dbt_utils.get_column_values(
               ref('position_descriptions'),
               'position_desc'
             )
           )
         }}
    from podiums
   group by 1, 2
),
final as (
  select *
    from grouped
)

select *
  from final
