--@Autor(es):       Paul Aguilar
--@Fecha creación:  07/06/2020
--@Descripción:    Reporte de no aprobados

SET SERVEROUTPUT ON
DECLARE
    CURSOR cur_noaprobados IS 
    SELECT ROWNUM, e.nombre AS nombre_estudiante, e.apellido_paterno,
        e.apellido_materno, a.nombre AS nombre_asignatura, ei.calificacion
        FROM estudiante e
        JOIN estudiante_inscrito ei
            ON e.ESTUDIANTE_ID = ei.ESTUDIANTE_ID
        JOIN curso c
            ON ei.CURSO_ID = c.CURSO_ID
        JOIN asignatura a
            ON c.ASIGNATURA_ID = a.ASIGNATURA_ID
        WHERE ei.calificacion = 5;
        
        v_reporte VARCHAR2(100);
BEGIN
    FOR r IN cur_noaprobados LOOP
        v_reporte := r.ROWNUM
            || '#'
            || r.nombre_estudiante
            || '#'
            || r.apellido_paterno
            || '#'
            || r.apellido_materno
            || '#'
            || r.nombre_asignatura
            || '#'
            || r.calificacion;
        dbms_output.put_line(v_reporte);
        -- Tarea, hacer un nuevo programa empleando un simple loop
    END LOOP;
END;
/