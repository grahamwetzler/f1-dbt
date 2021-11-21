with races as (
  select date as race_date,
         round as round_number,
         "raceId" as race_id,
         "circuitId" as circuit_id,
         year as race_year,
         time as race_time,
         url as race_url,
         name as race_name

    from {{ source('ergast', 'races') }}
),
circuits as (
  select *
    from {{ ref('circuits') }}
),
final as (
  select *,
         race_date >= '1983-01-01' as is_modern_era
    from races r
    join circuits c
   using (circuit_id)
)

select *
  from final
