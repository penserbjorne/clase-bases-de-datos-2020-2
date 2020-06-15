--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  12/06/2020
--@Descripción:    Creación de usuarios

PROMPT ### Conectando al usuario SYS
CONNECT sys AS sysdba;

PROMPT ### Creando usuario paap_p1101_subastas
DROP USER paap_p1101_subastas CASCADE;

CREATE USER paap_p1101_subastas IDENTIFIED BY paap QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE, CREATE SYNONYM TO paap_p1101_subastas;

Prompt otorgando permisos a paap_p1101_subastas para leer tablas de paap_p1001_subastas
grant select on paap_p1001_subastas.articulo to paap_p1101_subastas;
grant select on paap_p1001_subastas.articulo_arqueologico to paap_p1101_subastas;
grant select on paap_p1001_subastas.articulo_donado to paap_p1101_subastas;
grant select on paap_p1001_subastas.articulo_famoso to paap_p1101_subastas;
grant select on paap_p1001_subastas.cliente to paap_p1101_subastas;
grant select on paap_p1001_subastas.entidad to paap_p1101_subastas;
grant select on paap_p1001_subastas.factura_cliente to paap_p1101_subastas;
grant select on paap_p1001_subastas.historico_status_articulo to paap_p1101_subastas;
grant select on paap_p1001_subastas.pais to paap_p1101_subastas;
grant select on paap_p1001_subastas.status_articulo to paap_p1101_subastas;
grant select on paap_p1001_subastas.subasta to paap_p1101_subastas;
grant select on paap_p1001_subastas.subasta_venta to paap_p1101_subastas;
grant select on paap_p1001_subastas.tarjeta_cliente to paap_p1101_subastas;

PROMPT ### Conectando al usuario paap_p1101_subastas
CONNECT paap_p1101_subastas/paap;

create or replace synonym articulo for paap_p1001_subastas.articulo;
create or replace synonym articulo_arqueologico for paap_p1001_subastas.articulo_arqueologico;
create or replace synonym articulo_donado for paap_p1001_subastas.articulo_donado;
create or replace synonym articulo_famoso for paap_p1001_subastas.articulo_famoso;
create or replace synonym cliente for paap_p1001_subastas.cliente;
create or replace synonym entidad for paap_p1001_subastas.entidad;
create or replace synonym factura_cliente for paap_p1001_subastas.factura_cliente;
create or replace synonym historico_status_articulo for paap_p1001_subastas.historico_status_articulo;
create or replace synonym pais for paap_p1001_subastas.pais;
create or replace synonym status_articulo for paap_p1001_subastas.status_articulo;
create or replace synonym subasta for paap_p1001_subastas.subasta;
create or replace synonym subasta_venta for paap_p1001_subastas.subasta_venta;
create or replace synonym tarjeta_cliente for paap_p1001_subastas.tarjeta_cliente;
