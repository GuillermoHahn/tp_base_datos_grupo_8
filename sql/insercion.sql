BEGIN;

-- ---------------------------------------------------------------------
-- 1) USUARIOS 
-- ---------------------------------------------------------------------
INSERT INTO plataforma_videos.Usuarios (nombre_usuario, correo, pais, cantidad_inicios) VALUES
    ('gonza_ruiz',     'gonzalo.ruiz@gmail.com',          'Argentina', 152),
    ('sofi_martinez',  'sofia.martinez@hotmail.com',       'Argentina',  87),
    ('juanpe_gamer',   'juanpablo.gamer@yahoo.com',        'Chile',     340),
    ('cami_cocina',    'camila.rojas@gmail.com',           'Chile',      45),
    ('lucas_tech',     'lucas.oliveira@uol.com.br',        'Brasil',    210),
    ('mariana_fit',    'mariana.souza@gmail.com',          'Brasil',     98),
    ('diego_musica',   'diego.benitez@gmail.com',          'Paraguay',   63),
    ('vale_lectura',   'valentina.gonzalez@outlook.com',   'Uruguay',   120),
    ('nico_viajes',    'nicolas.pereira@gmail.com',        'Uruguay',    77),
    ('flor_arte',      'florencia.lopez@gmail.com',        'Argentina',  31),
    ('mateo_dev',      'mateo.fernandez@protonmail.com',   'Argentina', 405),
    ('isa_ciencia',    'isabel.munoz@gmail.com',           'Chile',      56),
    ('pedro_futbol',   'pedro.santos@terra.com.br',        'Brasil',    188),
    ('ana_paz',        'ana.paz@gmail.com',                'Paraguay',   12),
    ('carla_vlogs',    'carla.vera@gmail.com',             'Argentina', 260),
    ('tomas_ajedrez',  'tomas.silva@gmail.com',            'Chile',      74),
    ('bruna_moda',     'bruna.costa@gmail.com',            'Brasil',    133),
    ('hugo_campo',     'hugo.acosta@gmail.com',            'Paraguay',    9);


-- Usuario que usa el DEFAULT de cantidad_inicios (queda en 0)
INSERT INTO plataforma_videos.Usuarios (nombre_usuario, correo, pais) VALUES
    ('martin_r', 'martin.rodriguez@adinet.com.uy', 'Uruguay');

-- Usuario con un solo inicio de sesión
INSERT INTO plataforma_videos.Usuarios (nombre_usuario, correo, pais, cantidad_inicios) VALUES
    ('lucia_r', 'lucia.ramos@gmail.com', 'Uruguay', 1);


-- ---------------------------------------------------------------------
-- 2) CANALES 
-- ---------------------------------------------------------------------
INSERT INTO plataforma_videos.Canales (nombre_canal, tema, tarifa_por_vista, fecha_creacion, nombre_usuario) VALUES
    ('Código Abierto',         'Programación',            0.0035, '2019-03-15', 'gonza_ruiz'),
    ('Gamer Andino',       'Videojuegos',             0.0050, '2018-07-01', 'juanpe_gamer'),
    ('La Cocina de Cami',  'Cocina',                  0.0028, '2020-05-10', 'cami_cocina'),
    ('TechBR',             'Tecnología',              0.0062, '2017-11-20', 'lucas_tech'),
    ('Mari Fitness',       'Salud y deporte',         0.0041, '2021-01-04', 'mariana_fit'),
    ('Guaraní Sounds',     'Música',                  0.0019, '2019-09-12', 'diego_musica'),
    ('Entre Páginas',      'Literatura',              0.0015, '2020-02-29', 'vale_lectura'),
    ('Mochila al Hombro',  'Viajes',                  0.0033, '2018-04-18', 'nico_viajes'),
    ('Mateo Dev',          'Programación',            0.0070, '2022-06-01', 'mateo_dev'),
    ('Ciencia en Corto',   'Divulgación científica',  0.0045, '2021-08-23', 'isa_ciencia'),
    ('Fútbol Total BR',    'Deportes',                0.0055, '2016-02-14', 'pedro_futbol'),
    ('Carla en Ruta',      'Vlogs',                   0.0039, '2019-12-01', 'carla_vlogs'),
    ('Jaque al Rey',       'Ajedrez',                 0.0012, '2023-03-03', 'tomas_ajedrez'),
    ('Bruna Style',        'Moda',                    0.0048, '2020-10-10', 'bruna_moda'),
    ('Retro Pixel',        'Videojuegos retro',       0.0020, '2023-08-15', 'gonza_ruiz');

