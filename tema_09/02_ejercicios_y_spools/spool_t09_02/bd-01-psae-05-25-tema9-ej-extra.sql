--@Autor(es):       Paul Aguilar
--@Fecha creación:  25/05/2020
--@Descripción:     Ejercicios tema 9 parte 1, extra

--- Ejercicios tema 9 parte 1

/*
Ejercicio 9

9. Cada semestre, la universidad realiza un sorteo para obtener a los profesores
que aplicarán encuestas. En esta ocasión, todas las condiciones que debe cumplir
un profesor para que sea seleccionado son:
i.      El profesor nació posterior al año 1970
ii.     El nombre del profesor debe ser JUAN, o LUISA o LENIN
iii.    El apellido paterno debe iniciar con la letra R
Empleando alguno de los operadores del algebra relacional, determine nombre, 
apellidos y edad en años de los profesores que deben aplicar encuestas.
R: Se obtiene 1 registro.

*/



/*
Ejercicio 13

13. Mostrar el nombre de los cursos y la calificación en los que ha estado
inscrito el alumno JUAN JUAREZ MENDOZA. Usar notación SQL estándar.
R: Se obtienen 3 registros.
*/
    
SELECT a.nombre, ei.calificacion
    FROM asignatura a
    JOIN curso c
        ON a.asignatura_id = c.asignatura_id
    JOIN estudiante_inscrito ei
        ON ei.curso_id = c.curso_id
    JOIN estudiante e
        oN e.estudiante_id = ei.estudiante_id
    AND e.nombre = UPPER('juan')
    AND e.apellido_paterno = UPPER('juarez')
    AND e.apellido_materno = UPPER('mendoza')
    ;
/*
-> Resultados obtenidos
"NOMBRE"	"CALIFICACION"
"ALGEBRA"	7
"CALCULO 1"	10
"GEOMETRIA ANALITICA"	9
*/


/*
Ejercicio 14

14. Generar una sentencia SQL que muestre nombre de la asignatura, clave del
plan de estudios, clave del grupo y día de la semana de todos los cursos que
imparte el profesor JULIAN VALDEZ SANCHEZ en el semestre 2008-1, emplear
notación anterior. Ordenar por nombre de la asignatura y después por la clave
del grupo.
R: Se obtienen 11 registros.
*/



/*
Ejercicio 16

16. Mostrar el nombre de los cursos, su identificador y su clave de grupo que
actualmente están siendo cursados por estudiantes. Considerando que los cursos
que actualmente se están cursando, son aquellos a los que no se les ha asignado
una calificación. Usar cualquier notación.
R: Se obtiene 1 registro.
*/

/*
Ejercicio 17

17. Generar un reporte que muestre todos los datos del profesor KRAUCE, así como
todos los datos de los cursos que imparte. Empleando natural join.
R: Se obtienen 3 registros.
*/

/*
Ejercicio 23

23. Genere una consulta que muestre el resultado de multiplicar las entidades 
plan_estudios y horario. Emplear sintaxis anterior y sintaxis estándar.
R: Se obtienen 57 registros.
*/

/*
Ejercicio 24
24. Reescribir la siguiente consulta empleando sintaxis anterior. Ejecutar la 
consulta. Posteriormente, eliminar la condición del Join, ejecutar la consulta.
¿Qué problemas se observan?
    Se desea generar un reporte que muestre los datos de los exámenes 
    extraordinarios que ha realizado la alumna con id 21. El reporte debe 
    incluir su nombre completo, el número de examen, su calificación y el 
    identificador de la asignatura.
R: Se obtienen 12 registros sin la condición de join lo cual es incorrecto!.
*/