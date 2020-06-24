--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  24/06/2020
--@Descripción:     Script para creación indices

--
PROMPT ### Conectando a ap_proy_admin ###
CONNECT ap_proy_admin/admin

-- Por si hay error, sabemos que podria marcar, continuamos
WHENEVER SQLERROR CONTINUE

-- Eliminamos indices
PROMPT ### Eliminando indices ###
-- DROP INDEX refugio_codigo_num_registro_iuk;
-- DROP INDEX oficina_rfc_iuk;
-- DROP INDEX empleado_curp_iuk;
-- DROP INDEX grado_titulo_iuk;
-- DROP INDEX cliente_username_iuk;
DROP INDEX centro_operativo_gerente_ix;
DROP INDEX sitio_web_codigo_centro_id_ix;
DROP INDEX empleado_codigo_centro_id_ix;
DROP INDEX grado_empleado_id_ix;
DROP INDEX grado_cedula_ix;
DROP INDEX mascota_codigo_centro_id_ix;
DROP INDEX mascota_tipo_mascota_id_ix;
DROP INDEX mascota_estado_mascota_id_ix;
DROP INDEX historial_mascota_folio_mascota_id_ix;
DROP INDEX historial_mascota_estado_mascota_id_ix;
DROP INDEX origen_mascota_folio_mascota_id_ix;
DROP INDEX origen_mascota_padre_ix;
DROP INDEX origen_mascota_madre_ix;
DROP INDEX adopcion_id_cliente_ix;
DROP INDEX adopcion_folio_mascota_id_ix;
DROP INDEX centro_operativo_ubicacion_ix;
DROP INDEX tipo_mascota_tipo_subtipo_ix;
--DROP INDEX revision_folio_mascota_num_revision_ix;
DROP INDEX centro_operativo_nombre_ix;
DROP INDEX empleado_nombre_ix;
DROP INDEX empleado_apellido_pat_ix;
DROP INDEX empleado_apellido_mat_ix;
DROP INDEX empleado_email_ix;
DROP INDEX estado_mascota_descripcion_ix;
DROP INDEX mascota_nombre_ix;
DROP INDEX cliente_nombre_ix;
DROP INDEX cliente_apellido_pat_ix;
DROP INDEX cliente_apellido_mat_ix;

-- Por si hay error
WHENEVER SQLERROR EXIT

PROMPT ### Creando indices ###

-- Uso de índices Unique empleados para verificar duplicidad de valores
  -- Los indices de tipo UNIQUE los crea el manejador al añadir el CONSTRAINT
  --  UNIQUE en la definción de las tablas, por lo cual no se construye ningúno
  --  aquí, referencia: https://www.oratable.com/unique-constraint-vs-unique-index/

  -- A continuación se deja la creación de los indices correspondientes
-- CREATE INDEX refugio_codigo_num_registro_iuk ON refugio(num_registro);
-- CREATE INDEX oficina_rfc_iuk ON refugio(rfc);
-- CREATE INDEX empleado_curp_iuk ON empleado(curp);
-- CREATE INDEX grado_titulo_iuk ON grado(titulo);
-- CREATE INDEX cliente_username_iuk ON cliente(username);

-- Uso de índices Non Unique para mejorar el desempeño de las consultas,
-- por ejemplo, identificar posibles campos que son empleados frecuentemente en
-- búsquedas (claves, números de cuenta, rfc, curp, email, etc).
-- Considerar de forma adicional, indexar llaves foráneas que participan en
-- operaciones JOIN frecuentes
CREATE INDEX centro_operativo_gerente_ix ON centro_operativo(gerente);
CREATE INDEX sitio_web_codigo_centro_id_ix ON sitio_web(codigo_centro_id);
CREATE INDEX empleado_codigo_centro_id_ix ON empleado(codigo_centro_id);
CREATE INDEX grado_empleado_id_ix ON grado(empleado_id);
CREATE INDEX grado_cedula_ix ON grado(cedula);
CREATE INDEX mascota_codigo_centro_id_ix ON mascota(codigo_centro_id);
CREATE INDEX mascota_tipo_mascota_id_ix ON mascota(tipo_mascota_id);
CREATE INDEX mascota_estado_mascota_id_ix ON mascota(estado_mascota_id);
CREATE INDEX historial_mascota_folio_mascota_id_ix ON historial_mascota(folio_mascota_id);
CREATE INDEX historial_mascota_estado_mascota_id_ix ON historial_mascota(estado_mascota_id);
CREATE INDEX origen_mascota_folio_mascota_id_ix ON origen_mascota(folio_mascota_id);
CREATE INDEX origen_mascota_padre_ix ON origen_mascota(mascota_padre_id);
CREATE INDEX origen_mascota_madre_ix ON origen_mascota(mascota_madre_id);
CREATE INDEX adopcion_id_cliente_ix ON adopcion(id_cliente);
CREATE INDEX adopcion_folio_mascota_id_ix ON adopcion(folio_mascota_id);

-- Uso de un índice compuestos tipo Unique, empleados para validar duplicidad de
-- combinaciones de valores de las columnas involucradas en el índice.
CREATE INDEX centro_operativo_ubicacion_ix ON centro_operativo(latitud, longitud);
CREATE INDEX tipo_mascota_tipo_subtipo_ix ON tipo_mascota(nombre, subcategoria);
--CREATE INDEX revision_folio_mascota_num_revision_ix ON revision(folio_mascota_id, num_revision);

-- Uso de uno o más índices basados en el uso de funciones. Por ejemplo, definir
-- un índice con la función lower o upper que permita agilizar las búsquedas sin
-- importar si los datos se encuentran capturados en minúsculas o mayúsculas.
CREATE INDEX centro_operativo_nombre_ix ON centro_operativo(UPPER(nombre));
CREATE INDEX empleado_nombre_ix ON empleado(UPPER(nombre));
CREATE INDEX empleado_apellido_pat_ix ON empleado(UPPER(apellido_pat));
CREATE INDEX empleado_apellido_mat_ix ON empleado(UPPER(apellido_mat));
CREATE INDEX empleado_email_ix ON empleado(LOWER(email));
CREATE INDEX estado_mascota_descripcion_ix ON estado_mascota(UPPER(descripcion));
CREATE INDEX mascota_nombre_ix ON mascota(UPPER(nombre));
CREATE INDEX cliente_nombre_ix ON cliente(UPPER(nombre));
CREATE INDEX cliente_apellido_pat_ix ON cliente(UPPER(apellido_pat));
CREATE INDEX cliente_apellido_mat_ix ON cliente(UPPER(apellido_mat));

--
PROMPT ### Listo s-06-indices.sql ###

DISCONNECT
/
