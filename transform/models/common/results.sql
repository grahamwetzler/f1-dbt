with results as (
  select "statusId" as status_id,
          "raceId" as race_id,
          "driverId" as driver_id,
          "constructorId" as constructor_id,
          "resultId" as result_id,
          grid,
          "positionOrder" as position_order,
          points,
          laps,
          "fastestLapTime" as fastest_lap_time,
          "fastestLapSpeed" as fastest_lap_speed,
          time as lap_time,
          milliseconds as lap_milliseconds,
          number as lap_number,
          "fastestLap" as fastest_lap,
          position,
          "positionText" as position_text,
          rank

    from {{ source('ergast', 'results') }}
),
position_descriptions as (
  select *
    from {{ ref('position_descriptions') }}
)

select *
  from results
  left join position_descriptions
 using (position_text)
