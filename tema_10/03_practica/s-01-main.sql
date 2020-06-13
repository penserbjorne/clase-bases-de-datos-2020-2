--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  12/06/2020
--@Descripción:    Creación de usuarios

PROMPT ### Conectando al usuario SYS
CONNECT sys AS sysdba;

PROMPT ### Creando usuario paap_p1001_subastas
DROP USER paap_p1001_subastas CASCADE;

CREATE USER paap_p1001_subastas IDENTIFIED BY paap QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE TO paap_p1001_subastas;

PROMPT ### Conectando al usuario paap_p1001_subastas
CONNECT paap_p1001_subastas/paap;

PROMPT ### Ejecutando s-02-ddl.sql
@@s-02-ddl.sql

PROMPT ### Ejecutando s-03-carga-inicial.sql
@@s-03-carga-inicial.sql

--COMMIT;
