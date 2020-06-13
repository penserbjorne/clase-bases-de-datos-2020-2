--@Autor(es):       Paul Aguilar
--@Fecha creación:  08/06/2020
--@Descripción:     Valida extraordinarios

CREATE OR REPLACE TRIGGER tr_valida_extraordinarios
    BEFORE INSERT
    OR UPDATE OF calificacion
    OR DELETE
    ON estudiante_extraordinario
    FOR EACH ROW 
DECLARE
    v_aprobado NUMBER(2,0);
BEGIN
    CASE
        WHEN INSERTING THEN
            SELECT COUNT(*) INTO v_aprobado
                FROM estudiante_inscrito ei
                JOIN curso c
                    ON ei.curso_id = c.curso_id
                WHERE ei.calificacion >= 6
                AND ei.estudiante_id = :NEW.estudiante_id
                AND c.asignatura_id = :new.asignatura_id;
                
            IF v_aprobado > 0 THEN
                RAISE_APPLICATION_ERROR(-20010,
                    'El estudiante con ID '
                    || :NEW.estudiante_id
                    || ' ya aprobo la asignatura con ID '
                    || :new.asignatura_id
                    );
            END IF; -- No se requiere un else ni tampoco hacer una insercion manual
        WHEN UPDATING ('calificacion') THEN
            -- Guardando registro de auditoria
            INSERT INTO auditoria_extraordinario (auditoria_extraordinario_id, 
                fecha_cambio, usuario, calificacion_anterior, calificacion_nueva,
                estudiante_id, asignatura_id)
            VALUES (auditoria_extraordinario_seq.nextval, sysdate,
            sys_context('USERENV','SESSION_USER'), :old.calificacion,
            :new.calificacion, :new.estudiante_id, :new.asignatura_id);
        WHEN DELETING THEN
            RAISE_APPLICATION_ERROR(-20011, 'No se permiten eliminar extraordinarios');
    END CASE;
END;
/

SHOW ERRORS;