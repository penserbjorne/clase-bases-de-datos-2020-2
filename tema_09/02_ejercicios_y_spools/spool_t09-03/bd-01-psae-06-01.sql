--@Autor(es):       Paul Aguilar
--@Fecha creación:  01/06/2020
--@Descripción:     Ejercicios tema 9 parte 2

/* 

Ejercicio 1 

1. Generar una sentencia SQL que calcule el número de registros que regresaría
el producto cartesiano entre las tablas ESTUDIANTE y PLAN_ESTUDIOS.
R: Se debe obtener 69 como resultado.

*/

SELECT 
    (
        SELECT COUNT(*) FROM estudiante
    )
    *
    (
        SELECT COUNT(*) FROM plan_estudios
    )
    AS Producto
    FROM dual;
    
/*
-> Resultados obtenidos

"PRODUCTO"
69

*/

/*
Ejercicio 4

4.Generar un reporte que muestre los siguientes datos para cada plan de estudios
existente en la base de datos: id del plan de estudio, clave del plan de 
estudios, y el número de alumnos que pertenecen a cada plan.
R: Se debe obtener 3 registros con conteo 6 , 9 y 8
*/

SELECT p.plan_estudios_id, p.clave, COUNT(*) AS num_estudiantes
    FROM plan_estudios p, estudiante e
    WHERE p.plan_estudios_id = e.plan_estudios_id
    GROUP BY p.plan_estudios_id, p.clave;
    
/*
-> Resultados obtenidos

"PLAN_ESTUDIOS_ID"	"CLAVE"	"NUM_ESTUDIANTES"
1	"PL-2OO4"	8
2	"PL-2OO7"	9
3	"PL-2OO9"	6

*/

/*
Ejercicio 5

5. Suponga que la universidad desea incrementar el número de cursos de las
materias ALGEBRA y BASES DE DATOS ya que la demanda de alumnos a incrementado.
Para determinar el número de cursos a crear, se requiere consultar el número
total de alumnos que pueden inscribirse en todos los cursos de las materias en
cuestión considerando los cursos del semestre 2008-1 (ID =1). Genere una 
sentencia SQL que muestre para cada materia el dato requerido.
R: Se debe obtener 2 registros con un total de 100, 150
*/

SELECT a.nombre, SUM(c.cupo_maximo) AS suma_cupo
    FROM asignatura a
    JOIN curso c
    ON a.asignatura_id = c.asignatura_id
    WHERE c.semestre_id = 1
    AND (
        a.nombre = 'ALGEBRA' OR a.nombre = 'BASES DE DATOS'
    )
    GROUP BY a.nombre;

/*
Ejercicio 6

6. Suponga que la universidad desea hacer una reorganización de su plantilla de
profesores. El primer paso es determinar a todos aquellos profesores que hayan
impartido como máximo 3 cursos desde su inicio de labores en la universidad.
Generar una sentencia SQL que muestre nombre, apellidos, RFC y total de cursos
impartidos de todos estos profesores.
R: Se debe obtener 13 registros.
*/

SELECT p.nombre, p.apellido_paterno, p.apellido_materno, p.rfc,
    COUNT(*) AS total_cursos
    FROM profesor p
    JOIN curso c
    ON p.profesor_id = c.profesor_id
    HAVING COUNT(*) <= 3
    GROUP BY p,nombre, p.apellido_paterno, p.apellido_materno, p.rfc
    ;

/*
Ejercicio 8 

8. Se desea generar un reporte que muestre la distribución de las edades de los
alumnos de la universidad. El reporte debe contener: nombre, apellido paterno, 
apellido materno, fecha_nacimiento, edad_promedio y edad. La columna 
EDAD_PROMEDIO corresponde con la edad promedio de todos los estudiantes para
mostrarse como referencia, y la columna EDAD, contiene la edad en años que tiene
el alumno. Genere una sentencia SQL que obtenga los datos del reporte.
R: Se debe obtener 23 registros, la edad promedio es 37 y se repite en todos los
registros.
*/

SELECT nombre, apellido_paterno, apellido_materno, fecha_nacimiento,
    TRUNC( (sysdate - fecha_nacimiento)/365.25 ) AS edad,
    (
        SELECT TRUNC( AVG( (sysdate - fecha_nacimiento)/365.25 ) )
        FROM estudiante
    ) AS edad_promedio
    FROM estudiante
    GROUP BY nombre, apellido_paterno, apellido_materno, fecha_nacimiento;
  
