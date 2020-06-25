--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  24/06/2020
--@Descripción:     Script para creación de sinonimos

--
PROMPT ### Conectando a ap_proy_admin ###
CONNECT ap_proy_admin/admin

-- Por si hay error
WHENEVER SQLERROR EXIT

-- Generar 3 o más sinónimos públicos que le pertenezcan al usuario admin.
  -- Los sinónimos deberán estar disponibles para que otros usuarios puedan
  -- emplearlos, por ejemplo, el usuario invitado.
PROMPT ### Creando sinonimos publicos del admin ###
CREATE OR REPLACE PUBLIC SYNONYM co FOR centro_operativo;
CREATE OR REPLACE PUBLIC SYNONYM r FOR refugio;
CREATE OR REPLACE PUBLIC SYNONYM c FOR clinica;
CREATE OR REPLACE PUBLIC SYNONYM o FOR oficina;
CREATE OR REPLACE PUBLIC SYNONYM m FOR mascota;
CREATE OR REPLACE PUBLIC SYNONYM hm FOR historial_mascota;


-- Generar las instrucciones necesarias para que el usuario admin otorgue
  -- permisos de lectura al usuario invitado en al menos 3 entidades.
PROMPT ### Otorgando permisos de lectura al invitado ###
GRANT SELECT ON co TO ap_proy_invitado;
GRANT SELECT ON r TO ap_proy_invitado;
GRANT SELECT ON c TO ap_proy_invitado;
GRANT SELECT ON o TO ap_proy_invitado;
GRANT SELECT ON m TO ap_proy_invitado;
GRANT SELECT ON hm TO ap_proy_invitado;

-- Generar 3 o más sinónimos que le pertenezcan al usuario invitado. Dichos
  -- sinónimos deberán ser empleados para leer el contenido de las tablas a
  -- las que el usuario admin le otorgó permisos de lectura.
PROMPT ### Conectando a ap_proy_invitado ###
CONNECT ap_proy_invitado/invitado

PROMPT ### Creando sinonimos de lectura para el invitado ###
CREATE OR REPLACE SYNONYM centro_operativo FOR ap_proy_admin.centro_operativo;
CREATE OR REPLACE SYNONYM refugio FOR ap_proy_admin.refugio;
CREATE OR REPLACE SYNONYM clinica FOR ap_proy_admin.clinica;
CREATE OR REPLACE SYNONYM oficina FOR ap_proy_admin.oficina;
CREATE OR REPLACE SYNONYM mascota FOR ap_proy_admin.mascota;
CREATE OR REPLACE SYNONYM historial_mascota FOR ap_proy_admin.historial_mascota;

-- Finalmente, suponer que un software necesita que todas las tablas del
  -- proyecto tengan un prefijo formado por 2 caracteres:
  -- XX_<nombre_tabla>. Para implementar este requerimiento se creará un
  -- sinónimo privado para cada tabla. Se recomienda realizar un programa
  -- anónimo PL/SQL empleando SQL dinámico para evitar escribir manualmente los
  -- sinónimos.
PROMPT ### Conectando a ap_proy_admin ###
CONNECT ap_proy_admin/admin

PROMPT ### Creando sinonimos tipo xx_<nombre_tabla> ###

SET SERVEROUTPUT ON

DECLARE

  v_codigo number;
  v_mensaje varchar2(1000);

  CURSOR my_tables IS
    SELECT TABLE_NAME
      FROM user_tables;

BEGIN

  FOR my_table IN my_tables LOOP
    EXECUTE IMMEDIATE
      'CREATE OR REPLACE SYNONYM '
      || 'ap_'
      || my_table.TABLE_NAME
      || ' FOR '
      || my_table.TABLE_NAME;
  END LOOP;

EXCEPTION

	WHEN OTHERS THEN
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);

END;
/

SHOW ERRORS

--
--PROMPT ### Mostrando sinonimos ###
--COL table_name FORMAT A30;
--COL synonym_name FORMAT A30;
--SELECT table_name, synonym_name FROM user_synonyms;

--
PROMPT ### Listo s-07-sinonimos.sql ###

DISCONNECT
/
