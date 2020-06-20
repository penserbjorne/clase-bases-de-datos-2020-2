Prompt =========================================================
Prompt Iniciando validador - Práctica 10 complementaria
Prompt Presionar Enter si los valores configurados son correctos.
Prompt De lo contario editar el archvo &&p_archivo_validador_main 
Prompt O en su defecto proporcionar nuevos valores
Prompt =========================================================
accept p_usuario default &&p_usuario  prompt '* Nombre de usuario de la práctica [&&p_usuario]: '
accept p_usuario_pass default  &&p_usuario_pass  prompt '* Password para &p_usuario [configurado en script]: ' hide
accept p_sys_password default '&&p_sys_password' prompt '* Password de sys [configurado en script]: ' hide
accept p_archivo_respuestas default '&&p_archivo_respuestas' Prompt '* Archivo de respuestas [&&p_archivo_respuestas]: ' 
define p_dir=/tmp/bd-unam/p10c 
host mkdir -p /tmp/bd-unam/p10c
host rm -f &&p_dir/&&p_archivo_respuestas
host cp &&p_archivo_respuestas &&p_dir/&&p_archivo_respuestas
host chmod 444 &&p_dir/&&p_archivo_respuestas
connect sys/&&p_sys_password as sysdba
create or replace directory bd_unam_tmp as '&&p_dir';
grant read on directory bd_unam_tmp to &&p_usuario; 
Prompt conectando como &p_usuario
connect &p_usuario/&p_usuario_pass
Prompt creando procedimientos de validación.
@s-00-funciones-validacion.plb
Prompt creando tablas de respuesta
create or replace procedure spv_elimina_tablas wrapped 
a000000
367
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
fc 107
kwcizHeQwYv/QFDGdlfgW/ZNrBIwgwFK2ssVfC+iJscYecja0Y+XUt9w7q5d0A4DrFrzPmei
L1zL0KTICWnNERcZ/988uNis6XXUv4pA+TyaBc4nloTaN7hppqVwkC1ConLy9MyCAtFY+h24
FvcSVJABurqMylfkqJp9KakmFy6sjoA2FfCfNSNvxEZvbLkC/yl7XKMvkmTqq+tWwaVfejA2
a44rrGzp4nLG5zo6y4V6BVWXs18O4m9ub6Gz11sh8IR4

/
show errors
exec spv_elimina_tablas;
Prompt cargando archivo de respuestas
@&p_archivo_respuestas
create or replace procedure spv_crea_tablas_respuesta wrapped 
a000000
367
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
db6 2de
uvmCPB85x/HoDL8PYt5zwdlqC8Iwg80rLUgFfI6KoxBExHxnOaFhJW9Yg1QWehRiJTl9YHrZ
csuZGI4Wl4SdvMORNcIBDKD8FQwb/Yv3NL+7ubOaT7xVxgPBsHVdMUBsqzeIVOeFWNR61Xx4
Z4skNJYIsTqMwe3QqpX+ciQLZaow4xdOcjMFjYBavtfKPnhmoYlHmTipKamDKuYa8h+r+jn1
m+F7GjiOTAUssvcCL3hDn/v9kQ6yrp5rq3B8ran2p++dkxtDLrHqv0FzevQLWg/E8ZKf1Jwz
3fU37Dn58J0M3WtvxCdg65BQggPXIRtoQe9CFTWgy5nQyngWO2wncVCViEEm6OSb4KuKC5vg
+zyTfk9wj78nVGtM5c4N23RqguOtYwVAUrq2QU0BdzVnQOalY+BY7VkMQ0YuBy2njicBCyaq
jI288x4zDtKkaBoSmFb9+rEWeeu6UbmGCUf4OIxj0H1ECcG5cuo3h2fnzgMrKgPenLSIJV4+
WtycpaeHtJx14R/tLsyh9zdiujMb5E32xuwehJ2+ShInUPLWTJpKeB3ohTF/4QsekjAJEWi2
7i9kNxhg1Fsa7h7hnGlP3ytYrncNyPnS0EEXN666ZD2e0159M035B2uHlJVhZHdsrLmSm5iu
amwPa+JBjZ4NXiexA7UQj7FmCiG2EXe5NKt8Mm2uAyB7Ios1pYtjeJakmwk6lqg/blXt+JmA
AenB

/
show errors
exec spv_crea_tablas_respuesta
Prompt cargando datos de validacion
set define off
create or replace procedure spv_carga_datos wrapped 
a000000
367
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
32b7 d4e
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

