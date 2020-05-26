--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  23/05/2020
--@Descripción:     Creación de usuarios

DROP USER agui_p0802_cuentas CASCADE;

CREATE USER agui_p0802_cuentas IDENTIFIED BY aguilar QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE TO agui_p0802_cuentas;