with source as (
    select * from {{ source('thelook_ecommerce', 'orders') }}
),

renamed as (
    select
        order_id,
        user_id,
        status,
        gender,
        created_at        as order_created_at,
        returned_at,
        shipped_at,
        delivered_at,
        num_of_item,
        case
            when status = 'Complete'   then true
            else false
        end               as is_complete,
        case
            when status = 'Returned'   then true
            else false
        end               as is_returned
    from source
    where order_id is not null
      and user_id is not null
)

select * from renamed
