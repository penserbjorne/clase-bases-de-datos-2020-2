--@Autor(es):       Paul Aguilar
--@Fecha creación:  18/05/2020
--@Descripción:     Ejercicios de algebra relacional

--- Ejercicios tema 9 parte 1

/*
Ejercicio 8

8. Mostrar el nombre, RFC y fecha de nacimiento de todos aquellos profesores que
hayan nacido en los siguientes rangos:
- Entre los años 1950 y 1955
- Entre los años 1960 y 1965
Observar que pasa con el registro que tiene id =25
R: Se obtienen 10 registros

    
    [pi] nombre, rfc, fecha_nacimiento (
        (
            [sigma] to_char(fecha_nacimiento, 'YYYY') >= '1950' (PROFESOR)
            ^
            [sigma] to_char(fecha_nacimiento, 'YYYY') <= '1955' (PROFESOR)
        )
        U
        (
            [sigma] to_char(fecha_nacimiento, 'YYYY') >= '1960' (PROFESOR)
            ^
            [sigma] to_char(fecha_nacimiento, 'YYYY') <= '1965' (PROFESOR)
        )
    )
    
*/

SELECT nombre, rfc, fecha_nacimiento
FROM (
    (
        SELECT *
            FROM PROFESOR
            WHERE to_char(fecha_nacimiento, 'YYYY') >= '1950'
        INTERSECT
        SELECT *
            FROM PROFESOR
            WHERE to_char(fecha_nacimiento, 'YYYY') <= '1955'
    )
    UNION ALL
    (
        SELECT *
            FROM PROFESOR
            WHERE to_char(fecha_nacimiento, 'YYYY') >= '1960'
        INTERSECT
        SELECT *
            FROM PROFESOR
            WHERE to_char(fecha_nacimiento, 'YYYY') <= '1965'
    )
) q1;

/*
-> Resultados obtenidos

"NOMBRE"	        "RFC"	        "FECHA_NACIMIENTO"
"HILARIO"	        "HIJL500510SW0"	    10-MAY-50
"RUBEN"	            "RUUS5501015T3"	    01-JAN-55
"SOFIA"	            "SOYA500515LB6"	    05-DEC-50
"HUGO"	            "FOLH510410IH1"	    10-APR-51
"ELIASAR"	        "HUAE740201LE0"	    01-FEB-54
"FELIPE"	        "SOYA500515LB6"	    15-NOV-52
"MARIA GUADALUPE"	"MAGO661212UK1"	    12-DEC-64
"MARGARITA"	        "LUHM631024RY3"	    24-OCT-63
"SOCORRO"	        "ZUGS630218HG2"	    18-FEB-63
"AXEL"	            "SORA610401Q84"	    01-APR-61
"MARIA GUADALUPE"	"MAGO661212UK1"	    12-DEC-64

*/


/*
Ejercicio 10

10. Suponga que la universidad desea cancelar a todos aquellos cursos que tengan
un cupo máximo de 30 estudiantes excepto aquellos cursos que tengan clave 001.
Empleando operadores del álgebra relacional, generar una sentencia SQL que
obtenga el identificador del curso y su clave de los cursos que se eliminarán.
R: Se obtienen 11 registros.

    p curso_id, cupo_maximo(
        s cupo_maximo = 30(curso)
        -
        s clave_grupo = '001'
    )
*/

SELECT curso_id, clave_grupo
FROM (
    SELECT *
        FROM curso
        WHERE cupo_maximo = 30
    MINUS
    SELECT *
        FROM curso
        WHERE clave_grupo = '001'
) q1;

/*
-> Resultados obtenidos

"CURSO_ID"	"CLAVE_GRUPO"
    17	        "002"
    18	        "003"
    19	        "004"
    20	        "005"
    21	        "006"
    23	        "002"
    24	        "003"
    26	        "002"
    27	        "003"
    28	        "004"
    29	        "005"
*/

/*
Ejercicio 11

11. Para el próximo semestre, la universidad tiene planeado reducir el número de
cursos para las asignaturas que cumplan con las siguientes reglas:
"La asignatura debe pertenecer a los planes de estudios con id 1 o 2, aunque,
si existen materias con 9 o más créditos, estas no se consideran."
Emplear alguno de los operadores relacionales determine el id de la asignatura,
el nombre, su plan de estudios y el número de créditos.
R: Se obtienen 9 registros.

    [pi] asignatura_id, nombre, creditos (
        [sigma] plan_estudios = 1(ASIGNATURA)
        U
        [signma] plan_estudios = 2 (ASIGNATURA)
        -
        [sigma] creditos >= 9 (ASIGNATURA)
    )
*/

SELECT asignatura_id, nombre, creditos
FROM (
    SELECT *
        FROM ASIGNATURA
        WHERE plan_estudios_id = 1
    UNION
    SELECT * 
        FROM ASIGNATURA
        WHERE plan_estudios_id = 2
    MINUS
    SELECT * 
        FROM ASIGNATURA
        WHERE creditos >= 9
) q1;

