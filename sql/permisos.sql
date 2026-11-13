
CREATE ROLE admin NOLOGIN;
CREATE ROLE observador NOLOGIN;

GRANT USAGE ON SCHEMA plataforma_videos TO admin, observador;

GRANT SELECT, INSERT, UPDATE, DELETE
    ON ALL TABLES IN SCHEMA plataforma_videos TO admin;

GRANT SELECT
    ON ALL TABLES IN SCHEMA plataforma_videos TO observador;
