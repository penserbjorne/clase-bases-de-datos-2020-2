--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  23/05/2020
--@Descripción:     Ejercicio 3

CONNECT agui_p0802_cuentas/aguilar

SAVEPOINT sp_01;
-- ### EJERCICIO A

-- SELECT * FROM estatus_cuenta;

INSERT INTO estatus_cuenta(estatus_cuenta_id, clave, descripcion, activo)
    VALUES(1, 'ABIERTA', 'Cuenta valida y vigente.', 1);

INSERT INTO estatus_cuenta(estatus_cuenta_id, clave, descripcion, activo)
    VALUES(2, 'SUSPENDIDA', 'Cuenta que no permite movimientos por un periodo de tiempo determinado.', 1);

INSERT INTO estatus_cuenta(estatus_cuenta_id, clave, descripcion, activo)
    VALUES(3, 'CONGELADA', 'Cuenta que no permite movimientos por un tiempo indefinido.', 1);

-- ### EJERCICIO B

-- SELECT * FROM banco;

INSERT INTO banco(banco_id, nombre) VALUES(60, 'BMEX');
INSERT INTO banco(banco_id, nombre) VALUES(61, 'BANCA PLUS');
INSERT INTO banco(banco_id, nombre) VALUES(62, 'BANEXITO');

-- ### EJERCICIO C

-- SELECT * FROM tipo_portafolio;

INSERT INTO tipo_portafolio(tipo_portafolio_id, clave, nombre, activo) 
    VALUES(100, 'IEFA', 'Renta variable internacional', 1);

INSERT INTO tipo_portafolio(tipo_portafolio_id, clave, nombre, activo) 
    VALUES(200, 'IVV', 'Renta variable de los EU', 1);
    
INSERT INTO tipo_portafolio(tipo_portafolio_id, clave, nombre, activo) 
    VALUES(300, 'IEMG', 'Renta variable internacional Global', 1);

-- ### EJERCICIO D

-- SELECT * FROM cliente;

INSERT INTO cliente(cliente_id, nombre, ap_paterno, ap_materno, curp, fecha_nacimiento, email, cliente_aval_id)
    VALUES(cliente_seq.nextval, 'GERARDO', 'LARA', 'URSUL', 'LAURGE891101HDF003', TO_DATE('01/11/1989','dd/mm/yyyy'), 'gerardo@mail.com', NULL);

-- ### EJERCICIO E

INSERT INTO cliente(cliente_id, nombre, ap_paterno, ap_materno, curp, fecha_nacimiento, email, cliente_aval_id)
    VALUES(cliente_seq.nextval, 'PACO', 'LUNA', 'PEREZ', 'LUPEPA900401HDF009', TO_DATE('01/04/1990','dd/mm/yyyy'), 'paco@mail.com', NULL);
    
INSERT INTO cuenta(cuenta_id, num_cuenta, tipo, saldo, fecha_estatus, estatus_cuenta_id, banco_id, cliente_id)
    VALUES(cuenta_seq.nextval, 903903, 'A', 5500.5, TO_DATE('10/10/2009 09:40:55','dd/mm/yyyy hh24:mi:ss'), 1, 60, cliente_seq.currval);
    
INSERT INTO historico_estatus_cuenta(historico_estatus_cuenta_id, fecha_estatus, cuenta_id, estatus_cuenta_id)
    VALUES(hist_estatus_cta_seq.nextval, to_date('10/10/2009 09:40:55','dd/mm/yyyy hh24:mi:ss'), cuenta_seq.currval, 1);
    
INSERT INTO cuenta_ahorro(cuenta_id, nip_cajero, num_tarjeta_debito, limite_retiro)
    VALUES(cuenta_seq.currval, 9990, '1657090812110000', 10000);
    
-- ### EJERCICIO F

INSERT INTO cliente(cliente_id, nombre, ap_paterno, ap_materno, curp, fecha_nacimiento, email, cliente_aval_id)
    VALUES(cliente_seq.nextval, 'HUGO', 'MORA', 'PAZ', 'MOPAHU010922HDF005', TO_DATE('22/09/2001','dd/mm/yyyy'), null,
        (
            SELECT cliente_id FROM cliente 
            WHERE nombre='PACO' AND ap_paterno='LUNA' AND ap_materno='PEREZ'
        )
    );

INSERT INTO cuenta(cuenta_id, num_cuenta, tipo, saldo, fecha_estatus, estatus_cuenta_id, banco_id, cliente_id)
    VALUES(cuenta_seq.nextval, 903904, 'I', 1000000, TO_DATE('01/01/2016 17:00:00','dd/mm/yyyy hh24:mi:ss'), 1, 62, cliente_seq.currval);
    
INSERT INTO historico_estatus_cuenta(historico_estatus_cuenta_id, fecha_estatus, cuenta_id, estatus_cuenta_id)
    VALUES(hist_estatus_cta_seq.nextval, TO_DATE('01/01/2016 17:00:00','dd/mm/yyyy hh24:mi:ss'), cuenta_seq.currval, 1);
    
