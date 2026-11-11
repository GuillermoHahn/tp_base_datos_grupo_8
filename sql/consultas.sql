-- Listado de los videos más populares (con más "me gusta")

WITH videos_me_gusta AS (
    SELECT enlace_video, COUNT(*) AS cantidad_me_gusta
    FROM Visualiza
    WHERE me_gusta = TRUE 
    GROUP BY enlace_video
)
SELECT v.enlace, v.titulo, v.fecha_publicacion, mg.cantidad_me_gusta
FROM Videos AS v
INNER JOIN videos_me_gusta mg
ON v.enlace = mg.enlace_video
WHERE mg.cantidad_me_gusta = (SELECT MAX(cantidad_me_gusta)
                                 FROM videos_me_gusta);


-- Listado de los canales más populares (los que tienen más suscritptores).

WITH suscripciones_canales AS (
    SELECT nombre_canal, COUNT(*) AS cantidad_suscriptores
    FROM SeSuscribeA
    GROUP BY nombre_canal
)
SELECT c.nombre_canal, c.tema, c.fecha_creacion, s.cantidad_suscriptores
FROM suscripciones_canales s
INNER JOIN Canales c 
ON c.nombre_canal = s.nombre_canal
WHERE s.cantidad_suscriptores = (SELECT MAX(cantidad_suscriptores)
                                 FROM suscripciones_canales);








