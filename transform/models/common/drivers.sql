with drivers as (
  select "driverId" as driver_id,
         "driverRef" as driver_ref,
         number as driver_number,
         code as driver_code,
         forename as driver_first_name,
         surname as driver_last_name,
         dob as driver_date_of_birth,
         nationality as driver_nationality,
         url as driver_url

    from {{ source('ergast', 'drivers') }}
)

select *,
       concat_ws(' ', driver_first_name, driver_last_name) as driver_full_name,
       extract(years from age(driver_date_of_birth)) as driver_current_age

  from drivers
