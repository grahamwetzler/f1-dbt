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
  select *
    from races r
    join circuits c
   using (circuit_id)
)

select *
  from final