-- Canal con valores por defecto (tarifa 0, fecha de hoy)
INSERT INTO plataforma_videos.Canales (nombre_canal, tema, nombre_usuario) VALUES
    ('Recién Llegado', 'Varios', 'lucia_r');


-- ---------------------------------------------------------------------
-- 3) VIDEOS 
-- ---------------------------------------------------------------------
INSERT INTO plataforma_videos.Videos (enlace, titulo, fecha_publicacion, nombre_canal) VALUES
    -- Código Abierto (creado 2019-03-15)
    ('https://youtu.be/Fc01SqlBas1', 'Introducción a SQL: SELECT desde cero',           '2019-04-02', 'Código Abierto'),
    ('https://youtu.be/Fc02JoinEx2', 'JOINs explicados con ejemplos',                   '2019-06-20', 'Código Abierto'),
    ('https://youtu.be/Fc03TrigPg3', 'Triggers en PostgreSQL paso a paso',              '2021-09-14', 'Código Abierto'),
    ('https://youtu.be/Fc04Norm3F4', 'Normalización hasta 3FN',                         '2022-03-08', 'Código Abierto'),
    ('https://youtu.be/Fc05Transa5', 'Transacciones y niveles de aislamiento',          '2024-10-01', 'Código Abierto'),

    -- Gamer Andino (creado 2018-07-01)
    ('https://youtu.be/Ga01Speed01', 'Speedrun de Celeste en menos de 30 minutos',      '2018-08-11', 'Gamer Andino'),
    ('https://youtu.be/Ga02Top10Rp', 'Top 10 RPG de la década',                         '2020-01-05', 'Gamer Andino'),
    ('https://youtu.be/Ga03Review3', 'Review: el indie del año',                        '2023-11-30', 'Gamer Andino'),

    -- La Cocina de Cami (creado 2020-05-10) -> primer video el mismo día (caso límite válido)
    ('https://youtu.be/Co01Empana1', 'Empanadas chilenas de pino',                      '2020-05-10', 'La Cocina de Cami'),
    ('https://youtu.be/Co02Sopaip2', 'Sopaipillas pasadas',                             '2020-07-22', 'La Cocina de Cami'),
    ('https://youtu.be/Co03PanAma3', 'Pan amasado casero',                              '2021-04-03', 'La Cocina de Cami'),

    -- TechBR (creado 2017-11-20)
    ('https://youtu.be/Tb01Unbox01', 'Unboxing del celular más barato del mercado',     '2017-12-01', 'TechBR'),
    ('https://youtu.be/Tb02ArmaPC2', 'Armando una PC gamer económica',                  '2019-02-18', 'TechBR'),
    ('https://youtu.be/Tb03Linux03', 'Linux para principiantes',                        '2022-08-09', 'TechBR'),
    ('https://youtu.be/Tb04IAgen04', 'IA generativa: qué es y cómo funciona',           '2024-03-15', 'TechBR'),

    -- Mari Fitness (creado 2021-01-04)
    ('https://youtu.be/Mf01Rutina1', 'Rutina de 20 minutos sin equipamiento',           '2021-01-10', 'Mari Fitness'),
    ('https://youtu.be/Mf02Estira2', 'Estiramientos para después de correr',            '2021-06-14', 'Mari Fitness'),
    ('https://youtu.be/Mf03Abdom03', 'Abdominales: errores comunes',                    '2022-02-01', 'Mari Fitness'),

    -- Guaraní Sounds (creado 2019-09-12)
    ('https://youtu.be/Gs01Polca01', 'Polca paraguaya en guitarra',                     '2019-10-01', 'Guaraní Sounds'),
    ('https://youtu.be/Gs02Arpa002', 'Arpa paraguaya: clase 1',                         '2020-03-20', 'Guaraní Sounds'),

    -- Entre Páginas (creado 2020-02-29, año bisiesto)
    ('https://youtu.be/Ep01Borges1', 'Reseña: Ficciones de Borges',                     '2020-03-05', 'Entre Páginas'),
    ('https://youtu.be/Ep02Cortaz2', 'Rayuela: cómo leerla',                            '2020-09-17', 'Entre Páginas'),
    ('https://youtu.be/Ep03ClubLe3', 'Club de lectura: noviembre',                      '2023-11-02', 'Entre Páginas'),

    -- Mochila al Hombro (creado 2018-04-18)
    ('https://youtu.be/Mh01Atacam1', 'Desierto de Atacama con poco presupuesto',        '2018-05-30', 'Mochila al Hombro'),
    ('https://youtu.be/Mh02Floria2', 'Florianópolis: 5 playas imperdibles',             '2019-01-15', 'Mochila al Hombro'),
    ('https://youtu.be/Mh03Iguazu3', 'Cataratas del Iguazú: lado argentino vs brasileño','2022-07-07', 'Mochila al Hombro'),

    -- Mateo Dev (creado 2022-06-01)
    ('https://youtu.be/Md01React01', 'React desde cero',                                '2022-06-02', 'Mateo Dev'),
    ('https://youtu.be/Md02Docker2', 'Docker para desarrolladores',                     '2023-01-19', 'Mateo Dev'),
    ('https://youtu.be/Md03Indice3', 'Índices en PostgreSQL: cuándo usarlos',           '2024-05-27', 'Mateo Dev'),

    -- Ciencia en Corto (creado 2021-08-23)
    ('https://youtu.be/Cc01Agujer1', '¿Qué es un agujero negro?',                       '2021-09-01', 'Ciencia en Corto'),
    ('https://youtu.be/Cc02Vacuna2', 'Cómo funcionan las vacunas de ARNm',              '2022-04-12', 'Ciencia en Corto'),
    ('https://youtu.be/Cc03Eclips3', 'Eclipses: por qué no ocurren todos los meses',    '2024-04-08', 'Ciencia en Corto'),

    -- Fútbol Total BR (creado 2016-02-14)
    ('https://youtu.be/Ft01Golaco1', 'Los mejores goles del Brasileirão',               '2016-03-01', 'Fútbol Total BR'),
    ('https://youtu.be/Ft02Tactic2', 'Análisis táctico: 4-3-3 vs 4-4-2',                '2018-06-25', 'Fútbol Total BR'),
    ('https://youtu.be/Ft03Libert3', 'Resumen de la final de la Libertadores',          '2023-11-05', 'Fútbol Total BR'),

    -- Carla en Ruta (creado 2019-12-01)
    ('https://youtu.be/Cr01Barilo1', 'Un día en Bariloche',                             '2019-12-20', 'Carla en Ruta'),
    ('https://youtu.be/Cr02Mendoz2', 'Ruta del vino en Mendoza',                        '2021-03-11', 'Carla en Ruta'),

    -- Jaque al Rey (creado 2023-03-03)
    ('https://youtu.be/Jr01Apertu1', 'Aperturas para principiantes',                    '2023-03-10', 'Jaque al Rey'),
    ('https://youtu.be/Jr02Finale2', 'Finales de torre y peón',                         '2024-01-22', 'Jaque al Rey'),

    -- Bruna Style (creado 2020-10-10)
    ('https://youtu.be/Bs01Otono01', 'Tendencias otoño-invierno',                       '2021-03-01', 'Bruna Style'),
    ('https://youtu.be/Bs02Capsul2', 'Armario cápsula en 10 prendas',                   '2022-09-09', 'Bruna Style'),

    -- Retro Pixel (creado 2023-08-15)
    ('https://youtu.be/Fr01Nes0001', 'Clásicos de NES que envejecieron bien',           '2023-08-20', 'Retro Pixel'),
    ('https://youtu.be/Fr02Snes002', 'Comparativa SNES vs Mega Drive',                  '2024-02-11', 'Retro Pixel');


