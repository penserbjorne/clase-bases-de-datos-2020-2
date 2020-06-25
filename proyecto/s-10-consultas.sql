--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  24/06/2020
--@Descripción:     Consultas

--
PROMPT ### Conectando a ap_proy_admin ###
CONNECT ap_proy_admin/admin

--
SET LINESIZE 170;

--
PROMPT ### Consulta a tabla temporal ###
INSERT INTO mascotas_en_adopcion(
  folio_mascota_id, nombre, fecha_nacimiento, nombre_tipo, subcategoria_tipo,
  cuidados, fecha_revision, diagnostico, foto
)
  SELECT m.folio_mascota_id, m.nombre, m.fecha_nacimiento, tm.nombre,
    tm.subcategoria, tm.cuidados, r.fecha, rr.diagnostico, rr.foto
  FROM mascota m
  JOIN tipo_mascota tm
    ON m.tipo_mascota_id = tm.tipo_mascota_id
  JOIN revision r
    ON m.folio_mascota_id = r.folio_mascota_id
  JOIN revision_refugio rr
    ON r.folio_mascota_id = rr.folio_mascota_id
  WHERE m.estado_mascota_id = 2
;

COL nombre FORMAT A15;
COL nombre_tipo FORMAT A15;
COL subcategoria_tipo FORMAT A20;
COL diagnostico FORMAT A30;
SELECT * FROM mascotas_en_adopcion;

--
PROMPT ### Consulta a tabla externa ###
COL folio_mascota_id HEADING "ID" FORMAT A8;
COL nombre FORMAT A20;
COL nombre_tipo HEADING "ESPECIE" FORMAT A20;
COL subcategoria_tipo HEADING "SUB ESPECIE" FORMAT A20;
COL cuidados FORMAT 9;
COL diagnostico FORMAT A25;
SELECT * FROM mascotas_atencion_dia;

PROMPT ### Consulta a vistas ###
COL centro_nombre FORMAT A10;
COL gerente_nombre FORMAT A10;
COL gerente_ap_pat FORMAT A10;
COL gerente_ap_mat FORMAT A10;
COL mascota_nombre FORMAT A10;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD';

PROMPT ### Consulta a vistas v_refugio ###
SELECT * FROM v_refugio;
ALTER SESSION SET NLS_DATE_FORMAT='hh24:mi';

PROMPT ### Consulta a vistas v_clinica ###
SELECT * FROM v_clinica;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD';

PROMPT ### Consulta a vistas v_oficina ###
SELECT * FROM v_oficina;

PROMPT ### Consulta a vistas v_sitios_web ###
SELECT * FROM v_sitios_web;

COL tipo FORMAT A10;
COL subtipo FORMAT A20;
PROMPT ### Consulta a vistas v_mascotas ###
SELECT * FROM v_mascotas;

COL clinica_observaciones FORMAT A35;
COL refugio_diagnostico FORMAT A35;
PROMPT ### Consulta a vistas v_revisiones ###
SELECT * FROM v_revisiones;

--
PROMPT ### Conectando a ap_proy_invitado ###
CONNECT ap_proy_invitado/invitado

PROMPT ### Consulta a sinonimos desde invitado ###
--SELECT * FROM mascota;
--SELECT * FROM historial_mascota;
SELECT hm.historial_mascota_id as hist_id, hm.folio_mascota_id as mascota_id,
  m.nombre, hm.fecha, em.descripcion
  FROM mascota m
  JOIN historial_mascota hm
    ON m.folio_mascota_id = hm.folio_mascota_id
  JOIN estado_mascota em
    ON hm.estado_mascota_id = em.estado_mascota_id
  ORDER BY hm.folio_mascota_id, hm.fecha
;

--
PROMPT ### Listo s-10-consultas.sql ###

DISCONNECT
/
