--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  24/06/2020
--@Descripción:     Script para creación de tablas temporales

--
PROMPT ### Conectando a ap_proy_admin ###
CONNECT ap_proy_admin/admin

-- Por si hay error, sabemos que podria marcar, continuamos
WHENEVER SQLERROR CONTINUE

-- Eliminamos la tabla por si existe
PROMPT ### Eliminando tabla mascotas_en_adopcion ###
-- Si esta en uso, hay que "detenerla"
TRUNCATE TABLE mascotas_en_adopcion DROP STORAGE;
-- Eliminamos
DROP TABLE mascotas_en_adopcion;

-- Por si hay error
WHENEVER SQLERROR EXIT

-- Hemos decidido crear una tabla para las mascotas disponibles en adopcion
-- junto a sus datos de tipo de animal y de su ultima revision
-- estamos asumiendo que la mascota al estar en adopcion se encuentra en un
-- refugio

PROMPT ### Creando tabla temporal mascotas_en_adopcion ###
CREATE GLOBAL TEMPORARY TABLE mascotas_en_adopcion (
  -- Datos de la mascota
  folio_mascota_id     VARCHAR2(8)      NOT NULL,
  nombre               VARCHAR2(50)     NOT NULL,
  fecha_nacimiento     DATE             NOT NULL,
  -- Datos del tipo de mascota
  nombre_tipo          VARCHAR2(50)     NOT NULL,
  subcategoria_tipo    VARCHAR2(50)     NOT NULL,
  cuidados             NUMBER(1, 0)     NOT NULL,
  -- Datos de ultima revision
  fecha_revision       DATE             DEFAULT  SYSDATE,
  diagnostico          VARCHAR2(500)    NOT NULL,
  foto                 BLOB
) ON COMMIT PRESERVE ROWS;

--
PROMPT ### Listo s-03-tablas-temporales.sql ###

DISCONNECT
/