-- Video que usa el DEFAULT de fecha_publicacion (CURRENT_DATE),
INSERT INTO plataforma_videos.Videos (enlace, titulo, nombre_canal) VALUES
    ('https://youtu.be/Rl01Hola001', 'Mi primer video', 'Recién Llegado');


-- ---------------------------------------------------------------------
-- 4) SESUSCRIBEA
-- ---------------------------------------------------------------------
INSERT INTO plataforma_videos.SeSuscribeA (nombre_usuario, nombre_canal, fecha_suscripcion) VALUES
    ('sofi_martinez', 'Código Abierto',         '2019-05-01'),
    ('sofi_martinez', 'La Cocina de Cami',  '2020-06-01'),
    ('sofi_martinez', 'Entre Páginas',      '2020-04-12'),
    ('sofi_martinez', 'Carla en Ruta',      '2020-01-15'),
    ('sofi_martinez', 'Bruna Style',        '2021-01-20'),

    ('gonza_ruiz',    'Mateo Dev',          '2022-06-05'),
    ('gonza_ruiz',    'TechBR',             '2018-02-10'),
    ('gonza_ruiz',    'Gamer Andino',       '2019-01-01'),
    ('gonza_ruiz',    'Jaque al Rey',       '2023-04-01'),

    ('juanpe_gamer',  'Retro Pixel',        '2023-09-01'),
    ('juanpe_gamer',  'TechBR',             '2018-01-15'),
    ('juanpe_gamer',  'Fútbol Total BR',    '2019-07-07'),
    ('juanpe_gamer',  'Código Abierto',         '2020-02-02'),

    ('cami_cocina',   'Mari Fitness',       '2021-02-02'),
    ('cami_cocina',   'Mochila al Hombro',  '2019-03-03'),

    ('lucas_tech',    'Código Abierto',         '2019-04-10'),
    ('lucas_tech',    'Mateo Dev',          '2022-07-01'),
    ('lucas_tech',    'Ciencia en Corto',   '2021-09-10'),
    ('lucas_tech',    'Gamer Andino',       '2018-09-09'),

    ('mariana_fit',   'La Cocina de Cami',  '2021-01-15'),
    ('mariana_fit',   'Bruna Style',        '2020-11-11'),

    ('diego_musica',  'Fútbol Total BR',    '2017-05-20'),
    ('diego_musica',  'Entre Páginas',      '2021-05-05'),

    ('vale_lectura',  'Ciencia en Corto',   '2021-10-01'),
    ('vale_lectura',  'Jaque al Rey',       '2023-05-15'),
    ('vale_lectura',  'Carla en Ruta',      '2020-02-02'),

    ('nico_viajes',   'Carla en Ruta',      '2019-12-05'),
    ('nico_viajes',   'Fútbol Total BR',    '2018-08-08'),

    ('flor_arte',     'Bruna Style',        '2020-12-24'),
    ('flor_arte',     'Entre Páginas',      '2020-03-01'),
    ('flor_arte',     'Guaraní Sounds',     '2020-04-04'),

    ('mateo_dev',     'Código Abierto',         '2022-06-01'),
    ('mateo_dev',     'TechBR',             '2022-06-01'),

    ('isa_ciencia',   'Mateo Dev',          '2023-02-14'),
    ('isa_ciencia',   'Entre Páginas',      '2022-01-01'),

    -- caso límite válido: suscripción el mismo día de creación del canal
    ('pedro_futbol',  'Gamer Andino',       '2018-07-01'),
    ('pedro_futbol',  'Mari Fitness',       '2021-01-04'),

    ('ana_paz',       'Guaraní Sounds',     '2019-09-20'),
    ('ana_paz',       'La Cocina de Cami',  '2022-10-10'),

    ('carla_vlogs',   'Mochila al Hombro',  '2019-06-06'),
    ('carla_vlogs',   'Bruna Style',        '2021-07-07'),

    ('tomas_ajedrez', 'Ciencia en Corto',   '2022-01-10'),
    ('tomas_ajedrez', 'Código Abierto',         '2020-08-08'),

    ('bruna_moda',    'Mari Fitness',       '2021-03-03'),
    ('bruna_moda',    'Carla en Ruta',      '2020-11-30'),

    ('hugo_campo',    'Guaraní Sounds',     '2024-02-02'),
    ('lucia_r',       'Entre Páginas',      '2025-01-01');