/*
-> Resultados obtenidos
"NOMBRE"	"APELLIDO_PATERNO"	"APELLIDO_MATERNO"	"FECHA_NACIMIENTO"	"EDAD"	"EDAD_PROMEDIO"
"HERNAN"	"MARTINEZ"	"PAEZ"	29-NOV-79	40	39
"VIRIDIANA"	"AGUIRRE"	"MONTES"	15-FEB-81	39	39
"MARICELA"	"SANROMAN"	"PEÑA"	25-DEC-82	37	39
"MONSERRAT"	"LANDEROS"	"LUJAN"	15-FEB-81	39	39
"CARLA"	"LOPEZ"	"VILLAREAL"	25-DEC-82	37	39
"ARACELI"	"ESQUIVEL"	"GONZALEZ"	31-DEC-79	40	39
"ALONSO"	"NOGUERA"	"AGUILAR"	05-JAN-83	37	39
"ALFREDO"	"FLORES"	"LUNA"	22-AUG-80	39	39
"ARTURO"	"JIMENEZ"	"SANCHEZ"	10-NOV-78	41	39
"HILARIO DE JESUS"	"DURAN"	"LARA"	02-JAN-79	41	39
"MARICELA"	"GUTIERREZ"	"DURAN"	11-MAY-80	40	39
"ALBERTO"	"LOPEZ"	"MENDOZA"	02-JAN-79	41	39
"SOFIA"	"HURTADO"	"CORONA"	02-JAN-79	41	39
"LILIANA"	"BURGOS"	"VALDOVINOS"	20-MAY-78	42	39
"LAURA ELENA"	"FONSECA"	"PEREZ"	31-JAN-78	42	39
"HUGO"	"MONROY"	"ZUÑIGA"	25-OCT-82	37	39
"MARIANA"	"AGUIRRE"	"PEREZ"	22-AUG-80	39	39
"HUGO"	"MONROY"	"ZUÑIGA"	11-MAY-80	40	39
"ALBERTO"	"TOLEDO"	"MARQUEZ"	29-NOV-79	40	39
"JUAN"	"JUAREZ"	"MENDOZA"	02-JAN-79	41	39
"ANTONIO ALEJANDRO"	"GUZMAN"	"NIETO"	05-JAN-83	37	39
"LISETTE"	"CASARES"	"ORTEGA"	25-OCT-82	37	39
"MARTHA"	"RODRIGUEZ"	"GOMEZ"	30-SEP-78	41	39
*/

/*
Ejercicio 9

9. Mostrar los datos del estudiante más joven de la universidad.
R: Los alumnos con id 4 y 14 son los más jóvenes.

*/

SELECT *
    FROM estudiante
    WHERE fecha_nacimiento = (
        SELECT MAX(fecha_nacimiento)
        FROM estudiante
    );
    
/*
-> Resultado obtenido

"ESTUDIANTE_ID"	"NOMBRE"	"APELLIDO_PATERNO"	"APELLIDO_MATERNO"	"FECHA_NACIMIENTO"	"FOTOGRAFIA"	"PLAN_ESTUDIOS_ID"
4	"ANTONIO ALEJANDRO"	"GUZMAN"	"NIETO"	05-JAN-83		2
14	"ALONSO"	"NOGUERA"	"AGUILAR"	05-JAN-83		1

*/

/*
Ejercicio 13

13. Se desea generar un reporte que muestre todos los datos de las asignaturas,
y número de cursos que se crearon para todas aquellas asignaturas impartidas
durante el semestre 2008-1 (ID =1). En caso que solo se hayan creado 3 o menos
cursos, estos no deben mostrarse en el resultado.
Considerar los siguientes 2 escenarios:
A. Generar una consulta empleando una subconsulta en la cláusula select.
Emplear sintaxis anterior.
B. ¿Será posible generar la consulta sin emplear subconsultas? En caso 
afirmativo, generar la consulta empleando sintaxis estándar.
R: Se obtienen 4 registros.
*/

/* Opcion A */
SELECT a.*, q1.num_cursos
FROM (
    SELECT c.asignatura_id, COUNT(*) AS num_cursos
    FROM curso c
    WHERE semestre_id = 1
    GROUP BY c.asignatura_id
    HAVING COUNT(*) > 3
) q1, asignatura a
WHERE q1.asignatura_id = a.asignatura_id;
--AND q1.num_cursos > 3;

/*
-> Resultado obtenido

"ASIGNATURA_ID"	"NOMBRE"	"CREDITOS"	"ASIGNATURA_REQUERIDA_ID"	"PLAN_ESTUDIOS_ID"	"NUM_CURSOS"
3	"CALCULO 1"	9		1	4
5	"CALCULO 2"	9	3	1	5
6	"COMPUTO PARA INGENIEROS"	6		3	6
13	"BASES DE DATOS"	8	12	1	5

*/

SELECT a.*, COUNT(*) AS num_cursos
FROM curso c, asignatura a
WHERE a.asignatura_id = c.asignatura_id
GROUP BY a.asignatura_id, a.nombre, a.creditos,
    a.asignatura_requerida_id, a.plan_estudios_id
HAVING COUNT(*) > 3;

/*
-> Resultado obtenido
"ASIGNATURA_ID"	"NOMBRE"	"CREDITOS"	"ASIGNATURA_REQUERIDA_ID"	"PLAN_ESTUDIOS_ID"	"NUM_CURSOS"
13	"BASES DE DATOS"	8	12	1	5
3	"CALCULO 1"	9		1	4
5	"CALCULO 2"	9	3	1	5
6	"COMPUTO PARA INGENIEROS"	6		3	6
*/