--@Autor(es):       Paul Aguilar
--@Fecha creación:  03/06/2020
--@Descripción:     Ejercicios tema 9 parte 2

/*
Ejercicio 14

14. Para cada asignatura impartida en el semestre 2008-1 (id =1) seleccionar el
nombre de la asignatura, el nombre, apellidos y la calificación del estudiante
que obtuvo el mayor valor. Considerar los siguientes escenarios:
A.  Generar una sentencia SQL que haga uso de una subconsulta en la cláusula
    from, emplear sintaxis anterior
B.  ¿Será posible generar una sentencia SQL que no haga uso de subconsultas? De
    ser posible, crear la sentencia con sintaxis estándar.
R:  Se obtienen 4 registros con calificaciones 10,10,10,8

*/

SELECT e.nombre, e.apellido_paterno, e.apellido_materno, q1.nombre,
    q1.max_calificacion
    FROM estudiante e
    JOIN estudiante_inscrito ei
        ON e.estudiante_id = ei.estudiante_id
    JOIN curso c
        ON ei.curso_id = c.curso_id
    JOIN (
        SELECT a.asignatura_id, a.nombre, MAX(ei.calificacion) AS max_calificacion
            FROM asignatura a, estudiante_inscrito ei, curso c
            WHERE a.asignatura_id = c.asignatura_id
            AND c.curso_id = ei.curso_id
            AND c.semestre_id = 1
            GROUP BY a.asignatura_id, a.nombre
    ) q1
    ON c.asignatura_id = q1.asignatura_id
    WHERE ei.calificacion = q1.max_calificacion
    ;
    
/* 
-> Resultados obtenitods

"NOMBRE"	"APELLIDO_PATERNO"	"APELLIDO_MATERNO"	"NOMBRE_1"	"MAX_CALIFICACION"
"JUAN"	"JUAREZ"	"MENDOZA"	"CALCULO 1"	10
"VIRIDIANA"	"AGUIRRE"	"MONTES"	"GEOMETRIA ANALITICA"	10
"ANTONIO ALEJANDRO"	"GUZMAN"	"NIETO"	"ALGEBRA"	10
"MARICELA"	"SANROMAN"	"PEÑA"	"ALGEBRA LINEAL"	8
"ALFREDO"	"FLORES"	"LUNA"	"BASES DE DATOS ESPACIALES"	9

*/

/*
Ejercicio 15

15. Se desea generar un reporte que contenga a los alumnos que obtuvieron la
mayor calificación por cada curso impartido en el semestre 2008-1 (id=1). Genere
una sentencia SQL que muestre: nombre, apellidos del estudiante, clave de su
grupo, nombre de la asignatura y la calificación. Considerar los siguientes
casos:
A.  Escribir la sentencia empleando una subconsulta correlacional empleando
    sintaxis anterior.
B.  Escribir la sentencia sin emplear subconsultas correlacionales empleando
    sintaxis estándar.
R:  Se debe obtener 6 registros con calificaciones 10,10,10,8,7 y 9
*/

/* Inciso A*/
SELECT e.nombre, e.apellido_paterno, e.apellido_materno, c.clave_grupo,
    c.curso_id, a.nombre, ei.calificacion
    FROM estudiante e, estudiante_inscrito ei, curso c, asignatura a
    WHERE e.estudiante_id = ei.estudiante_id
    AND ei.curso_id = c.curso_id
    AND c.asignatura_id = a.asignatura_id
    AND c.semestre_id = 1
    AND ei.calificacion = (
            SELECT MAX(ei.calificacion)
            FROM estudiante_inscrito ei
            WHERE ei.curso_id = c.curso_id
            -- El alias c esta definido en la consulta externa,
            -- esto hace a la sub consulta ser correlacional
        )
    ;
/*
-> Resultados obtenidos para A
"NOMBRE"	"APELLIDO_PATERNO"	"APELLIDO_MATERNO"	"CLAVE_GRUPO"	"CURSO_ID"	"NOMBRE_1"	"CALIFICACION"
"JUAN"	"JUAREZ"	"MENDOZA"	"001"	6	"CALCULO 1"	10
"VIRIDIANA"	"AGUIRRE"	"MONTES"	"001"	3	"GEOMETRIA ANALITICA"	10
"ANTONIO ALEJANDRO"	"GUZMAN"	"NIETO"	"001"	1	"ALGEBRA"	10
"MARICELA"	"SANROMAN"	"PEÑA"	"001"	10	"ALGEBRA LINEAL"	8
"MONSERRAT"	"LANDEROS"	"LUJAN"	"001"	32	"BASES DE DATOS ESPACIALES"	7
"ALFREDO"	"FLORES"	"LUNA"	"002"	33	"BASES DE DATOS ESPACIALES"	9
*/

/* Inciso B */

-- Hola mundo PL/SQL

SET serveroutput ON
BEGIN
    dbms_output.put_line('Hola Mundo');
END;
/