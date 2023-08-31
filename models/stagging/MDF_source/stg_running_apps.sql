with
source as (
    SELECT * EXCEPT (time, category, app),
    --    SELECT TIMESTAMP_MILLIS(time) as hrs, 
    EXTRACT(HOUR FROM TIMESTAMP_MILLIS(time)) AS hours,
    EXTRACT(MINUTE FROM TIMESTAMP_MILLIS(time)) AS minutes,
    /*CAST(CONCAT(CAST(EXTRACT(HOUR FROM TIMESTAMP_MILLIS(time)) AS STRING), CAST((EXTRACT(HOUR FROM TIMESTAMP_MILLIS(time))/1) AS STRING)) AS FLOAT64) AS hour_minute,*/
    ROUND(EXTRACT(HOUR FROM TIMESTAMP_MILLIS(time)) + (EXTRACT(MINUTE FROM TIMESTAMP_MILLIS(time))) / 100, 2) AS hour_min,

    CASE WHEN category IS NULL THEN "N/A"
    ELSE category 
    END as Cat_app,

    CASE WHEN app LIKE 'com.%' THEN SUBSTRING(app,5,LENGTH(app))
    WHEN app LIKE 'it.cnr%' THEN SUBSTRING(app,12,LENGTH(app))
    ELSE app
    END AS running_APP_clean,

    CASE 
WHEN LOWER(app) LIKE 'android' THEN 'android'
        WHEN LOWER(app) LIKE 'com.android%' THEN 'android'
        WHEN LOWER(app) LIKE 'com.sec.android%' THEN 'android'
        WHEN LOWER(app) LIKE 'com.samsung.android%' THEN 'android'
        WHEN LOWER(app) LIKE '%twitter%' THEN 'twitter'
        WHEN LOWER(app) LIKE '%whatsapp%' THEN 'whatsapp'
        WHEN LOWER(app) LIKE '%mixplorer%' THEN 'mixplorer'
        WHEN LOWER(app) LIKE '%spotify%' THEN 'spotify'
        WHEN LOWER(app) LIKE '%vodafone%' THEN 'vodafone'
        WHEN LOWER(app) LIKE '%telegram%' THEN 'telegram'
        WHEN LOWER(app) LIKE '%sensapp%' THEN 'sensapp'
        WHEN LOWER(app) LIKE '%rsoft%' THEN 'rsoft'
        WHEN LOWER(app) LIKE '%argosoft%' THEN 'argosoft'
        WHEN LOWER(app) LIKE '%minecraftpe%' THEN 'minecraftpe'
        WHEN LOWER(app) LIKE '%robtopx%' THEN 'robtopx'
        WHEN LOWER(app) LIKE '%supercell%' THEN 'supercell'
        WHEN LOWER(app) LIKE '%studio8apps%' THEN 'studio8apps'
        WHEN LOWER(app) LIKE '%samsung%' AND LOWER(app) NOT LIKE '%samsung.android%' THEN 'samsung'
        WHEN LOWER(app) LIKE '%facebook%' THEN 'facebook'
        -- REVISAR CUANDO SEA APPLE--
   ELSE 'other' 
   END AS app_running_source,

    CASE 
    WHEN EXTRACT(DAYOFWEEK FROM TIMESTAMP_MILLIS(time)) >= 6 THEN 'weekend'
    ELSE 'weekday' END AS Day_of_week 

   FROM {{ source('Interview_data_analysis_MDF', 'MDF_running_apps') }}
)

SELECT *
FROM source