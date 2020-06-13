--@Autor(es):       Paul Aguilar
--@Fecha creación:  25/05/2020
--@Descripción:     Ejercicios tema 9 parte 1

/*
Ejercicio 18

18. Generar una sentencia SQL que muestre el identificador del profesor, su 
nombre, sus apellidos, y la clave del grupo de todos los cursos que se imparten 
en el semestre_id = 1 de la asignatura BASES DE DATOS. Emplear:
- Sintaxis anterior.
- Natural Join.
R: Se obtienen 5 registros.
*/

SELECT profesor_id, p.nombre, apellido_paterno, apellido_materno, clave_grupo
    FROM profesor p
    NATURAL JOIN curso c
    JOIN asignatura a USING(asignatura_id)
    WHERE a.nombre = 'BASES DE DATOS'
    AND c.semestre_id = 1;

/*
-> Resultados obtenidos
"PROFESOR_ID"	"NOMBRE"	"APELLIDO_PATERNO"	"APELLIDO_MATERNO"	"CLAVE_GRUPO"
19	"JAVIER"	"BARRERA"	"MUÑOZ"	"001"
20	"ELSA"	"PEDROZA"	"SOLANO"	"002"
21	"MARIANELA"	"FLORES"	"OLVERA"	"003"
22	"AXEL"	"SOLANO"	"RUBIO"	"004"
23	"SAMANTA"	"MIRANDA"	"ORTEGA"	"005"
*/


/*
Ejercicio diseñado por el profesor durante la clase
Mostrar nombre y apellidos del estudiante, nombre de la asignatura , nombre y
apellidos del profesor, identificador del alumno y del profesor, parar los cursos
impartidos en el semestre 2018-1 con clave de grupo 001, incluir la clave del plan
de estudios del estudiante y la clave del plan de estudios de la asignatura
*/

SELECT e.nombre, e.apellido_paterno, e.apellido_materno, a.nombre, p.nombre,
        p.apellido_paterno, p.apellido_materno, estudiante_id, profesor_id, clave
    FROM profesor p
    NATURAL JOIN curso
    NATURAL JOIN semestre
    NATURAL JOIN estudiante_inscrito
    JOIN estudiante e USING(estudiante_id)
    JOIN plan_estudios pe USING(plan_estudios_id)
    JOIN asignatura a USING(asignatura_id)
    WHERE
        anio = 2008 AND
        periodo = 1 AND
        clave_grupo = '001';
