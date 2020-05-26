--@Autor: Jorge Rodriguez Campos, Paul Aguilar
--@Fecha creación: 06/05/2020
--@Descripción: Creación de Usuarios
create user psae_p07_previo identified by paul quota unlimited on users;
grant create table, create session, create procedure, create sequence to psae_p07_previo;
