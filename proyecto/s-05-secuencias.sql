--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  24/06/2020
--@Descripción:     Script para creación las secuencias

--
PROMPT ### Conectando a ap_proy_admin ###
CONNECT ap_proy_admin/admin

-- Por si hay error, sabemos que podria marcar, continuamos
WHENEVER SQLERROR CONTINUE

-- Su llave primaria es ALFANUMERICA
  -- centro_operativo
  -- mascota

-- Su llave primaria es tipo IDENTITY
  -- sitio_web
  -- grado
  -- tipo_mascota
  -- estado_mascota

-- Eliminamos secuenciass
PROMPT ### Eliminando secuencias ###
DROP SEQUENCE seq_empleado;
DROP SEQUENCE seq_historial_mascota;
DROP SEQUENCE seq_origen_mascota;
DROP SEQUENCE seq_cliente;
DROP SEQUENCE seq_adopcion;
DROP SEQUENCE seq_num_revision;

-- Por si hay error
WHENEVER SQLERROR EXIT

PROMPT ### Creando secuencias ###

PROMPT ### Crendo secuencia seq_empleado ###
CREATE SEQUENCE seq_empleado
  START WITH 1
  INCREMENT BY 1
  NOCYCLE
  ORDER
;

PROMPT ### Crendo secuencia seq_historial_mascota ###
CREATE SEQUENCE seq_historial_mascota
  START WITH 1
  INCREMENT BY 1
  NOCYCLE
  ORDER
;

PROMPT ### Crendo secuencia seq_origen_mascota ###
CREATE SEQUENCE seq_origen_mascota
  START WITH 1
  INCREMENT BY 1
  NOCYCLE
  ORDER
;

PROMPT ### Crendo secuencia seq_cliente ###
CREATE SEQUENCE seq_cliente
  START WITH 1
  INCREMENT BY 1
  NOCYCLE
  ORDER
;

PROMPT ### Crendo secuencia seq_adopcion ###
CREATE SEQUENCE seq_adopcion
  START WITH 1
  INCREMENT BY 1
  NOCYCLE
  ORDER
;

PROMPT ### Crendo secuencia seq_num_revision ###
CREATE SEQUENCE seq_num_revision
  START WITH 1
  INCREMENT BY 1
  NOCYCLE
  ORDER
;

--
PROMPT ### Listo s-05-secuencias.sql ###

DISCONNECT
/