/*
-> Resultados obtenidos
"NOMBRE"	"APELLIDO_PATERNO"	"APELLIDO_MATERNO"	"NOMBRE_1"	"NOMBRE_2"	"APELLIDO_PATERNO_1"	"APELLIDO_MATERNO_1"	"ESTUDIANTE_ID"	"PROFESOR_ID"	"CLAVE"
"JUAN"	"JUAREZ"	"MENDOZA"	"ALGEBRA"	"OMAR"	"KRAUCE"	"LOPEZ"	1	10	"PL-2OO4"
"JUAN"	"JUAREZ"	"MENDOZA"	"GEOMETRIA ANALITICA"	"OMAR"	"KRAUCE"	"LOPEZ"	1	10	"PL-2OO4"
"JUAN"	"JUAREZ"	"MENDOZA"	"CALCULO 1"	"JULIAN"	"VALDEZ"	"SANCHEZ"	1	12	"PL-2OO4"
"VIRIDIANA"	"AGUIRRE"	"MONTES"	"ALGEBRA"	"OMAR"	"KRAUCE"	"LOPEZ"	2	10	"PL-2OO4"
"VIRIDIANA"	"AGUIRRE"	"MONTES"	"GEOMETRIA ANALITICA"	"OMAR"	"KRAUCE"	"LOPEZ"	2	10	"PL-2OO4"
"VIRIDIANA"	"AGUIRRE"	"MONTES"	"CALCULO 1"	"JULIAN"	"VALDEZ"	"SANCHEZ"	2	12	"PL-2OO4"
"MARICELA"	"SANROMAN"	"PEÑA"	"ALGEBRA LINEAL"	"HUGO"	"FLORES"	"LINARES"	9	14	"PL-2OO4"
"ALONSO"	"NOGUERA"	"AGUILAR"	"BASES DE DATOS ESPACIALES"	"ELSA"	"PEDROZA"	"SOLANO"	14	20	"PL-2OO4"
"ALBERTO"	"TOLEDO"	"MARQUEZ"	"BASES DE DATOS ESPACIALES"	"ELSA"	"PEDROZA"	"SOLANO"	15	20	"PL-2OO4"
"HUGO"	"MONROY"	"ZUÑIGA"	"ALGEBRA"	"OMAR"	"KRAUCE"	"LOPEZ"	3	10	"PL-2OO7"
"HUGO"	"MONROY"	"ZUÑIGA"	"GEOMETRIA ANALITICA"	"OMAR"	"KRAUCE"	"LOPEZ"	3	10	"PL-2OO7"
"HUGO"	"MONROY"	"ZUÑIGA"	"CALCULO 1"	"JULIAN"	"VALDEZ"	"SANCHEZ"	3	12	"PL-2OO7"
"ANTONIO ALEJANDRO"	"GUZMAN"	"NIETO"	"ALGEBRA"	"OMAR"	"KRAUCE"	"LOPEZ"	4	10	"PL-2OO7"
"ANTONIO ALEJANDRO"	"GUZMAN"	"NIETO"	"GEOMETRIA ANALITICA"	"OMAR"	"KRAUCE"	"LOPEZ"	4	10	"PL-2OO7"
"ANTONIO ALEJANDRO"	"GUZMAN"	"NIETO"	"CALCULO 1"	"JULIAN"	"VALDEZ"	"SANCHEZ"	4	12	"PL-2OO7"
"HERNAN"	"MARTINEZ"	"PAEZ"	"ALGEBRA"	"OMAR"	"KRAUCE"	"LOPEZ"	5	10	"PL-2OO7"
"HERNAN"	"MARTINEZ"	"PAEZ"	"GEOMETRIA ANALITICA"	"OMAR"	"KRAUCE"	"LOPEZ"	5	10	"PL-2OO7"
"HERNAN"	"MARTINEZ"	"PAEZ"	"CALCULO 1"	"JULIAN"	"VALDEZ"	"SANCHEZ"	5	12	"PL-2OO7"
"ARTURO"	"JIMENEZ"	"SANCHEZ"	"ALGEBRA LINEAL"	"HUGO"	"FLORES"	"LINARES"	10	14	"PL-2OO7"
"ALBERTO"	"LOPEZ"	"MENDOZA"	"GEOMETRIA ANALITICA"	"OMAR"	"KRAUCE"	"LOPEZ"	6	10	"PL-2OO9"
"ALBERTO"	"LOPEZ"	"MENDOZA"	"CALCULO 1"	"JULIAN"	"VALDEZ"	"SANCHEZ"	6	12	"PL-2OO9"
"MARIANA"	"AGUIRRE"	"PEREZ"	"CALCULO 1"	"JULIAN"	"VALDEZ"	"SANCHEZ"	7	12	"PL-2OO9"
"MONSERRAT"	"LANDEROS"	"LUJAN"	"BASES DE DATOS ESPACIALES"	"ELSA"	"PEDROZA"	"SOLANO"	12	20	"PL-2OO9"
"LISETTE"	"CASARES"	"ORTEGA"	"BASES DE DATOS ESPACIALES"	"ELSA"	"PEDROZA"	"SOLANO"	13	20	"PL-2OO9"
*/

/* 
Ejercicio 19

19. Mostrar un reporte de los profesores existentes en la escuela. Los datos del
reporte son:
- Nombre y apellidos del profesor
- Identificador del semestre
- De existir, clave del grupo, identificador de la asignatura e identificador
    del semestre de los cursos que ha impartido.
- Emplear: sintaxis estándar y sintaxis anterior.
R: Se obtienen 44 registros, de los cuales, los primeros 11 tienen valores nulos.
*/

SELECT p.profesor_id, p.nombre, p.apellido_paterno, p.apellido_materno,
    c.clave_grupo, c.asignatura_id, c.semestre_id
    FROM profesor p, curso c
    WHERE p.profesor_id = c.profesor_id(+);
    
