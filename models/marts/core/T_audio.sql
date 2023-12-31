SELECT users_id, time, bt_sco_connected, mic_muted, music_active, speaker_on, headset_connected, ringer_mode,
AVG(alarm_volume) As avg_alarm,
AVG(music_volume) As avg_music,
AVG(notifications_volume) As avg_notif,
AVG(ring_volume) as avg_ring
FROM {{ ref('stg_audio') }}
GROUP BY 1,2,3,4,5,6,7,8
--ORDER BY hour_day DESC