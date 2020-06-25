--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  24/06/2020
--@Descripción:     Script para cargar datos en la base de datos

--
PROMPT ### Conectando a ap_proy_admin ###
CONNECT ap_proy_admin/admin

--
SET LINESIZE 170;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD';
COL empleado_id FORMAT 99;
COL email FORMAT A20;
COL nombre FORMAT A10;
COL apellido_pat FORMAT A10;
COL apellido_mat FORMAT A10;
SELECT * FROM empleado;
SELECT * FROM grado;
COL direccion FORMAT A15;
SELECT * FROM centro_operativo;
COL logo_img FORMAT A25;
COL lema FORMAT A25;
SELECT * FROM refugio;
ALTER SESSION SET NLS_DATE_FORMAT='hh24:mi';
COL hora_inicio FORMAT A15;
COL hora_fin FORMAT A15;
SELECT * FROM clinica;
ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD';
COL representante_legal FORMAT A25;
COL firma_electronica FORMAT A25;
SELECT * FROM oficina;
SELECT * FROM sitio_web;
SELECT * FROM estado_mascota;
COL nombre FORMAT A25;
COL subcategoria FORMAT A25;
SELECT * FROM tipo_mascota;
COL nombre FORMAT A25;
COL causa_muerte FORMAT A25;
SELECT * FROM mascota;
COL nombre_donador FORMAT A25;
SELECT * FROM origen_mascota;
SELECT * FROM historial_mascota;
COL nombre FORMAT A15;
COL apellido_pat FORMAT A15;
COL apellido_mat FORMAT A15;
COL ocupacion FORMAT A15;
COL username FORMAT A5;
COL password FORMAT A5;
SELECT * FROM cliente;
COL razon FORMAT A25;
SELECT * FROM adopcion;
SELECT * FROM historial_mascota;
SELECT * FROM revision;
COL observaciones FORMAT A35;
SELECT * FROM revision_clinica;
COL diagnostico FORMAT A35;
COL foto FORMAT A25;
SELECT * FROM revision_refugio;

--
PROMPT ### Listo s-09-carga-inicial-b.sql ###

DISCONNECT
/