INSERT INTO cuenta_inversion(cuenta_id, num_contRato, fecha_contrato, total_portafolios)
    VALUES(cuenta_seq.currval, '124884-2', TO_DATE('31/12/2018','dd/mm/yyyy'), 2);
    
INSERT INTO portafolio_inversion(tipo_portafolio_id, cuenta_id, porcentaje, plazo)
    VALUES(100, cuenta_seq.currval, 50, 6);
    
INSERT INTO portafolio_inversion(tipo_portafolio_id, cuenta_id, porcentaje, plazo)
    VALUES(200, cuenta_seq.currval, 50, 6);

UPDATE cuenta
    SET fecha_estatus = TO_DATE('14/02/2017 17:00:00','dd/mm/yyyy hh24:mi:ss'), estatus_cuenta_id = 3 
    WHERE num_cuenta = 903904;

INSERT INTO historico_estatus_cuenta(historico_estatus_cuenta_id, fecha_estatus, cuenta_id, estatus_cuenta_id)
    VALUES(
        hist_estatus_cta_seq.nextval, TO_DATE('14/02/2017 17:00:00','dd/mm/yyyy hh24:mi:ss'),
        (SELECT cuenta_id FROM cuenta WHERE num_cuenta = 903904),
        3
    );

-- ### EJERCICIO G
INSERT INTO cliente(cliente_id, nombre, ap_paterno, ap_materno, curp, fecha_nacimiento, email, cliente_aval_id)
    VALUES(cliente_seq.nextval, 'SARA', 'OLMOS', 'GUTIERREZ', 'GUOLSA790203HDFG00', TO_DATE('03/02/1979','dd/mm/yyyy'), 'sara@gmail.com',
    (
        SELECT cliente_id FROM cliente
        WHERE nombre = 'PACO' AND ap_paterno = 'LUNA' AND ap_materno = 'PEREZ')
    );

INSERT INTO cuenta(cuenta_id, num_cuenta, tipo, saldo, fecha_estatus, estatus_cuenta_id, banco_id, cliente_id)
    VALUES(cuenta_seq.nextval, 903911, 'A', 5000, TO_DATE('18/09/2017 11:51:05','dd/mm/yyyy hh24:mi:ss'), 1, 62, cliente_seq.currval);

INSERT INTO historico_estatus_cuenta(historico_estatus_cuenta_id, fecha_estatus, cuenta_id, estatus_cuenta_id)
    VALUES(hist_estatus_cta_seq.nextval, TO_DATE('18/09/2017 11:51:05','dd/mm/yyyy hh24:mi:ss'), cuenta_seq.currval, 1);

INSERT INTO cuenta_ahorro(cuenta_id, nip_cajero, num_tarjeta_debito, limite_retiro)
    VALUES(cuenta_seq.currval,8888,1450678300097777,25000);

INSERT INTO cuenta(cuenta_id, num_cuenta, tipo, saldo, fecha_estatus, estatus_cuenta_id, banco_id, cliente_id)
    VALUES(cuenta_seq.nextval, 903912, 'I', 5000, TO_DATE('18/09/2017 11:51:05','dd/mm/yyyy hh24:mi:ss'), 3, 62, cliente_seq.currval);

INSERT INTO historico_estatus_cuenta(historico_estatus_cuenta_id, fecha_estatus, cuenta_id, estatus_cuenta_id)
    VALUES(hist_estatus_cta_seq.nextval, to_date('18/09/2017 11:51:05','dd/mm/yyyy hh24:mi:ss'), cuenta_seq.currval, 1);

INSERT INTO cuenta_inversion(cuenta_id, num_contRato, fecha_contrato, total_portafolios)
    VALUES(cuenta_seq.currval, '133478-3',to_date('19/09/2017','dd/mm/yyyy'),1);

INSERT INTO portafolio_inversion(tipo_portafolio_id, cuenta_id, porcentaje, plazo)
    VALUES(300, cuenta_seq.currval, 100, 2);

UPDATE cuenta
    set fecha_estatus = ADD_MONTHS(TO_DATE('18/09/2017 11:51:05','dd/mm/yyyy hh24:mi:ss'), 1), estatus_cuenta_id = 3 
    where num_cuenta = 903912;

INSERT INTO historico_estatus_cuenta(historico_estatus_cuenta_id, fecha_estatus, cuenta_id, estatus_cuenta_id)
    VALUES(hist_estatus_cta_seq.nextval, ADD_MONTHS(TO_DATE('18/09/2017 11:51:05','dd/mm/yyyy hh24:mi:ss'), 1), cuenta_seq.currval,3);

--SELECT * FROM CLIENTE;
--SELECT * FROM CUENTA;
--SELECT * FROM HISTORICO_ESTATUS_CUENTA;

--ROLLBACK to sp_01;
COMMIT;