--@Autor:               Paul Aguilar
--@Fecha de creación:   06/05/2020
--@Descripción:         Creación de roles y usuarios

-- Por si hay error
WHENEVER SQLERROR EXIT

-- Definimos constantes
DEFINE role_admin = 'P0701_ADMIN_ROL'
DEFINE role_basic = 'P0701_BASIC_ROL'
DEFINE role_guest = 'P0701_GUEST_ROL'
DEFINE usr_admin = 'PSAE_P0701_ADMIN'
DEFINE usr_basic = 'PSAE_P0701_OPER'
DEFINE usr_guest = 'PSAE_P0701_INVITADO'

-- Limpiamos variables
UNDEFINE pwd_admin
UNDEFINE pwd_oper
UNDEFINE pwd_guest

--
PROMPT ### Conectando como SYS para tareas administrativas ###
CONNECT sys AS sysdba

-- Eliminamos roles y usuarios si es que existen
PROMPT ### Limpiando roles ###
SET SERVEROUTPUT ON
DECLARE
  v_del BOOLEAN := FALSE;
  FUNCTION v_drop_role (v_rol IN VARCHAR) RETURN BOOLEAN IS
    v_count NUMBER(1,0) := 0;
  BEGIN
    SELECT COUNT(*) INTO v_count
    FROM DBA_ROLES
    WHERE ROLE = v_rol;
    IF v_count > 0 THEN
      EXECUTE IMMEDIATE 'DROP ROLE ' ||  v_rol;
      DBMS_OUTPUT.PUT_LINE('### Rol ' || v_rol || ' eliminado ###');
      RETURN TRUE;
    END IF;
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('### No se pudo eliminar el rol' || v_rol || ' ###');
      DBMS_OUTPUT.PUT_LINE('### Error message was: ' || SQLERRM);
      RETURN FALSE;
  END;
BEGIN
  v_del := v_drop_role('&role_admin');
  v_del := v_drop_role('&role_basic');
  v_del := v_drop_role('&role_guest');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('### Error message was: ' || SQLERRM);
END;
/

PROMPT ### Limpiando usuarios ###
SET SERVEROUTPUT ON
DECLARE
  v_del BOOLEAN := FALSE;
  FUNCTION v_drop_user (v_usr IN VARCHAR) RETURN BOOLEAN IS
    v_count NUMBER(1,0) := 0;
  BEGIN
    SELECT COUNT(*) INTO v_count
    FROM DBA_USERS
    WHERE USERNAME = v_usr;
    IF v_count > 0 THEN
      EXECUTE IMMEDIATE 'DROP USER ' || v_usr || ' CASCADE';
      DBMS_OUTPUT.PUT_LINE('### Usuario ' || v_usr || ' eliminado ###');
      RETURN TRUE;
    END IF;
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('### No se pudo eliminar el usuario ' || v_usr || ' ###');
      DBMS_OUTPUT.PUT_LINE('### Error message was: ' || SQLERRM);
      RETURN FALSE;
  END;
BEGIN
  v_del := v_drop_user('&usr_admin');
  v_del := v_drop_user('&usr_basic');
  v_del := v_drop_user('&usr_guest');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('### Error message was: ' || SQLERRM);
END;
/


--
PROMPT ### Creando roles ###

PROMPT ### Creando rol &role_admin ###
CREATE ROLE &role_admin;
GRANT create table, create session, create view TO &role_admin;
PROMPT ### Rol &role_admin creado ###

PROMPT ### Creando rol &role_basic ###
CREATE ROLE &role_basic;
GRANT create table, create session TO &role_basic;
PROMPT ### Rol &role_basic creado ###

PROMPT ### Creando rol &role_guest ###
CREATE ROLE &role_guest;
GRANT create session, create synonym TO &role_guest;
PROMPT ### Rol &role_guest creado ###

PROMPT ### Roles creados ###

--
PROMPT ### Creando usuarios ###

PROMPT ### Creando usuario &usr_admin ###
PROMPT ### Proporcione el password para el usuario &usr_admin ###
CREATE USER &usr_admin IDENTIFIED BY &&pwd_admin QUOTA 1024M ON users;
GRANT &role_admin TO &usr_admin;
GRANT create procedure, create sequence TO &usr_admin;
PROMPT ### Usuario &usr_admin creado ###

PROMPT ### Creando usuario &usr_basic ###
PROMPT ### Proporcione el password para el usuario &usr_basic ###
CREATE USER &usr_basic IDENTIFIED BY &&pwd_oper QUOTA 500M ON users;
GRANT &role_basic TO &usr_basic;
GRANT create procedure, create sequence TO &usr_basic;
PROMPT ### Usuario &usr_basic creado ###

PROMPT ### Creando usuario &usr_guest ###
PROMPT ### Proporcione el password para el usuario &usr_guest ###
CREATE USER &usr_guest IDENTIFIED BY &&pwd_guest;
GRANT &role_guest TO &usr_guest;
GRANT create procedure, create sequence TO &usr_guest;
PROMPT ### Usuario &usr_guest creado ###

PROMPT ### Usuarios creados ###

-- Limpiamos entorno
PROMPT ### Limpiando entorno ###
UNDEFINE role_admin
UNDEFINE role_basic
UNDEFINE role_guest
UNDEFINE usr_admin
UNDEFINE usr_basic
UNDEFINE usr_guest
UNDEFINE pwd_admin
UNDEFINE pwd_oper
UNDEFINE pwd_guest

--
PROMPT ### s-01-usuarios.sql termino con exito ###
disconnect;
