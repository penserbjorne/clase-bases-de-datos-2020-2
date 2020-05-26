--@Autor:               Paul Aguilar
--@Fecha de creación:   16/05/2020
--@Descripción:         Crear sinonimo para el usuario invitado de la tabla estudiante

-- Por si hay error
WHENEVER SQLERROR EXIT

-- Definimos constantes
DEFINE usr_admin = 'PSAE_P0701_ADMIN'
DEFINE usr_guest = 'PSAE_P0701_INVITADO'

-- Limpiamos variables
UNDEFINE pwd_admin
UNDEFINE pwd_guest

-- Asignando permisos paa crear sinonimos
PROMPT ### Conectando como sysdba ###
PROMPT ### Ingrese el password de SYS ###
CONNECT sys AS sysdba
GRANT CREATE SYNONYM TO &usr_guest;
PROMPT ### Se le asignaron permisos para crear sinonimos al usuario &usr_guest ###

-- Asignando permisos para lectura de la tabla estudiante
PROMPT ### Conectando como &usr_admin ###
PROMPT ### Ingrese el password de &usr_admin ###
CONNECT &usr_admin/&&pwd_admin
GRANT SELECT ON ESTUDIANTE TO &usr_guest;
PROMTP ### Se le asignaron permisos de lectura al usuario &usr_guest ###

-- Conectando para crear el sinonimo
PROMPT ### Conectando como &usr_guest ###
PROMPT ### Ingrese el password de &usr_guest ###
CONNECT &usr_guest/&&pwd_guest

-- Creamos el sinonimo
PROMPT ### Creando sinonimo ###
PROMPT ### Creando sinonimo S_ALUMNO ###
CREATE OR REPLACE SYNONYM S_ALUMNO FOR &usr_admin..ESTUDIANTE;
PROMPT ### Sinonimo S_ALUMNO creado ###

-- Limpiamos entorno
PROMPT ### Limpiando entorno ###
UNDEFINE usr_admin
UNDEFINE pwd_admin
UNDEFINE usr_guest
UNDEFINE pwd_guest

--
PROMPT ### s-03-crea-sinonimo.sql termino con exito ###
disconnect;
