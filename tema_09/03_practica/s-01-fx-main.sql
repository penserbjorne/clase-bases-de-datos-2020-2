--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  26/05/2020
--@Descripción:    Creación de usuarios

PROMPT ### Conectando al usuario SYS
CONNECT sys AS sysdba;

PROMPT ### Creando usuario paap_p0903_fx
DROP USER paap_p0903_fx CASCADE;

CREATE USER paap_p0903_fx IDENTIFIED BY paap QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE TO paap_p0903_fx;

PROMPT ### Conectando al usuario paap_p0903_fx
CONNECT paap_p0903_fx/paap;

PROMPT ### Ejecutando s-02-fx-ddl.sql
@@s-02-fx-ddl.sql

PROMPT ### Ejecutando @@s-03-fx-carga-inicial.sql
set define off
@@s-03-fx-carga-inicial.sql
set define on

COMMIT;