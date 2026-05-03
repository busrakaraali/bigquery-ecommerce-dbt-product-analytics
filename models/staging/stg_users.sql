with source as (
    select * from {{ source('thelook_ecommerce', 'users') }}
),

renamed as (
    select
        id                as user_id,
        first_name,
        last_name,
        email,
        age,
        case
            when age < 25 then '18-24'
            when age < 35 then '25-34'
            when age < 45 then '35-44'
            when age < 55 then '45-54'
            else '55+'
        end               as age_group,
        gender,
        city,
        state,
        country,
        postal_code,
        latitude,
        longitude,
        traffic_source,
        created_at        as user_created_at
    from source
    where id is not null
)

select * from renamed