-- Suscripciones con DEFAULT de fecha_suscripcion (CURRENT_DATE)
INSERT INTO plataforma_videos.SeSuscribeA (nombre_usuario, nombre_canal) VALUES
    ('sofi_martinez', 'Recién Llegado'),
    ('hugo_campo',    'Recién Llegado');


-- ---------------------------------------------------------------------
-- 5) VISUALIZA 
-- ---------------------------------------------------------------------
INSERT INTO plataforma_videos.Visualiza (nombre_usuario, enlace_video, cantidad_vistas, me_gusta, no_me_gusta) VALUES
    -- sofi_martinez
    ('sofi_martinez', 'https://youtu.be/Fc01SqlBas1',  3, TRUE,  FALSE),
    ('sofi_martinez', 'https://youtu.be/Fc02JoinEx2',  2, TRUE,  FALSE),
    ('sofi_martinez', 'https://youtu.be/Co01Empana1',  1, TRUE,  FALSE),
    ('sofi_martinez', 'https://youtu.be/Co03PanAma3',  4, TRUE,  FALSE),
    ('sofi_martinez', 'https://youtu.be/Ep01Borges1',  1, FALSE, FALSE),
    ('sofi_martinez', 'https://youtu.be/Cr01Barilo1',  2, TRUE,  FALSE),
    ('sofi_martinez', 'https://youtu.be/Bs02Capsul2',  1, FALSE, TRUE),

    -- gonza_ruiz
    ('gonza_ruiz',    'https://youtu.be/Md01React01',  5, TRUE,  FALSE),
    ('gonza_ruiz',    'https://youtu.be/Md02Docker2',  2, TRUE,  FALSE),
    ('gonza_ruiz',    'https://youtu.be/Md03Indice3',  1, TRUE,  FALSE),
    ('gonza_ruiz',    'https://youtu.be/Tb03Linux03',  1, FALSE, FALSE),
    ('gonza_ruiz',    'https://youtu.be/Ga02Top10Rp',  2, FALSE, TRUE),
    ('gonza_ruiz',    'https://youtu.be/Jr01Apertu1',  1, TRUE,  FALSE),

    -- juanpe_gamer
    ('juanpe_gamer',  'https://youtu.be/Fr01Nes0001', 12, TRUE,  FALSE),
    ('juanpe_gamer',  'https://youtu.be/Fr02Snes002',  7, TRUE,  FALSE),
    ('juanpe_gamer',  'https://youtu.be/Tb02ArmaPC2',  4, TRUE,  FALSE),
    ('juanpe_gamer',  'https://youtu.be/Ft02Tactic2',  1, FALSE, TRUE),
    ('juanpe_gamer',  'https://youtu.be/Fc03TrigPg3',  1, FALSE, FALSE),

    -- cami_cocina
    ('cami_cocina',   'https://youtu.be/Mf01Rutina1',  6, TRUE,  FALSE),
    ('cami_cocina',   'https://youtu.be/Mf02Estira2',  2, TRUE,  FALSE),
    ('cami_cocina',   'https://youtu.be/Mh01Atacam1',  1, TRUE,  FALSE),

    -- lucas_tech
    ('lucas_tech',    'https://youtu.be/Fc01SqlBas1',  1, TRUE,  FALSE),
    ('lucas_tech',    'https://youtu.be/Fc04Norm3F4',  2, TRUE,  FALSE),
    ('lucas_tech',    'https://youtu.be/Md02Docker2',  3, TRUE,  FALSE),
    ('lucas_tech',    'https://youtu.be/Cc01Agujer1',  1, TRUE,  FALSE),
    ('lucas_tech',    'https://youtu.be/Cc02Vacuna2',  1, FALSE, FALSE),
    ('lucas_tech',    'https://youtu.be/Ga01Speed01',  2, FALSE, TRUE),

    -- mariana_fit
    ('mariana_fit',   'https://youtu.be/Co02Sopaip2',  1, TRUE,  FALSE),
    ('mariana_fit',   'https://youtu.be/Bs01Otono01',  3, TRUE,  FALSE),
    ('mariana_fit',   'https://youtu.be/Bs02Capsul2',  2, TRUE,  FALSE),

    -- diego_musica
    ('diego_musica',  'https://youtu.be/Ft01Golaco1',  8, TRUE,  FALSE),
    ('diego_musica',  'https://youtu.be/Ft03Libert3',  3, TRUE,  FALSE),
    ('diego_musica',  'https://youtu.be/Ep02Cortaz2',  1, FALSE, FALSE),

    -- vale_lectura
    ('vale_lectura',  'https://youtu.be/Cc01Agujer1',  2, TRUE,  FALSE),
    ('vale_lectura',  'https://youtu.be/Cc03Eclips3',  1, TRUE,  FALSE),
    ('vale_lectura',  'https://youtu.be/Jr01Apertu1',  1, FALSE, TRUE),
    ('vale_lectura',  'https://youtu.be/Cr02Mendoz2',  2, TRUE,  FALSE),

    -- nico_viajes
    ('nico_viajes',   'https://youtu.be/Cr01Barilo1',  3, TRUE,  FALSE),
    ('nico_viajes',   'https://youtu.be/Cr02Mendoz2',  1, TRUE,  FALSE),
    ('nico_viajes',   'https://youtu.be/Ft02Tactic2',  1, FALSE, FALSE),
    ('nico_viajes',   'https://youtu.be/Mh03Iguazu3',  1, TRUE,  FALSE),

    -- flor_arte
    ('flor_arte',     'https://youtu.be/Bs01Otono01',  1, TRUE,  FALSE),
    ('flor_arte',     'https://youtu.be/Ep01Borges1',  2, TRUE,  FALSE),
    ('flor_arte',     'https://youtu.be/Gs01Polca01',  1, FALSE, FALSE),
    ('flor_arte',     'https://youtu.be/Gs02Arpa002',  4, TRUE,  FALSE),

    -- mateo_dev
    ('mateo_dev',     'https://youtu.be/Fc01SqlBas1',  1, FALSE, FALSE),
    ('mateo_dev',     'https://youtu.be/Fc03TrigPg3',  3, TRUE,  FALSE),
    ('mateo_dev',     'https://youtu.be/Fc05Transa5',  2, TRUE,  FALSE),
    ('mateo_dev',     'https://youtu.be/Tb04IAgen04',  1, FALSE, TRUE),

    -- isa_ciencia
    ('isa_ciencia',   'https://youtu.be/Md01React01',  1, TRUE,  FALSE),
    ('isa_ciencia',   'https://youtu.be/Ep03ClubLe3',  1, TRUE,  FALSE),
    ('isa_ciencia',   'https://youtu.be/Tb04IAgen04',  2, TRUE,  FALSE),

    -- pedro_futbol
    ('pedro_futbol',  'https://youtu.be/Ga01Speed01',  1, FALSE, FALSE),
    ('pedro_futbol',  'https://youtu.be/Ga03Review3',  2, TRUE,  FALSE),
    ('pedro_futbol',  'https://youtu.be/Mf03Abdom03',  5, TRUE,  FALSE),

    -- ana_paz
    ('ana_paz',       'https://youtu.be/Gs01Polca01', 10, TRUE,  FALSE),
    ('ana_paz',       'https://youtu.be/Gs02Arpa002',  6, TRUE,  FALSE),
    ('ana_paz',       'https://youtu.be/Co01Empana1',  1, FALSE, TRUE),

    -- carla_vlogs
    ('carla_vlogs',   'https://youtu.be/Mh01Atacam1',  2, TRUE,  FALSE),
    ('carla_vlogs',   'https://youtu.be/Mh02Floria2',  3, TRUE,  FALSE),
    ('carla_vlogs',   'https://youtu.be/Mh03Iguazu3',  1, TRUE,  FALSE),
    ('carla_vlogs',   'https://youtu.be/Bs02Capsul2',  1, FALSE, FALSE),

    -- tomas_ajedrez
    ('tomas_ajedrez', 'https://youtu.be/Cc02Vacuna2',  1, TRUE,  FALSE),
    ('tomas_ajedrez', 'https://youtu.be/Fc02JoinEx2',  2, TRUE,  FALSE),
    ('tomas_ajedrez', 'https://youtu.be/Fc04Norm3F4',  1, FALSE, FALSE),

    -- bruna_moda
    ('bruna_moda',    'https://youtu.be/Mf01Rutina1',  2, TRUE,  FALSE),
    ('bruna_moda',    'https://youtu.be/Cr01Barilo1',  1, TRUE,  FALSE),
    ('bruna_moda',    'https://youtu.be/Tb01Unbox01',  1, FALSE, TRUE),

    -- hugo_campo
    ('hugo_campo',    'https://youtu.be/Gs01Polca01',  1, TRUE,  FALSE),

    -- lucia_r
    ('lucia_r',       'https://youtu.be/Ep03ClubLe3',  1, TRUE,  FALSE),

    -- Un mismo video visto por muchos usuarios
    ('cami_cocina',   'https://youtu.be/Tb04IAgen04',  1, TRUE,  FALSE),
    ('diego_musica',  'https://youtu.be/Tb04IAgen04',  1, FALSE, FALSE),
    ('vale_lectura',  'https://youtu.be/Tb04IAgen04',  1, TRUE,  FALSE),
    ('nico_viajes',   'https://youtu.be/Tb04IAgen04',  2, TRUE,  FALSE),
    ('carla_vlogs',   'https://youtu.be/Tb04IAgen04',  1, FALSE, TRUE),

    -- El dueño de un canal también puede ver sus propios videos
    ('gonza_ruiz',    'https://youtu.be/Fc01SqlBas1', 15, FALSE, FALSE),
    ('lucas_tech',    'https://youtu.be/Tb04IAgen04',  9, FALSE, FALSE);

-- Visualizaciones con DEFAULT (cantidad_vistas = 1, sin me gusta / no me gusta)
INSERT INTO plataforma_videos.Visualiza (nombre_usuario, enlace_video) VALUES
    ('martin_r',      'https://youtu.be/Ft01Golaco1'),
    ('martin_r',      'https://youtu.be/Cc01Agujer1'),
    ('sofi_martinez', 'https://youtu.be/Rl01Hola001'),
    ('hugo_campo',    'https://youtu.be/Rl01Hola001');

-- Solo indicando me_gusta (el resto toma DEFAULT)
INSERT INTO plataforma_videos.Visualiza (nombre_usuario, enlace_video, me_gusta) VALUES
    ('lucia_r',       'https://youtu.be/Mh02Floria2', TRUE),
    ('flor_arte',     'https://youtu.be/Cr02Mendoz2', TRUE);

COMMIT;

