--@Autor(es):       Paul Aguilar
--@Fecha creación:  03/06/2020
--@Descripción:     Ejercicios extra tema 9 parte 2

/*
2. Determinar el número de profesores que imparten la materia de BASES DE DATOS 
para todos los cursos del semestre 2008-1

R: Se debe obtener 5 como resultado.
*/

select count(*) as num_profesores
    from profesor p
    join curso c
        on c.profesor_id = p.profesor_id
    join asignatura a
        on a.asignatura_id = c.asignatura_id
    join semestre s
        on s.semestre_id = c.semestre_id
    where s.anio = 2008
      and s.periodo = 1
      and a.nombre = 'BASES DE DATOS';
  
/*
-> Resultado obtenido

"NUM_PROFESORES"
        5
*/
  
/*
3. Determinar el promedio de las calificaciones del estudiante 
MARIANA AGUIRRE PEREZ

R: Se debe obtener 9 como resultado.
*/

select avg(ei.calificacion) as promedio
    from estudiante_inscrito ei
    join estudiante e
        on e.estudiante_id = ei.estudiante_id
    where e.nombre = 'MARIANA'
        and e.apellido_paterno = 'AGUIRRE'
        and e.apellido_materno = 'PEREZ';

/*
-> Resultado obtenido

"PROMEDIO"
    9


*/
  
/*
7. Suponga que se desea generar un reporte de todos aquellos cursos del semestre 
2008-1 (id =1), que tuvieron 3 o menos alumnos inscritos. Esto con
la finalidad de cancelarlos para el próximo semestre. El reporte debe contener: 
clave del grupo, nombre de la asignatura, nombre y apellidos del
profesor, y el número de alumnos inscritos. Generar una sentencia SQL que 
muestre el contenido del reporte.

R: Se debe obtener 1 registro con 2 alumnos inscritos.
*/

select c.clave_grupo, a.nombre, p.nombre, count(*) as alum_inscritos
    from curso c
    join estudiante_inscrito ei
        on c.curso_id = ei.curso_id
    join profesor p
        on c.profesor_id = p.profesor_id
    join asignatura a
        on a.asignatura_id = c.asignatura_id
    where c.semestre_id = 1
    group by c.clave_grupo, a.nombre, p.nombre
    having count(*) < 3;

/*
-> Resultados obtenidos

"CLAVE_GRUPO"	"NOMBRE"	"NOMBRE_1"	"ALUM_INSCRITOS"
"001"	"ALGEBRA LINEAL"	"HUGO"	2
*/


/*
10. Determinar el nombre de las asignaturas, la clave del grupo, nombre, 
apellidos y fecha de nacimiento del profesor más joven que imparte cursos en
la universidad.

R: Se debe obtener 2 registros.
*/

select a.nombre, c.clave_grupo, p.nombre as nombre_profesor,
      p.apellido_paterno, p.apellido_materno, p.fecha_nacimiento
    from asignatura a
    join curso c
        on a.asignatura_id = c.asignatura_id
    join profesor p
        on p.profesor_id = c.profesor_id
    where p.fecha_nacimiento =
        (
            select max(fecha_nacimiento)
                from profesor p
                join curso c
                    on c.profesor_id = p.profesor_id
        );


/*
-> Resultados obtenidos

"NOMBRE"	"CLAVE_GRUPO"	"NOMBRE_PROFESOR"	"APELLIDO_PATERNO"	"APELLIDO_MATERNO"	"FECHA_NACIMIENTO"
"BASES DE DATOS"	"005"	"SAMANTA"	"MIRANDA"	"ORTEGA"	22-FEB-75
"BASES DE DATOS AVANZADAS"	"001"	"SAMANTA"	"MIRANDA"	"ORTEGA"	22-FEB-75

*/
  
/*
11. Determinar los datos del profesor más joven que imparte la asignatura de 
CALCULO 2.

R: Se obtiene 1 registro con OMAR KRAUCE
*/

select *
    from profesor
    where fecha_nacimiento =
        (
            select max(p.fecha_nacimiento)
                from profesor p
                join curso c
                    on c.profesor_id = p.profesor_id
                join asignatura a
                    on a.asignatura_id = c.asignatura_id
                where a.nombre = 'CALCULO 2'
        );

/*
-> Resultados obtenidos

"PROFESOR_ID"	"NOMBRE"	"APELLIDO_PATERNO"	"APELLIDO_MATERNO"	"RFC"	"FECHA_NACIMIENTO"
10	"OMAR"	"KRAUCE"	"LOPEZ"	"OAKL701010PE0"	10-OCT-70

*/

/*
12. Suponga que un alumno desea consultar los horarios de los cursos del 
semestre 2008-1 de la materia COMPUTO PARA INGENIEROS, cuyas clases se
impartan lo más temprano posible. Generar un reporte que muestre la clave del 
grupo, nombre de la asignatura hora inicio y hora fin de los horarios
solicitados.

R: Se debe obtener 7 registros.
*/

select c.clave_grupo, a.nombre,
  to_char(h.hora_inicio,('hh24:mi:ss'))as hora_inicio,
  to_char(h.hora_fin,('hh24:mi:ss')) as hora_fin
    from curso c
    join semestre s
        on c.semestre_id = s.semestre_id
    join curso_horario ch
        on c.curso_id = ch.curso_id
    join horario h
        on h.horario_id = ch.horario_id
    join asignatura a
        on c.asignatura_id = a.asignatura_id
    where h.hora_inicio =
    (
        select min(hora_inicio)
            from horario
    )
        and a.nombre = 'COMPUTO PARA INGENIEROS'
        and s.anio = 2008
        and s.periodo = 1;
  
/*
-> Resultados obtenidos
"CLAVE_GRUPO"	"NOMBRE"	"HORA_INICIO"	"HORA_FIN"
"005"	"COMPUTO PARA INGENIEROS"	"07:00:00"	"08:30:00"
"005"	"COMPUTO PARA INGENIEROS"	"07:00:00"	"08:30:00"
"005"	"COMPUTO PARA INGENIEROS"	"07:00:00"	"08:30:00"
"001"	"COMPUTO PARA INGENIEROS"	"07:00:00"	"09:15:00"
"004"	"COMPUTO PARA INGENIEROS"	"07:00:00"	"09:15:00"
"001"	"COMPUTO PARA INGENIEROS"	"07:00:00"	"09:15:00"
"004"	"COMPUTO PARA INGENIEROS"	"07:00:00"	"09:15:00"

*/
