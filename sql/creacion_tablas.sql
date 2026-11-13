
-- Creación del schema del sistema
CREATE SCHEMA IF NOT EXISTS plataforma_videos;

-- Creación de dominios y validaciones de atributos
CREATE DOMAIN plataforma_videos.nombre_usuario_t AS VARCHAR(64)
CHECK (char_length(trim(VALUE)) > 0);

CREATE DOMAIN plataforma_videos.enlace_t AS VARCHAR(255)
CHECK (char_length(trim(VALUE)) > 0);

CREATE DOMAIN plataforma_videos.nombre_canal_t AS VARCHAR(100)
CHECK (char_length(trim(VALUE)) > 0);

-- Validación básica de formato de correo electrónico
CREATE DOMAIN plataforma_videos.correo_t AS VARCHAR(120)
CHECK (VALUE ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]+$');

-- Conjunto válido de países permitidos
CREATE DOMAIN plataforma_videos.pais_t AS VARCHAR(32)
CHECK (VALUE IN ('Argentina', 'Chile', 'Brasil', 'Paraguay', 'Uruguay'));

-- Dominio monetario
CREATE DOMAIN plataforma_videos.tarifa_por_vista_t AS NUMERIC(10, 4)
DEFAULT 0 NOT NULL CHECK (VALUE >= 0);


-- Creación de tablas del esquema relacional
CREATE TABLE plataforma_videos.Usuarios (
    nombre_usuario plataforma_videos.nombre_usuario_t,
    correo plataforma_videos.correo_t NOT NULL,
    pais plataforma_videos.pais_t NOT NULL,
    cantidad_inicios INT NOT NULL DEFAULT 0 CHECK (cantidad_inicios >= 0),
    CONSTRAINT pk_usuarios PRIMARY KEY (nombre_usuario),
    CONSTRAINT uq_usuarios_correo UNIQUE (correo)
);

CREATE TABLE plataforma_videos.Canales (
    nombre_canal plataforma_videos.nombre_canal_t,
    tema VARCHAR(100) NOT NULL,
    tarifa_por_vista plataforma_videos.tarifa_por_vista_t,
    fecha_creacion DATE NOT NULL DEFAULT CURRENT_DATE,
    nombre_usuario plataforma_videos.nombre_usuario_t NOT NULL,
    CONSTRAINT pk_canales PRIMARY KEY (nombre_canal),
    CONSTRAINT fk_canales_usuario FOREIGN KEY (nombre_usuario)
        REFERENCES plataforma_videos.Usuarios(nombre_usuario)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE plataforma_videos.Videos (
    enlace plataforma_videos.enlace_t,
    titulo VARCHAR(200) NOT NULL CHECK (char_length(trim(titulo)) > 0),
    fecha_publicacion DATE NOT NULL DEFAULT CURRENT_DATE,
    nombre_canal plataforma_videos.nombre_canal_t NOT NULL,
    CONSTRAINT pk_videos PRIMARY KEY (enlace),
    CONSTRAINT fk_videos_canal FOREIGN KEY (nombre_canal)
        REFERENCES plataforma_videos.Canales(nombre_canal)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE plataforma_videos.SeSuscribeA (
    nombre_usuario plataforma_videos.nombre_usuario_t,
    nombre_canal plataforma_videos.nombre_canal_t,
    fecha_suscripcion DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT pk_sesuscribea PRIMARY KEY (nombre_usuario, nombre_canal),
    CONSTRAINT fk_sesuscribea_canal FOREIGN KEY (nombre_canal)
        REFERENCES plataforma_videos.Canales(nombre_canal)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_sesuscribea_usuario FOREIGN KEY (nombre_usuario)
        REFERENCES plataforma_videos.Usuarios(nombre_usuario)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE plataforma_videos.Visualiza (
    nombre_usuario plataforma_videos.nombre_usuario_t,
    enlace_video plataforma_videos.enlace_t,
    cantidad_vistas INT NOT NULL DEFAULT 1 CHECK (cantidad_vistas >= 1),
    me_gusta BOOLEAN NOT NULL DEFAULT FALSE,
    no_me_gusta BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT pk_visualiza PRIMARY KEY (nombre_usuario, enlace_video),
    CONSTRAINT fk_visualiza_video FOREIGN KEY (enlace_video)
        REFERENCES plataforma_videos.Videos(enlace)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_visualiza_usuario FOREIGN KEY (nombre_usuario)
        REFERENCES plataforma_videos.Usuarios(nombre_usuario)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ck_visualiza_like_dislike CHECK (NOT (me_gusta AND no_me_gusta))
);

-- Triggers para restricciones de integridad entre tablas
-- 1) Un video no puede publicarse antes de la creación del canal al que pertenece.
CREATE OR REPLACE FUNCTION plataforma_videos.fn_check_fecha_publicacion()
RETURNS TRIGGER AS $$
DECLARE
    fc DATE;
BEGIN
    SELECT fecha_creacion INTO fc
    FROM plataforma_videos.Canales
    WHERE nombre_canal = NEW.nombre_canal;

    IF NEW.fecha_publicacion < fc THEN
        RAISE EXCEPTION 'El video no puede publicarse (%) antes de la creación del canal (%)', NEW.fecha_publicacion, fc
            USING ERRCODE = '23514';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_check_fecha_publicacion
BEFORE INSERT OR UPDATE OF fecha_publicacion, nombre_canal ON plataforma_videos.Videos
FOR EACH ROW EXECUTE FUNCTION plataforma_videos.fn_check_fecha_publicacion();


-- 2) Una suscripción no puede ser anterior a la creación del canal ni del propio dueño del canal.
CREATE OR REPLACE FUNCTION plataforma_videos.fn_check_suscripcion()
RETURNS TRIGGER AS $$
DECLARE
    c plataforma_videos.Canales%ROWTYPE;
BEGIN
    SELECT * INTO c
    FROM plataforma_videos.Canales
    WHERE nombre_canal = NEW.nombre_canal;

    IF NEW.fecha_suscripcion < c.fecha_creacion THEN
        RAISE EXCEPTION 'La suscripción (%) no puede ser anterior a la creación del canal (%)', NEW.fecha_suscripcion, c.fecha_creacion;
    END IF;

    IF NEW.nombre_usuario = c.nombre_usuario THEN
        RAISE EXCEPTION 'Un usuario (%) no puede suscribirse a su propio canal (%)', NEW.nombre_usuario, NEW.nombre_canal;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_check_suscripcion
BEFORE INSERT OR UPDATE ON plataforma_videos.SeSuscribeA
FOR EACH ROW EXECUTE FUNCTION plataforma_videos.fn_check_suscripcion();