/* 
-> Resultados obtenidos

"ASIGNATURA_ID"	"NOMBRE"	                        "CREDITOS"
    1	        "ALGEBRA"	                            8
    4	        "ALGEBRA LINEAL"	                    7
    7	        "CALCULO 3"	                            8
    10	        "ELECTRICIDAD Y MAGNETISMO"	            8
    11	        "ALGORITMOS Y ESTRUCTURA DE DATOS"	    6
    13	        "BASES DE DATOS"	                    8
    14	        "ANALISIS DE SISTEMAS Y SEÑALES"	    7
    16	        "DINAMICA DE SISTEMAS FISICOS"	        6
    20	        "TEMAS SELECTOS DE BD"	                5

*/


/*
Ejercicio 12

12. Se desea generar un reporte que muestre los datos de los exámenes
extraordinarios que ha realizado la alumna con id 21. El reporte debe incluir
su nombre completo, el número de examen, su calificación y el identificador de
la asignatura.
A. Escribir la sentencia en términos de álgebra relacional.
B. Escribir la sentencia en SQL empleando sintaxis estándar.
R: Se obtienen 4 registros.

    [pi] nombre, numero_examen, calificacion, asignatura_id (
        [sigma] estudiante_id = 21 (ESTUDIANTE)
        |><| (join)
        ESTUDIANTE_EXTRAORDINARIO
    )
*/

SELECT e.nombre, ee.num_examen, ee.calificacion, ee.asignatura_id
    FROM ESTUDIANTE e
    JOIN ESTUDIANTE_EXTRAORDINARIO ee
    ON e.estudiante_id = ee.estudiante_id
    WHERE e.estudiante_id = 21;
  
/*
-> Resultados obtenidos

"NOMBRE"	"NUM_EXAMEN"	"CALIFICACION"	"ASIGNATURA_ID"
"LILIANA"	    1	            5	            3
"LILIANA"	    2	            6	            3
"LILIANA"	    3	            6	            7
"LILIANA"	    4       	    7	            8

*/


/*
Ejercicio 15

15. Despliegue la información de los cursos: clave grupo, cupo_maximo, nombre
del profesor y horario (día semana, hora inicio, hora fin ) para la asignatura
CALCULO 2 , en el semestre 2008-1 empleando notación SQL estándar.
R: Se obtienen 10 registros.

*/

SELECT c.clave_grupo, c.cupo_maximo, p.nombre, p.apellido_paterno, p.apellido_materno, h.dia_semana, h.hora_inicio, h.hora_fin
    FROM horario h
    JOIN curso_horario ch
    ON h.horario_id = ch.horario_id
    JOIN curso c
    ON ch.curso_id = c.curso_id
    JOIN asignatura a
    ON c.asignatura_id = a.asignatura_id
    JOIN profesor p
    ON c.profesor_id = p.profesor_id
    JOIN semestre s
    ON c.semestre_id = s.semestre_id
    WHERE 
        s.anio = 2008 AND
        s.periodo = 1 AND
        a.nombre = 'CALCULO 2'
    ;

/*
-> Resultados obtenidos

"CLAVE_GRUPO"	"CUPO_MAXIMO"	"NOMBRE"	"APELLIDO_PATERNO"	"APELLIDO_MATERNO"	"DIA_SEMANA"	"HORA_INICIO"	"HORA_FIN"
    "001"       	40	"OMAR"	"KRAUCE"	"LOPEZ"	2	01-MAY-20	01-MAY-20
    "004"	        40	"MARGARITA"	"LUJAN"	"HURTADO"	2	01-MAY-20	01-MAY-20
    "001"	        40	"OMAR"	"KRAUCE"	"LOPEZ"	4	01-MAY-20	01-MAY-20
    "004"       	40	"MARGARITA"	"LUJAN"	"HURTADO"	4	01-MAY-20	01-MAY-20
    "002"       	40	"MARIA GUADALUPE"	"GUTIERREZ"	"OLVERA"	2	01-MAY-20	01-MAY-20
    "005"	        40	"HUGO"	"FLORES"	"LINARES"	2	01-MAY-20	01-MAY-20
    "002"	        40	"MARIA GUADALUPE"	"GUTIERREZ"	"OLVERA"	4	01-MAY-20	01-MAY-20
    "005"	        40	"HUGO"	"FLORES"	"LINARES"	4	01-MAY-20	01-MAY-20
    "003"	        40	"JULIAN"	"VALDEZ"	"SANCHEZ"	2	01-MAY-20	01-MAY-20
    "003"	        40	"JULIAN"	"VALDEZ"	"SANCHEZ"	4	01-MAY-20	01-MAY-20


*/

-- Completar todos los ejercicios