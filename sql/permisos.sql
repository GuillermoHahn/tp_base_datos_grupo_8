
CREATE ROLE admin NOLOGIN;
CREATE ROLE observador NOLOGIN;

GRANT USAGE ON SCHEMA plataforma_videos TO admin, observador;

GRANT SELECT, INSERT, UPDATE, DELETE
    ON ALL TABLES IN SCHEMA plataforma_videos TO admin;

GRANT SELECT
    ON ALL TABLES IN SCHEMA plataforma_videos TO observador;

CREATE USER usuario_admin WITH PASSWORD 'Prueba1234';
CREATE USER usuario_observador WITH PASSWORD 'Prueba1234';

GRANT admin TO usuario_admin;
GRANT observador TO usuario_observador;

ALTER ROLE usuario_admin      SET search_path TO plataforma_videos;
ALTER ROLE usuario_observador SET search_path TO plataforma_videos;
