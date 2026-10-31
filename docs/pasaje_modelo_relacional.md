### Pasaje del Modelo Entidad-Relación al Modelo Relacional

Usuarios(<u>nombre_usuario</u>, correo, pais, cantidad_inicios)

Videos(<u>enlace</u>, titulo, fecha_publicacion, <span style="text-decoration: underline dashed;">nombre_canal</span>)

Canales(<u>nombre</u>, tema, tarifa_por_vista, fecha_creacion, <span style="text-decoration: underline dashed;">nombre_usuario</span>)

SeSuscribeA(<span style="text-decoration: underline; border-bottom: 2px dashed; padding-bottom: 2px;">nombre_usuario</span>, <span style="text-decoration: underline; border-bottom: 2px dashed; padding-bottom: 2px;">nombre_canal</span>, fecha)

Visualiza(<span style="text-decoration: underline; border-bottom: 2px dashed; padding-bottom: 2px;">nombre_usuario</span>, <span style="text-decoration: underline; border-bottom: 2px dashed; padding-bottom: 2px;">enlace_video</span>, cantidad_vistas, me_gusta, no_me_gusta)

### Dominios de los atributos de cada esquema de relación

#### Usuarios

- El atributo `nombre_usuario` del esquema de relación `Usuarios` es una cadena de caracteres no vacía.
- El atributo `correo` del esquema de relación `Usuarios` es una cadena de caracteres con formato de dirección de correo electrónico (texto@dominio).
- El atributo `pais` del esquema de relación `Usuarios` es una cadena de caracteres que admite únicamente los siguiente valores: {'Argentina', 'Chile', 'Brasil', 'Paraguay', 'Uruguay'}.
- El atributo `cantidad_inicios` del esquema de relación `Usuarios` es un número entero mayor o igual a 0.

#### Videos

- El atributo `enlace` del esquema de relación `Videos` es una cadena de caracteres no vacía.
- El atributo `titulo` del esquema de relación `Videos` es una cadena de caracteres no vacía.
- El atributo `fecha_publicacion` del esquema de relación `Videos` es una fecha (YYYY/MM/DD).
- El atributo `nombre_canal` del esquema de relación `Videos` es una cadena de caracteres no vacía.

#### Canales

- El atributo `nombre` del esquema de relación `Canales` es una cadena de caracteres no vacía.
- El atributo `tema` del esquema de relación `Canales` es una cadena de caracteres.
- El atributo `tarifa_por_vista` del esquema de relación `Canales` es un *número decimal mayor o igual a 0 (un valor monetario)*.
- El atributo `fecha_creacion` del esquema de relación `Canales` es una fecha (YYYY/MM/DD).
- El atributo `nombre_usuario` del esquema de relación `Canales` es una cadena de caracteres no vacía.

#### SeSuscribeA

- El atributo `nombre_usuario` del esquema de relación `SeSuscribeA` es una cadena de caracteres no vacía.
- El atributo `nombre_canal` del esquema de relación `SeSuscribeA` es una cadena de caracteres no vacía.
- El atributo `fecha` del esquema de relación `SeSuscribeA` es un *timestamp*.

#### Visualiza

- El atributo `nombre_usuario` del esquema de relación `Visualiza` es una cadena de caracteres no vacía.
- El atributo `enlace_video` del esquema de relación `Visualiza` es una cadena de caracteres.
- El atributo `cantidad_vistas` del esquema de relación `Visualiza` es un número entero mayor o igual a 1. Si existe la tupla, el usuario vio el video al menos una vez.
- El atributo `me_gusta` del esquema de relación `Visualiza` es un valor booleano.
- El atributo `no_me_gusta` del esquema de relación `Visualiza` es un valor booleano.


### Justificaciones del pasaje y restricciones

- Cada conjunto de entidades fuerte (`Video`, `Canal` y `Usuario`) del DER se representa como un esquema de relación.
- Se crean los esquemas de relación `SeSuscribeA` y `Visualiza`, derivados de las relaciones `SeSuscribeA` y `Visualiza` del Modelo ER, respectivamente. Esto ocurre porque ambas poseen una cardinalidad (N, N) con respecto a las entidades vinculadas a ellas. 
- Como la relación `Posee` tiene una cardinalidad (1, N), la información debe figurar en el esquema de relación derivado de la entidad de cardinalidad N: `Canales`. Es por ello que `Canales` cuenta con atributos `fecha_creacion` y `nombre_usuario`. Lo mismo ocurre con la relación `PerteneceA`, donde el esquema de relación `Videos` posee el atributo `nombre_canal`, que referencia al atributo `nombre` del esquema de relación `Canales`.
- Se eliminan los atributos derivados de la relación `Video`, ya que no son admisibles en el Modelo Relacional.
- Es necesario contar con una restricción que no permita que los atributos `me_gusta` y `no_me_gusta` sean simultaneamente `True`. 
- La `fecha_publicacion` de un video debe ser posterior o igual a la `fecha_creacion` del canal al que pertenece. Un canal no puede tener videos publicados antes de existir.
- La `fecha` de una suscripción en `SeSuscribeA` debe ser posterior o igual a la `fecha_creacion` del canal.
- Un `Usuario` no puede suscribirse a un canal creado por él mismo. Esta validación no se puede forzar con claves foráneas, por lo que se implementa mediante un Trigger en la base de datos sobre la tabla `SeSuscribeA`.

### Claves Foráneas, Claves Candidatas y Claves Primarias

#### Usuarios

- Claves Candidatas: {{`nombre_usuario`}, {`correo`}}
- Clave Primaria: {`nombre_usuario`}
- Claves Foráneas: No tiene 

#### Videos

- Claves Candidatas: {{`enlace`}}
- Clave Primaria: {`enlace`}
- Claves Foráneas: 
    - El atributo `nombre_canal` es clave foránea y referencia al atributo `nombre` del esquema de relación `Canales`.

#### Canales

- Claves Candidatas: {{`nombre`}}
- Clave Primaria: {`nombre`}
- Claves Foráneas: 
    - El atributo `nombre_usuario` es clave foránea y referencia al atributo `nombre_usuario` del esquema de relación `Usuarios`.

#### SeSuscribeA

- Claves Candidatas: {{`nombre_usuario`, `nombre_canal`}}
- Clave Primaria: {`nombre_usuario`, `nombre_canal`}
- Claves Foráneas: 
    - El atributo `nombre_usuario` es clave foránea y referencia al atributo `nombre_usuario` del esquema de relación `Usuarios`.
    - El atributo `nombre_canal` es clave foránea y referencia al atributo `nombre` del esquema de relación `Canales`.

#### Visualiza

- Claves Candidatas: {{`nombre_usuario`, `enlace_video`}}
- Clave Primaria: {`nombre_usuario`, `enlace_video`}
- Claves Foráneas: 
    - El atributo `nombre_usuario` es clave foránea y referencia al atributo `nombre_usuario` del esquema de relación `Usuarios`.
    - El atributo `enlace_video` es clave foránea y referencia al atributo `enlace` del esquema de relación `Videos`.
