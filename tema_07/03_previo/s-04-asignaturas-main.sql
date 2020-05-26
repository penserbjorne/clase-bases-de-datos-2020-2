--@Autor: Jorge Rodriguez Campos
--@Fecha creación: dd/mm/yyyy
--@Descripción: Archivo principal
whenever sqlerror exit rollback;

prompt conectando como sys para eliminar/crear al usuario
connect sys as sysdba

prompt eliminando al usuario psae_p07_previo en caso de existir
start s-00-asignaturas-elimina-usuario.sql

prompt creando usuario pase_p07_previo
start s-01-asignaturas-crea-usuario.sql

prompt conectando como usuario psae_p07_previo
connect psae_p07_previo/paul

prompt creando tablas
satar s-02-asignaturas-ddl.sql

prompt cargando datos
start s-03-asignaturas-carga-inicial.sql

prompt Listo!
