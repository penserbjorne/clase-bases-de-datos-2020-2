--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  23/05/2020
--@Descripción:     Ejercicio 5

CONNECT agui_p0802_cuentas/aguilar

SAVEPOINT sp_01;

-- ### EJERCICIO A

MERGE INTO cliente c USING cliente_import ci ON (c.cliente_id = ci.cliente_id)
WHEN MATCHED THEN UPDATE
    SET c.nombre = ci.nombre, c.ap_paterno = ci.ap_paterno,
        c.ap_materno = ci.ap_materno, c.curp = ci.curp,
        c.fecha_nacimiento = ci.fecha_nacimiento, c.email = ci.email,
        c.cliente_aval_id = ci.cliente_aval_id
WHEN NOT MATCHED THEN INSERT
    (c.cliente_id, c.nombre, c.ap_paterno, c.ap_materno, c.curp, c.fecha_nacimiento,
    c.email, c.cliente_aval_id)
    VALUES
    (ci.cliente_id, ci.nombre, ci.ap_paterno, ci.ap_materno, ci.curp, ci.fecha_nacimiento,
    ci.email, ci.cliente_aval_id);
    
--ROLLBACK to sp_01;
COMMIT;