/
show errors
exec spv_carga_datos
set define on
create or replace procedure spv_valida_estructura_archivo_resp wrapped 
a000000
367
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
332 25c
ha1+ImE0SyZ0PI1rd6GfBH8gWlQwgwIJLvaGfI5oxz+VmJP7zPFWfmtrW8Y/eTZKkRQxLq7m
MkT2hXuvn8D80A8x3GhG0bqk0gghgqveifLzOG6hRou4ZUmY1Zo7Ui66LG0zVLoLHga/QoMT
gypbyia9AaDJvnzTXOxrJWusNAoCwH9E6BumvqEExi3yP9G5qlWunHP/tgwvZZDSt5jigpIq
lTi3CATEvOqj4XLf1YmRNRdBrZPugoZP4SjQ6qtm6dysXH5lHEhfGRr7c5wMq4UOePfn95L7
j2aDDcy5iDIgT3SAs+5lAC32xBvt0D/m0wgG10EtIRYK1D1iiVyYKH1u/4BF8se2xQIJtkFJ
XWDXmtJSYBfSYTAb4TZT1uhN2YSZu8tFIUoibAXOPRPW4A8N4sAqdgrCS6puDzqG+I5twA++
OazMKYbvFicXAFENINpbh4xS2uqgv7F1EWL6z9/tyWwBQ9icpCL6HeQsIjTU6oU6f7j9OOVY
UxSlwmDLcXVXd2tC04jQNfglhbV0evJGRV2CTBXj3WLr2fYq7kQa/AGPupDzyoTopYr3xlXb
KHNkk9xFFdCdJ8c8Tg==

/
show errors
create or replace procedure spv_valida_respuestas wrapped 
a000000
367
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
cfd 4bc
tX0DLNeH+5ZK3lTc73EvWjwkYBwwg0PqmiDrfC+LQqqV7WwCCQ3dXtXIaNvW46A+SuuvXpGj
IJmX8fEslA5zCG6Q3y7Cr+VlCKbM6mMiqr9Pcv6Q7UROVidbX+a8MUC684D288llmolllqJI
FYiPA+cdJMpHCHChdYFKSx8Qdl5k/yWZiIEf+4GtCPbHKHYs986TQG5ZTNPTbVvbO0l1lgft
oWpf0Rbv3yncUF4iNokQnnnB5HAQKna5pFSHfMGDeyjJXpdHs0tkfrIWTtHkmnANvrLiX1/M
bbtillCmhrF82Nj/aOgsuwOQLim6F8s9m3OVZXHTsS09062ZfJlfoGUXGZxa12c4H0c1rBkS
6w5C940KUUc22AF0ZrpMgAWOmu5LTEvyA1niGHdNPKq5Lew+CauyOYzzU0HEUJjlQvx4gfXf
nh8LVBloKHHc5oYzn8HJwBc/7cdiNvbmq3XUP006vl/30SXRtxXPg9YWPgkEIOKEAOGckyMd
ORbqLsBb09LvDeHcr1jXTc0vz/YC3WhCO0y8B23FbgcmBCrLyEprWFhVNbQ6MEXvGWW/02gC
GaKhWE+LuJ0debgovEpfI+2AkVlsUY18dnX17lewYv3YQo+7fTTzaEH/5FCZzmaPHeSZTBfc
LoY69NCzE3p9E/o0X5kt3MfIk6cb0w/f4Y3TmWhQov2vfaez80pM+wLOdm2QR/zKFt+0GFwU
OcZQEl9jXrHqc2SzzRnk61iwfWId8wuDCGmSqMKXhvDAvBglkaa8NlhwX2a2BAQ8s2NHuMrT
OswT5p2FXJMRna1ds1yI+hrIrfyHeKOUhLk8wqdE5S+w3+Ddf397mwCosp3SSx9zTwMRjwri
jLr37P4Wsywmzt7vafhwoPxl1pJHzM2ztE9ATPcc3J+K+AcscnB341fENQ2dAxCxoH2s2hk1
fh9NeqVpqke1T1wwdph5ieppQlPbzwcEk+Lpa7xjK2tIDUzX7kyAOz79LGNXP8S60PaFPogR
e9hIk1Pj8Efbo1+uw0aN4owKjt4mrES11vZC3wDheLeh0byFUvCMX9cc1CmvqdriaiSypWBX
73qiGsYVPi0Zx2BWkh+RX6zsd3i9Y9EysjtZ8v/b/j6GizXwZDgh/IawHCn90rqJH2Um1aNM
v7flVzkyUqASagm1hIzFXNdMlWz5JSoKfXo6vcoXEaw=

/
show errors
set appinfo on
exec spv_print_header
host sha256sum &&p_archivo_validador
exec spv_valida_respuestas('&&p_usuario','&&p_archivo_respuestas')
host rm -f &&p_dir/&&p_archivo_respuestas