/*
-> Resultados obtenidos
"PROFESOR_ID"	"NOMBRE"	"APELLIDO_PATERNO"	"APELLIDO_MATERNO"	"CLAVE_GRUPO"	"ASIGNATURA_ID"	"SEMESTRE_ID"
1	"JUAN"	"MEJIA"	"OSORIO"	""		
2	"LUISA"	"VALDEZ"	"SALAZAR"	""		
3	"ARMANDO"	"LOZANO"	"ESCOBAR"	""		
4	"HILARIO"	"JIMENEZ"	"DE LA LUNA"	""		
5	"ALEJANDRO"	"CANALES"	"BORIS"	""		
6	"LILIAN"	"ACOSTA"	"PORTALES"	""		
7	"RUBEN"	"UBALDO"	"SORIANO"	""		
8	"SOFIA"	"YEBRA"	"ACEVEDO"	""		
9	"GERARDO"	"FERNANDEZ"	"HERNANDEZ"	""		
10	"OMAR"	"KRAUCE"	"LOPEZ"	"001"	5	1
10	"OMAR"	"KRAUCE"	"LOPEZ"	"001"	2	1
10	"OMAR"	"KRAUCE"	"LOPEZ"	"001"	1	1
11	"MARIA GUADALUPE"	"GUTIERREZ"	"OLVERA"	"002"	1	1
11	"MARIA GUADALUPE"	"GUTIERREZ"	"OLVERA"	"002"	5	1
12	"JULIAN"	"VALDEZ"	"SANCHEZ"	"001"	3	1
12	"JULIAN"	"VALDEZ"	"SANCHEZ"	"002"	2	1
12	"JULIAN"	"VALDEZ"	"SANCHEZ"	"004"	3	1
12	"JULIAN"	"VALDEZ"	"SANCHEZ"	"003"	5	1
13	"MARGARITA"	"LUJAN"	"HURTADO"	"002"	3	1
13	"MARGARITA"	"LUJAN"	"HURTADO"	"003"	2	1
13	"MARGARITA"	"LUJAN"	"HURTADO"	"004"	5	1
14	"HUGO"	"FLORES"	"LINARES"	"001"	4	1
14	"HUGO"	"FLORES"	"LINARES"	"005"	5	1
14	"HUGO"	"FLORES"	"LINARES"	"003"	3	1
15	"SOCORRO"	"ZUÑIGA"	"GUTIERREZ"	"001"	6	1
15	"SOCORRO"	"ZUÑIGA"	"GUTIERREZ"	"005"	6	1
16	"LENIN"	"RUIZ"	"SUAREZ"	"002"	6	1
16	"LENIN"	"RUIZ"	"SUAREZ"	"006"	6	1
17	"ELIASAR"	"HUERTA"	"AGUILAR"	"003"	6	1
18	"FELIPE"	"LIMA"	"RODRIGUEZ"	"001"	11	1
18	"FELIPE"	"LIMA"	"RODRIGUEZ"	"004"	6	1
19	"JAVIER"	"BARRERA"	"MUÑOZ"	"001"	18	1
19	"JAVIER"	"BARRERA"	"MUÑOZ"	"002"	11	1
19	"JAVIER"	"BARRERA"	"MUÑOZ"	"001"	13	1
20	"ELSA"	"PEDROZA"	"SOLANO"	"003"	11	1
20	"ELSA"	"PEDROZA"	"SOLANO"	"001"	19	1
20	"ELSA"	"PEDROZA"	"SOLANO"	"002"	13	1
21	"MARIANELA"	"FLORES"	"OLVERA"	"003"	13	1
22	"AXEL"	"SOLANO"	"RUBIO"	"002"	19	1
22	"AXEL"	"SOLANO"	"RUBIO"	"004"	13	1
23	"SAMANTA"	"MIRANDA"	"ORTEGA"	"005"	13	1
23	"SAMANTA"	"MIRANDA"	"ORTEGA"	"001"	17	1
24	"SANTIAGO"	"DE LA PEÑA"	"GUZMAN"	""		
25	"MARIA GUADALUPE"	"GUTIERREZ"	"OLVERA"	""		

*/

/*
Ejercicio 20

20. Se desea generar un reporte de todos los estudiantes que pertenecen al plan
de estudios con id = 2, así como de los posibles exámenes extraordinarios que
han presentado. El reporte debe contener las siguientes columnas:
- Nombre del estudiante
- Apellidos del estudiante
- Nombre de la asignatura
- Calificación obtenida.
R: Se obtienen 15 registros, de los cuales, 7 tienen valores nulos.
*/

SELECT e.nombre, e.apellido_paterno, e.apellido_materno, a.nombre, ee.calificacion
    FROM estudiante e
    LEFT JOIN estudiante_extraordinario ee
    ON e.estudiante_id = ee.estudiante_id
    LEFT JOIN asignatura a
    ON a.asignatura_id = ee.asignatura_id
    WHERE e.plan_estudios_id = 2;
    
