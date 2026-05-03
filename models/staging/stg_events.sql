with source as (
    select * from {{ source('thelook_ecommerce', 'events') }}
),

renamed as (
    select
        id                as event_id,
        user_id,
        sequence_number,
        session_id,
        created_at        as event_at,
        ip_address,
        city,
        state,
        postal_code,
        browser,
        traffic_source,
        uri,
        event_type
    from source
    where user_id is not null
      and created_at is not null
)

select * from renamed
