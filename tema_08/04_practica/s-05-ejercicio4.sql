--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  23/05/2020
--@Descripción:     Ejercicio 4

CONNECT agui_p0802_cuentas/aguilar

SAVEPOINT sp_01;

-- ### EJERCICIO A

UPDATE cuenta set 
    fecha_estatus = TO_DATE('25/12/2018 23:59:59','dd/mm/yyyy hh24:mi:ss'),
    estatus_cuenta_id =
        (SELECT estatus_cuenta_id FROM estatus_cuenta 
            WHERE clave = ('CONGELADA'))
    WHERE num_cuenta = 903911;
    
INSERT INTO historico_estatus_cuenta(historico_estatus_cuenta_id, fecha_estatus, cuenta_id, estatus_cuenta_id)
    VALUES(hist_estatus_cta_seq.nextval, TO_DATE('25/12/2018 23:59:59','dd/mm/yyyy hh24:mi:ss'),
    (SELECT cuenta_id FROM cuenta
        WHERE num_cuenta = 903911),
    (SELECT estatus_cuenta_id FROM estatus_cuenta 
            WHERE clave = ('CONGELADA'))
    );
    
-- ### EJERCICIO B

DELETE FROM portafolio_inversion 
    WHERE tipo_portafolio_id =
            (SELECT tipo_portafolio_id FROM tipo_portafolio 
                WHERE clave = 'IVV')
            AND
            cuenta_id =
                (SELECT cuenta_id FROM cuenta_inversion 
                    WHERE num_contrato = '124884-2');

UPDATE cuenta_inversion SET
    total_portafolios = 1
    WHERE cuenta_id =
            (SELECT cuenta_id FROM cuenta_inversion 
                WHERE num_contrato = '124884-2');
                
UPDATE portafolio_inversion SET
    porcentaje = 100
    WHERE tipo_portafolio_id =
            (SELECT tipo_portafolio_id FROM tipo_portafolio 
                WHERE clave = 'IEFA')
            and
            cuenta_id =
                (SELECT cuenta_id FROM cuenta_inversion 
                    WHERE num_contrato = '124884-2');

-- ### EJERCICIO C

-- Eliminamos de aval
UPDATE cliente SET cliente_aval_id = NULL
    WHERE cliente_aval_id =
        (
            SELECT cliente_id FROM cliente
                WHERE
                    nombre = 'PACO' AND
                    ap_paterno = 'LUNA' AND
                    ap_materno = 'PEREZ'
        );
        
-- Eliminamos su cuenta de ahorro
DELETE FROM cuenta_ahorro 
    WHERE cuenta_id =
        (
            SELECT cuenta_id FROM cuenta 
                WHERE cliente_id =
                    (
                        SELECT cliente_id FROM cliente
                            WHERE
                                nombre = 'PACO' AND
                                ap_paterno = 'LUNA' AND
                                ap_materno = 'PEREZ'
                    )
        );

-- Eliminamos su historial
DELETE FROM historico_estatus_cuenta
    WHERE cuenta_id =
        (
            SELECT cuenta_id FROM cuenta 
                WHERE cliente_id =
                    (
                        SELECT cliente_id FROM cliente
                            WHERE
                                nombre = 'PACO' AND
                                ap_paterno = 'LUNA' AND
                                ap_materno = 'PEREZ'
                    )
        );
        
-- Eliminamos su cuenta
DELETE FROM cuenta
    WHERE cuenta_id =
        (
            SELECT cuenta_id FROM cuenta 
                WHERE cliente_id =
                    (
                        SELECT cliente_id FROM cliente
                            WHERE
                                nombre = 'PACO' AND
                                ap_paterno = 'LUNA' AND
                                ap_materno = 'PEREZ'
                    )
        );



-- Eliminamos a Paco
DELETE FROM cliente
    WHERE
        nombre = 'PACO' AND
        ap_paterno = 'LUNA' AND
        ap_materno = 'PEREZ';
        
--ROLLBACK to sp_01;
COMMIT;