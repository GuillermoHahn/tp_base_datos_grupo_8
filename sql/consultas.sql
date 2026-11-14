-- CANAL
-- Crear un canal
-- El creador debe ser un usuario existente (FK a Usuarios).
INSERT INTO Canales (nombre, tema, tarifa_por_vista, fecha_creacion, nombre_usuario)
VALUES ('Taller de Flor', 'Arte', 0.0030, '2026-11-01', 'flor_arte');

-- Editar un canal
-- Se modifican el tema y la tarifa por vista del canal "Jaque al Rey".
UPDATE Canales
SET tema             = 'Ajedrez y estrategia',
    tarifa_por_vista = 0.0018
WHERE nombre = 'Jaque al Rey';

-- Cambiar el nombre (clave primaria) del canal.
-- Por ON UPDATE CASCADE el nuevo nombre se propaga a Videos y SeSuscribeA.
UPDATE Canales
SET nombre = 'Jaque Mate'
WHERE nombre = 'Jaque al Rey';

-- Eliminar un canal
-- Por ON DELETE CASCADE también se eliminan sus videos (y las visualizaciones de esos videos) y sus suscripciones.
DELETE FROM Canales
WHERE nombre = 'Retro Pixel';

-- VIDEOS
-- Crear un video
-- El canal debe existir (FK a Canales) y la fecha de publicacion no puede ser anterior a la creacion del canal.
INSERT INTO Videos (enlace, titulo, fecha_publicacion, nombre_canal)
VALUES ('https://youtu.be/Nu01Prueba01', 'video nuevo', '2026-11-05', 'Código Abierto');

-- Editar un video
-- Se modifica el titulo del video.
UPDATE Videos
SET titulo = 'video nuevo (editado)'
WHERE enlace = 'https://youtu.be/Nu01Prueba01';

-- Se modifica la fecha de publicacion (se vuelve a validar contra la creacion del canal).
UPDATE Videos
SET fecha_publicacion = '2026-08-15'
WHERE enlace = 'https://youtu.be/Nu01Prueba01';

-- Se mueve el video a otro canal.
UPDATE Videos
SET nombre_canal = 'Gamer Andino'
WHERE enlace = 'https://youtu.be/Nu01Prueba01';

-- Cambiar el enlace (clave primaria) del video.
-- Por ON UPDATE CASCADE el nuevo enlace se propaga a Visualiza.
UPDATE Videos
SET enlace = 'https://youtu.be/Nu02Prueba02'
WHERE enlace = 'https://youtu.be/Nu01Prueba01';

-- Eliminar un video
-- Por ON DELETE CASCADE tambien se eliminan las visualizaciones de ese video.
DELETE FROM Videos
WHERE enlace = 'https://youtu.be/Nu02Prueba02';

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
SELECT c.nombre, c.tema, c.fecha_creacion, s.cantidad_suscriptores
FROM suscripciones_canales s
INNER JOIN Canales c
ON c.nombre = s.nombre_canal
WHERE s.cantidad_suscriptores = (SELECT MAX(cantidad_suscriptores)
                                 FROM suscripciones_canales);

-- Contabilizar la cantidad de usuarios por país.

SELECT pais, COUNT(*) AS cantidad_usuarios
FROM Usuarios
GROUP BY pais
ORDER BY cantidad_usuarios DESC, pais;

-- USUARIOS
-- Registrar un usuario
-- El correo debe ser único y cumplir el formato válido (correo_t), y el país debe pertenecer al dominio pais_t.
-- Si no se especifica cantidad_inicios, toma el valor por defecto 0.
INSERT INTO Usuarios (nombre_usuario, correo, pais, cantidad_inicios)
VALUES ('guille_dev', 'guillermo.hahn@fi.uba.ar', 'Argentina', 6);

-- Editar un usuario
-- Se modifican el correo, el país y se incrementa el contador de inicios de sesión del usuario.
UPDATE Usuarios
SET correo           = 'guille.hahn@gmail.com',
    pais             = 'Chile',
    cantidad_inicios = cantidad_inicios + 1
WHERE nombre_usuario = 'guille_dev';

-- Cambiar el nombre_usuario (clave primaria) de un usuario existente.
-- Por ON UPDATE CASCADE el nuevo nombre se propaga a Canales, SeSuscribeA y Visualiza.
UPDATE Usuarios
SET nombre_usuario = 'tomas_GM'
WHERE nombre_usuario = 'tomas_ajedrez';

-- Eliminar un usuario
-- Por ON DELETE CASCADE también se eliminan sus canales (y con ellos sus videos, visualizaciones y suscripciones recibidas),
-- además de las suscripciones y visualizaciones realizadas por el usuario.
DELETE FROM Usuarios
WHERE nombre_usuario = 'hugo_campo';

-- Listar todos los usuarios de la aplicación.
SELECT nombre_usuario, correo, pais, cantidad_inicios
FROM Usuarios
ORDER BY nombre_usuario;
