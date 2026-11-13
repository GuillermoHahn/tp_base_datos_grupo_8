
-- Crear un canal
-- El creador debe ser un usuario existente (FK a Usuarios).
INSERT INTO plataforma_videos.Canales (nombre_canal, tema, tarifa_por_vista, fecha_creacion, nombre_usuario)
VALUES ('Taller de Flor', 'Arte', 0.0030, '2026-11-01', 'flor_arte');

-- Editar un canal
-- Se modifican el tema y la tarifa por vista del canal "Jaque al Rey".
UPDATE plataforma_videos.Canales
SET tema             = 'Ajedrez y estrategia',
    tarifa_por_vista = 0.0018
WHERE nombre_canal = 'Jaque al Rey';

-- Cambiar el nombre (clave primaria) del canal.
-- Por ON UPDATE CASCADE el nuevo nombre se propaga a Videos y SeSuscribeA.
UPDATE plataforma_videos.Canales
SET nombre_canal = 'Jaque Mate'
WHERE nombre_canal = 'Jaque al Rey';

-- Eliminar un canal
-- Por ON DELETE CASCADE también se eliminan sus videos (y las visualizaciones de esos videos) y sus suscripciones.
DELETE FROM plataforma_videos.Canales
WHERE nombre_canal = 'Retro Pixel';


-- Listado de los videos más populares (con más "me gusta")

WITH videos_me_gusta AS (
    SELECT enlace_video, COUNT(*) AS cantidad_me_gusta
    FROM plataforma_videos.Visualiza
    WHERE me_gusta = TRUE 
    GROUP BY enlace_video
)
SELECT v.enlace, v.titulo, v.fecha_publicacion, mg.cantidad_me_gusta
FROM plataforma_videos.Videos AS v
INNER JOIN videos_me_gusta mg
ON v.enlace = mg.enlace_video
WHERE mg.cantidad_me_gusta = (SELECT MAX(cantidad_me_gusta)
                                 FROM videos_me_gusta);


-- Listado de los canales más populares (los que tienen más suscritptores).

WITH suscripciones_canales AS (
    SELECT nombre_canal, COUNT(*) AS cantidad_suscriptores
    FROM plataforma_videos.SeSuscribeA
    GROUP BY nombre_canal
)
SELECT c.nombre, c.tema, c.fecha_creacion, s.cantidad_suscriptores
FROM suscripciones_canales s
INNER JOIN plataforma_videos.Canales c 
ON c.nombre_canal = s.nombre_canal
WHERE s.cantidad_suscriptores = (SELECT MAX(cantidad_suscriptores)
                                 FROM suscripciones_canales);








