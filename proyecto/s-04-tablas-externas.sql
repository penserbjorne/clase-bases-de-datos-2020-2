--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  24/06/2020
--@Descripción:     Script para creación de tablas externas

--
PROMPT ### Conectando a ap_proy_admin ###
CONNECT ap_proy_admin/admin

-- Por si hay error, sabemos que podria marcar, continuamos
WHENEVER SQLERROR CONTINUE

-- Eliminamos la tabla por si existe
PROMPT ### Eliminando tabla mascotas_atencion_dia ###
DROP TABLE mascotas_atencion_dia;

-- Por si hay error
WHENEVER SQLERROR EXIT

-- Hemos decidido crear una tabla para las mascotas enfermas que requiere
-- atención para ese día

-- Creando la tabla externa
PROMPT ### Creando tabla temporal mascotas_atencion_dia ###
CREATE TABLE mascotas_atencion_dia (
  -- Datos de la mascota
  folio_mascota_id     VARCHAR2(8),
  nombre               VARCHAR2(50),
  fecha_nacimiento     DATE,
  -- Datos del tipo de mascota
  nombre_tipo          VARCHAR2(50),
  subcategoria_tipo    VARCHAR2(50),
  cuidados             NUMBER(1, 0),
  -- Datos de ultima revision
  fecha_revision       DATE,
  diagnostico          VARCHAR2(500)
)
ORGANIZATION EXTERNAL (
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY tmp_dir
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    BADFILE tmp_dir:'mascotas_atencion_dia_bad.log'
    LOGFILE tmp_dir:'mascotas_atencion_dia.log'
    FIELDS TERMINATED BY ','
    LRTRIM
    MISSING FIELD VALUES ARE NULL
    (
      folio_mascota_id, nombre, fecha_nacimiento DATE MASK "dd/mm/yyyy",
      nombre_tipo, subcategoria_tipo, cuidados,
      fecha_revision DATE MASK "dd/mm/yyyy", diagnostico
    )
  )
  LOCATION (tmp_dir:'mascotas_atencion_dia.csv')
) REJECT LIMIT UNLIMITED
;

-- Creando la carpeta temporal
PROMPT ## Creando el directorio temporal '/tmp/bd'
!mkdir -p /tmp/bd
!chmod 777 /tmp/bd

-- Copiando archivo .csv a directorio temporal
PROMPT ## Copiando archivo .CSV al directorio temporal '/tmp/bd'
!cp mascotas_atencion_dia.csv /tmp/bd

-- Probando los datos
SET LINESIZE 160;
COL folio_mascota_id HEADING "ID" FORMAT A8;
COL nombre FORMAT A20;
COL nombre_tipo HEADING "ESPECIE" FORMAT A20;
COL subcategoria_tipo HEADING "SUB ESPECIE" FORMAT A20;
COL cuidados FORMAT 9;
COL diagnostico FORMAT A25;

SELECT * FROM mascotas_atencion_dia;

--
PROMPT ### Listo s-04-tablas-externas.sql ###

DISCONNECT:
/
