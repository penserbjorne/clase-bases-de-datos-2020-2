--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  24/06/2020
--@Descripción:     Script para creación de usuarios

--
PROMPT ### Conectando como sysdba ###
CONNECT sys as sysdba

--
PROMPT ### Eliminando usuarios ###
DROP USER ap_proy_invitado CASCADE;
DROP USER ap_proy_admin CASCADE;

--
PROMPT ### Eliminando roles ###
DROP ROLE rol_invitado;
DROP ROLE rol_admin;

--
PROMPT ### Creando rol admin ###
CREATE ROLE rol_admin;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SYNONYM,
  CREATE SEQUENCE, CREATE TRIGGER, CREATE PROCEDURE TO rol_admin;

CREATE OR REPLACE DIRECTORY tmp_dir AS './tmp';
GRANT READ, WRITE ON DIRECTORY tmp_dir TO rol_admin;

--
PROMPT ### Creando rol invitado ###
CREATE ROLE rol_invitado;
GRANT CREATE SESSION, CREATE SYNONYM TO rol_invitado;

--
PROMPT ### Creando usuario ap_proy_admin ###
CREATE USER ap_proy_admin IDENTIFIED BY admin QUOTA UNLIMITED ON USERS;

--
PROMPT ### Creando usuario ap_proy_invitado ###
CREATE USER ap_proy_invitado IDENTIFIED BY invitado;

--
PROMPT ### Asignando roles ###
GRANT rol_admin TO ap_proy_admin;
GRANT rol_invitado TO ap_proy_invitado;

--
PROMPT ### Listo ###

DISCONNECT
/