/*
-> Resultados obtenidos

"NOMBRE"	            "APELLIDO_PATERNO"	"APELLIDO_MATERNO"	"NOMBRE_1"	"CALIFICACION"
"LAURA ELENA"	        "FONSECA"	        "PEREZ"	"PROGRAMACION AVANZADA MET.NUM."	5
"LAURA ELENA"	        "FONSECA"	        "PEREZ"	"PROGRAMACION AVANZADA MET.NUM."	5
"LAURA ELENA"	        "FONSECA"	        "PEREZ"	"ELECTRICIDAD Y MAGNETISMO"	6
"LAURA ELENA"	        "FONSECA"	        "PEREZ"	"ALGORITMOS Y ESTRUCTURA DE DATOS"	7
"LAURA ELENA"	        "FONSECA"	        "PEREZ"	"ANALISIS DE SISTEMAS Y SEÑALES"	7
"MARTHA"	            "RODRIGUEZ"	        "GOMEZ"	"ANALISIS DE CIRCUITOS ELECTRICOS"	5
"MARTHA"	            "RODRIGUEZ"	        "GOMEZ"	"ANALISIS DE CIRCUITOS ELECTRICOS"	5
"LAURA ELENA"	        "FONSECA"	        "PEREZ"	"BASES DE DATOS ESPACIALES"	5
"HUGO"	                "MONROY"	        "ZUÑIGA"	""	
"ANTONIO ALEJANDRO"	    "GUZMAN"	        "NIETO"	""	
"HERNAN"	            "MARTINEZ"	        "PAEZ"	    ""	
"ARTURO"	            "JIMENEZ"	        "SANCHEZ"	""	
"SOFIA"	                "HURTADO"	        "CORONA"	""	
"HILARIO DE JESUS"	    "DURAN"	            "LARA"	""	
"ALFREDO"	            "FLORES"	        "LUNA"	    ""	


*/


/*
Ejercicio 21 SELF JOIN

21. Generar un reporte de todas las asignaturas que tengan 8 créditos. Los datos
que debe mostrar es la siguiente:
- Nombre de la asignatura
- Créditos
- Clave del plan de estudios
- Nombre de la asignatura requerida (si existe)
Emplear sintaxis SQL estándar.
R: Se obtienen 5 registros, 2 de ellos con valores nulos.
*/

SELECT a.nombre, a.creditos, ar.nombre AS antecedente, pl.clave
    FROM asignatura a
    LEFT JOIN asignatura ar
    ON ar.asignatura_id = a.asignatura_requerida_id
    JOIN plan_estudios pl
    ON a.plan_estudios_id = pl.plan_estudios_id
    WHERE a.creditos = 8;
    
/*
-> Resultados obtenidos

"NOMBRE"	"CREDITOS"	"ANTECEDENTE"	"CLAVE"
"CALCULO 3"	8	"CALCULO 2"	"PL-2OO4"
"ELECTRICIDAD Y MAGNETISMO"	8	"CALCULO 3"	"PL-2OO4"
"BASES DE DATOS"	8	"INGENIERIA DE SOFTWARE"	"PL-2OO4"
"ALGEBRA"	8	""	"PL-2OO4"
"BASES DE DATOS DISTRIBUIDAS"	8	""	"PL-2OO9"

*/

/*
Ejercicio 22

22. Mostrar las asignaturas dependientes, que no pueden cursarse sin antes
acreditar calculo 2, incluir en la consulta el identificador y en nombre de
Cálculo 2 así como el identificador y el nombre de las asignaturas dependientes.

Emplear sintaxis anterior. La consulta deberá tener los siguientes nombres de 
columnas:

ANTECEDENTE_ID ANTECEDENTE_NOMBRE DEPENDIENTE_ID DEPENDIENTE_NOMBRE
============== ================== ============== ==================
R: Se obtienen 2 registros.

*/

SELECT ar.asignatura_id as antecedente_id, ar.nombre as antecedente_nombre, 
    a.asignatura_id as dependiente_id, a.nombre as dependiente_nombre
    FROM asignatura a, asignatura ar
    WHERE
        ar.asignatura_id = a.asignatura_requerida_id AND
        ar.nombre = 'CALCULO 2';
        
/*
-> Resultados obtenidos
"ANTECEDENTE_ID"	"ANTECEDENTE_NOMBRE"	"DEPENDIENTE_ID"	"DEPENDIENTE_NOMBRE"
5	"CALCULO 2"	7	"CALCULO 3"
5	"CALCULO 2"	8	"ECUACIONES DIFERENCIALES"
*/