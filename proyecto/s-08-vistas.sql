--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  24/06/2020
--@Descripción:     Script para creación de vistas

--
PROMPT ### Conectando a ap_proy_admin ###
CONNECT ap_proy_admin/admin

-- Por si hay error
WHENEVER SQLERROR EXIT

-- Realizar un análisis y crear 3 o más vistas. Analizar posibles escenarios
-- donde una vista podría ser adecuada.
-- Posibles escenarios:
  -- Generar una vista para ocultar la complejidad de la consulta en la que se
  -- involucran varias tablas: joins, funciones de agregación, etc.
  -- Generar una vista para proteger el acceso a columnas consideradas como
  -- ‘delicadas’: contraseñas, números de tarjeta, etc. En este escenario, el
  -- usuario admin puede otorgar permisos al usuario invitado para que pueda
  -- leer el contenido de una vista que no contiene columnas privadas.

--
PROMPT ### Creando vistas ###

--
PROMPT ### Creando vista para refugio ###
CREATE OR REPLACE VIEW v_refugio (
  centro_id, centro_nombre, gerente_nombre, gerente_ap_pat, gerente_ap_mat,
  num_registro, capacidad_max, direccion, latitud, longitud
) AS
  SELECT co.codigo_centro_id, co.nombre, e.nombre, e.apellido_pat, e.apellido_mat,
    r.num_registro, r.capacidad_max, co.direccion, co.latitud, co.longitud
  FROM centro_operativo co
  JOIN refugio r
    ON  co.codigo_centro_id = r.codigo_centro_id
  JOIN empleado e
    ON co.gerente = e.empleado_id
  WHERE co.es_refugio = 1
    AND e.es_gerente = 1
;

--
PROMPT ### Creando vista para clinica ###
CREATE OR REPLACE VIEW v_clinica (
  centro_id, centro_nombre, gerente_nombre, gerente_ap_pat, gerente_ap_mat,
  hora_inicio, hora_fin, tel_clientes, tel_emergencias, direccion, latitud,
  longitud
) AS
  SELECT co.codigo_centro_id, co.nombre, e.nombre, e.apellido_pat, e.apellido_mat,
    c.hora_inicio, c.hora_fin, c.tel_clientes, c.tel_emergencias, co.direccion,
    co.latitud, co.longitud
  FROM centro_operativo co
  JOIN clinica c
    ON  co.codigo_centro_id = c.codigo_centro_id
  JOIN empleado e
    ON co.gerente = e.empleado_id
  WHERE co.es_clinica = 1
    AND e.es_gerente = 1
;

--
PROMPT ### Creando vista para oficina ###
CREATE OR REPLACE VIEW v_oficina (
  centro_id, centro_nombre, gerente_nombre, gerente_ap_pat, gerente_ap_mat,
  centro_rfc, representante_legal, direccion, latitud, longitud
) AS
  SELECT co.codigo_centro_id, co.nombre, e.nombre, e.apellido_pat, e.apellido_mat,
    o.rfc, o.representante_legal, co.direccion, co.latitud, co.longitud
  FROM centro_operativo co
  JOIN oficina o
    ON  co.codigo_centro_id = o.codigo_centro_id
  JOIN empleado e
    ON co.gerente = e.empleado_id
  WHERE co.es_oficina = 1
    AND e.es_gerente = 1
;

--
PROMPT ### Creando vista para sitios web ###
CREATE OR REPLACE VIEW v_sitios_web (
  centro_id, centro_nombre, gerente_nombre, gerente_ap_pat, gerente_ap_mat,
  sitio_web
) AS
  SELECT co.codigo_centro_id, co.nombre, e.nombre, e.apellido_pat, e.apellido_mat,
    sw.url
  FROM centro_operativo co
  JOIN refugio r
    ON  co.codigo_centro_id = r.codigo_centro_id
  JOIN sitio_web sw
    ON r.codigo_centro_id = sw.codigo_centro_id
  JOIN empleado e
    ON co.gerente = e.empleado_id
  WHERE co.es_refugio = 1
    AND e.es_gerente = 1
;

--
PROMPT ### Creando vista para mascotas ###
CREATE OR REPLACE VIEW v_mascotas (
  mascota_id, nombre, fecha_ingreso, fecha_nacimiento, tipo, subtipo, cuidados,
  estado_actual, origen
) AS
  SELECT m.folio_mascota_id, m.nombre, m.fecha_ingreso, m.fecha_nacimiento,
    tm.nombre, tm.subcategoria, tm.cuidados, em.descripcion,
    om.tipo_origen
  FROM mascota m
  JOIN tipo_mascota tm
    ON m.tipo_mascota_id = tm.tipo_mascota_id
  JOIN estado_mascota em
    ON m.estado_mascota_id = em.estado_mascota_id
  JOIN origen_mascota om
    ON m.folio_mascota_id = om.folio_mascota_id
;

--
PROMPT ### Creando vista para mascotas ###
CREATE OR REPLACE VIEW v_revisiones (
  mascota_id, num_revision, mascota_nombre, fecha_ingreso, fecha_nacimiento,
  mascota_estado, fecha_revision, centro_nombre, es_clinica, clinica_calificacion,
  clinica_costo, clinica_observaciones, es_refugio, refugio_diagnostico
) AS
  SELECT r.folio_mascota_id, r.num_revision, m.nombre, m.fecha_ingreso,
    m.fecha_nacimiento, em.descripcion, r.fecha, co.nombre,
    co.es_clinica, rc.calificacion, rc.costo, rc.observaciones,
    co.es_refugio, rr.diagnostico
  FROM revision r
  JOIN mascota m
    ON r.folio_mascota_id = m.folio_mascota_id
  JOIN estado_mascota em
    ON m.estado_mascota_id = em.estado_mascota_id
  JOIN centro_operativo co
    ON r.codigo_centro_id = co.codigo_centro_id
  JOIN revision_clinica rc
    ON r.folio_mascota_id = rc.folio_mascota_id
  JOIN revision_refugio rr
    ON r.folio_mascota_id = rr.folio_mascota_id
;

--
--SET LINESIZE 80;
--PROMPT ### Probando vistas ###
--PROMPT ### Vista v_refugio ###
--DESCRIBE v_refugio;
--PROMPT ### Vista v_clinica ###
--DESCRIBE v_clinica;
--PROMPT ### Vista v_oficina ###
--DESCRIBE v_oficina;
--PROMPT ### Vista v_sitios_web ###
--DESCRIBE v_sitios_web;
--PROMPT ### Vista v_mascotas ###
--DESCRIBE v_mascotas;
--PROMPT ### Vista v_revisiones ###
--DESCRIBE v_revisiones;

--
PROMPT ### Listo s-08-vistas.sql ###

DISCONNECT
/
