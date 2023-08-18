with
source as (
    SELECT User_id, in_vehicle, on_bicycle, on_foot, running, still, tilting, walking, unknown,
    ROUND((CAST(SUBSTR(cast(time AS STRING), 6,2) AS FLOAT64)-50) / 0.83333, 2) AS hour_day

   FROM {{ source('Interview_data_analysis_MDF', 'MDF_activities') }}
)

SELECT *
FROM source