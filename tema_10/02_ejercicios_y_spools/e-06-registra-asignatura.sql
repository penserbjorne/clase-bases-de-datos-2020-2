--@Autor(es):       Paul Aguilar
--@Fecha creación:  08/06/2020
--@Descripción:     Registra asignaturas

CREATE OR REPLACE PROCEDURE registra_asignatura(p_asignatura_id OUT NUMBER,
    p_nombre IN VARCHAR2, p_creditos NUMBER,
    p_clave_plan VARCHAR2, p_nombre_antecedentes IN VARCHAR2 DEFAULT NULL)

    v_plan_id plan_estudios.plan_estudios_id%type;
    v_antecedentes_id asignatura.asignatura_id%type;
BEGIN
    -- Obteniendo un nuevo id para la asignatura
    SELECT asignatura_seq.nextval INTO p_asignatura_id FROM DUAL;
    
    -- Obteniendo el plan_estudios_id
    BEGIN
        SELECT plan_estudios_id
            FROM plan_estudios
            WHERE clave = p_clave_plan;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No se encontro un plan de estudios para la clave '
                || p_clave_plan);
            RAISE;
    END;
    
    -- Obteniendo asignatura antecedente en caso de requerirse
    BEGIN
        IF p_nombre_antecedente IS NOT NULL THEN
            SELECT asignatura_id INTO v_antecedente_id
                FROM asignatura
                WHERE nombre = p_nombre_antecedente;
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No se encontro la asignatura antecednente para '
                || p_nombre_antecedente);
            RAISE;
    END;
    
    INSERT INTO asignatura(asignatura_id, nombre, creditos, plan_estudios_id,
        asignatura_requerida_id)
    VALUES(p_asignatura_id, p_nombre, p_creditos, v_plan_id, v_antecedente_id);

END;
/

SHOW ERRORS;