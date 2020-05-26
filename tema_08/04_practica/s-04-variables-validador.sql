--@Autor:           Jorge Rodriguez
--@Fecha creación:  dd/mm/yyyy
--@Descripción:     Practica 8 - Variables empleadas por el validador.

--Modificar las siguientes variables en caso de ser necesario.
--En scripts reales no debeń incluirse passwords. Solo se hace para
--propósitos de pruebas y evitar escribirlos cada vez que se quiera ejecutar 
--el proceso de validación de la práctica (propósitos académicos).

--
-- Nombre del usuario empleado en esta práctica
--
define p_usuario='agui_p0802_cuentas'

--
-- Password del usuario empleado en esta práctica
--
define p_usuario_pass='aguilar'


--- ============= Las siguientes configuraciones ya no requieren cambiarse====

whenever sqlerror exit rollback
set verify off
set feedback off

Prompt =========================================================
Prompt Iniciando validador - Práctica 8
Prompt Presionar Enter si los valores configurados son correctos.
Prompt De lo contario editar el script s-04-variables-validador.sql
Prompt O en su defecto proporcionar nuevos valores
Prompt =========================================================

Prompt Datos de Entrada:
accept p_usuario default '&&p_usuario' prompt '1. Proporcionar el nombre de usuario [&&p_usuario]: '
accept p_usuario_pass default '&&p_usuario_pass' prompt '2. Proporcionar password del usuario &&p_usuario [Configurado en script]: '
