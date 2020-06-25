--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  24/06/2020
--@Descripción:     Script para cargar datos en la base de datos

--
PROMPT ### Conectando a ap_proy_admin ###
CONNECT ap_proy_admin/admin

-- Por si hay error
WHENEVER SQLERROR EXIT

PROMPT ### Cargando datos en la base de datos ###

-- empleado y sus grados
INSERT INTO empleado VALUES (
  seq_empleado.nextval, 'AUEP940216AAAAAAAA', TO_DATE('2020/01/01', 'YYYY/MM/DD'),
  'correo1@mail.com', 'NOMBRE 1', 'AP PAT 1', 'AP MAT 1', 10000, 0, 0, 1, NULL
);

INSERT INTO grado VALUES(
  NULL, 11111111, 1111111111, TO_DATE('2020/01/01', 'YYYY/MM/DD'), seq_empleado.currval
);

INSERT INTO empleado VALUES (
  seq_empleado.nextval, 'AUEP940216BBBBBBBB', TO_DATE('2020/02/01', 'YYYY/MM/DD'),
  'correo2@mail.com', 'NOMBRE 2', 'AP PAT 2', 'AP MAT 2', 10000, 0, 1, 1, NULL
);

INSERT INTO grado VALUES(
  NULL, 22222222, 2222222222, TO_DATE('2020/02/01', 'YYYY/MM/DD'), seq_empleado.currval
);

INSERT INTO empleado VALUES (
  seq_empleado.nextval, 'AUEP940216CCCCCCCC', TO_DATE('2020/03/01', 'YYYY/MM/DD'),
  'correo3@mail.com', 'NOMBRE 3', 'AP PAT 3', 'AP MAT 3', 10000, 0, 1, 1, NULL
);

INSERT INTO grado VALUES(
  NULL, 33333333, 3333333333, TO_DATE('2020/03/01', 'YYYY/MM/DD'), seq_empleado.currval
);

INSERT INTO empleado VALUES (
  seq_empleado.nextval, 'AUEP940216DDDDDDDD', TO_DATE('2020/04/01', 'YYYY/MM/DD'),
  'correo4@mail.com', 'NOMBRE 4', 'AP PAT 4', 'AP MAT 4', 10000, 0, 1, 1, NULL
);

INSERT INTO grado VALUES(
  NULL, 44444444, 4444444444, TO_DATE('2020/04/01', 'YYYY/MM/DD'), seq_empleado.currval
);

INSERT INTO empleado VALUES (
  seq_empleado.nextval, 'AUEP940216EEEEEEEE', TO_DATE('2020/05/01', 'YYYY/MM/DD'),
  'correo5@mail.com', 'NOMBRE 5', 'AP PAT 5', 'AP MAT 5', 10000, 1, 1, 0, NULL
);

INSERT INTO grado VALUES(
  NULL, 55555555, 5555555555, TO_DATE('2020/05/01', 'YYYY/MM/DD'), seq_empleado.currval
);

INSERT INTO centro_operativo VALUES(
  'AAAAA', 'CENTRO 1', 'DIRECCION 1', '111111111.111111', '222222222.222222',
  1, 0, 0, seq_empleado.currval
);

INSERT INTO empleado VALUES (
  seq_empleado.nextval, 'AUEP940216FFFFFFFF', TO_DATE('2020/06/01', 'YYYY/MM/DD'),
  'correo6@mail.com', 'NOMBRE 6', 'AP PAT 6', 'AP MAT 6', 10000, 1, 0, 0, NULL
);

INSERT INTO grado VALUES(
  NULL, 66666666, 6666666666, TO_DATE('2020/06/01', 'YYYY/MM/DD'), seq_empleado.currval
);

INSERT INTO centro_operativo VALUES(
  'BBBBB', 'CENTRO 2', 'DIRECCION 2', '333333333.333333', '444444444.444444',
  1, 1, 0, seq_empleado.currval
);

INSERT INTO empleado VALUES (
  seq_empleado.nextval, 'AUEP940216GGGGGGGG', TO_DATE('2020/07/01', 'YYYY/MM/DD'),
  'correo7@mail.com', 'NOMBRE 7', 'AP PAT 7', 'AP MAT 7', 10000, 1, 1, 0, NULL
);

INSERT INTO grado VALUES(
  NULL, 77777777, 7777777777, TO_DATE('2020/07/01', 'YYYY/MM/DD'), seq_empleado.currval
);

INSERT INTO centro_operativo VALUES(
  'CCCCC', 'CENTRO 3', 'DIRECCION 3', '555555555.555555', '666666666.666666',
  0, 0, 1, seq_empleado.currval
);

UPDATE empleado SET codigo_centro_id = 'AAAAA'
  WHERE empleado_id = 1 OR empleado_id = 2 OR empleado_id = 5;

UPDATE empleado SET codigo_centro_id = 'BBBBB'
  WHERE empleado_id = 3 OR empleado_id = 6;

UPDATE empleado SET codigo_centro_id = 'CCCCC'
  WHERE empleado_id = 4 OR empleado_id = 7;

INSERT INTO refugio(codigo_centro_id, num_registro, capacidad_max)
  VALUES('AAAAA', 'AAAAAAAAAAAAAAAAAAAA', 20);
INSERT INTO refugio
  VALUES('BBBBB', 'BBBBBBBBBBBBBBBBBBBB', 50, NULL, 'Esto es un lema');

INSERT INTO clinica(
  codigo_centro_id, hora_inicio, hora_fin, tel_clientes, tel_emergencias
) VALUES(
  'BBBBB', TO_DATE('2020/01/01 07:00', 'YYYY/MM/DD hh24:mi'),
  TO_DATE('2020/01/01 21:00', 'YYYY/MM/DD hh24:mi'),
  '1111111111', '2222222222'
);

INSERT INTO oficina VALUES('CCCCC', 'CCCCCCCCCCCC', NULL, 'REPRESENTANTE LEGAL 1');

INSERT INTO sitio_web VALUES(NULL, 'www.clinica-animal.com', 'AAAAA');
INSERT INTO sitio_web VALUES(NULL, 'www.animal-love.com', 'BBBBB');

INSERT INTO estado_mascota VALUES (NULL, 'EN_REFUGIO');
INSERT INTO estado_mascota VALUES (NULL, 'DISPONIBLE_PARA_ADOPCIÓN');
INSERT INTO estado_mascota VALUES (NULL, 'SOLICITADA_PARA_ADOPCIÓN');
INSERT INTO estado_mascota VALUES (NULL, 'ADOPTADA');
INSERT INTO estado_mascota VALUES (NULL, 'ENFERMA');
INSERT INTO estado_mascota VALUES (NULL, 'FALLECIDA_EN_REFUGIO');
INSERT INTO estado_mascota VALUES (NULL, 'FALLECIDA_EN_HOGAR');

INSERT INTO tipo_mascota VALUES (NULL, 'AVE', 'CANARIO', 3);
INSERT INTO tipo_mascota VALUES (NULL, 'CANINO', 'CHOW-CHOW', 5);
INSERT INTO tipo_mascota VALUES (NULL, 'CANINO', 'PASTOR AUSTRALIANO', 5);
INSERT INTO tipo_mascota VALUES (NULL, 'FELINO', 'PERSA', 4);
INSERT INTO tipo_mascota VALUES (NULL, 'REPTIL', 'CASCABEL', 2);
INSERT INTO tipo_mascota VALUES (NULL, 'CANINO', 'SNAUSER', 4);
INSERT INTO tipo_mascota VALUES (NULL, 'CANINO', 'PUDDLE', 3);
INSERT INTO tipo_mascota VALUES (NULL, 'CANINO', 'DE BOLSILLO', 3);
INSERT INTO tipo_mascota VALUES (NULL, 'CANINO', 'CRUZA', 4);

INSERT INTO mascota VALUES(
  'aaaaaaaa','chocolate', TO_DATE('01/01/2020', 'DD/MM/YYYY'),
  TO_DATE('01/01/1994', 'DD/MM/YYYY'), NULL, 'AAAAA', 2, 2
);

INSERT INTO mascota VALUES(
  'aaaaaaab','blacky', TO_DATE('01/02/2020', 'DD/MM/YYYY'),
  TO_DATE('01/01/1995', 'DD/MM/YYYY'), NULL, 'AAAAA', 6, 2
);

INSERT INTO mascota VALUES(
  'aaaaaaac','amidala', TO_DATE('01/03/2020', 'DD/MM/YYYY'),
  TO_DATE('01/01/1996', 'DD/MM/YYYY'), NULL, 'AAAAA', 3, 2
);

INSERT INTO mascota VALUES(
  'aaaaaaad','bombon', TO_DATE('01/04/2020', 'DD/MM/YYYY'),
  TO_DATE('01/01/1997', 'DD/MM/YYYY'), NULL, 'BBBBB', 7, 2
);

INSERT INTO mascota VALUES(
  'aaaaaaae','abril', TO_DATE('01/05/2020', 'DD/MM/YYYY'),
  TO_DATE('01/01/1998', 'DD/MM/YYYY'), NULL, 'BBBBB', 8, 2
);

INSERT INTO mascota VALUES(
  'aaaaaaaf','toby', TO_DATE('01/06/2020', 'DD/MM/YYYY'),
  TO_DATE('01/01/1999', 'DD/MM/YYYY'), NULL, 'BBBBB', 9, 2
);

INSERT INTO origen_mascota VALUES(
  seq_origen_mascota.nextval, 'aaaaaaaa', 'a', NULL, NULL, NULL
);

INSERT INTO origen_mascota VALUES(
  seq_origen_mascota.nextval, 'aaaaaaab', 'a', NULL, NULL, NULL
);

INSERT INTO origen_mascota VALUES(
  seq_origen_mascota.nextval, 'aaaaaaac', 'd', 'CLIENTE 1 APELLIDO 1', NULL, NULL
);

INSERT INTO origen_mascota VALUES(
  seq_origen_mascota.nextval, 'aaaaaaad', 'd', 'CLIENTE 2 APELLIDO 2', NULL, NULL
);

INSERT INTO origen_mascota VALUES(
  seq_origen_mascota.nextval, 'aaaaaaae', 'a', NULL, NULL, NULL
);

INSERT INTO origen_mascota VALUES(
  seq_origen_mascota.nextval, 'aaaaaaaf', 'c', NULL, 'aaaaaaac', 'aaaaaaae'
);


INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaaa',
  TO_DATE('01/01/2020', 'DD/MM/YYYY'), 1
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaab',
  TO_DATE('01/02/2020', 'DD/MM/YYYY'), 1
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaac',
  TO_DATE('01/03/2020', 'DD/MM/YYYY'), 1
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaad',
  TO_DATE('01/04/2020', 'DD/MM/YYYY'), 1
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaae',
  TO_DATE('01/05/2020', 'DD/MM/YYYY'), 1
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaaf',
  TO_DATE('01/06/2020', 'DD/MM/YYYY'), 1
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaaa', SYSDATE-27, 2
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaab', SYSDATE-27, 2
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaac', SYSDATE-19, 2
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaad', SYSDATE-19, 2
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaae', SYSDATE-18, 2
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaaf', SYSDATE-8, 2
);

INSERT INTO cliente VALUES(
  seq_cliente.nextval, 'CLIENTE 1', 'AP PAT C1', 'AP MAT C1', 'OCUPACION 1',
  'USR1', 'PWD1', 1, 0
);

INSERT INTO cliente VALUES(
  seq_cliente.nextval, 'CLIENTE 2', 'AP PAT C2', 'AP MAT C2', 'OCUPACION 2',
  'USR2', 'PWD2', 1, 0
);

INSERT INTO cliente VALUES(
  seq_cliente.nextval, 'CLIENTE 3', 'AP PAT C3', 'AP MAT C3', 'OCUPACION 3',
  'USR3', 'PWD3', 1, 0
);

INSERT INTO cliente VALUES(
  seq_cliente.nextval, 'CLIENTE 4', 'AP PAT C4', 'AP MAT C4', 'OCUPACION 4',
  'USR4', 'PWD4', 1, 1
);

-- aprobado
INSERT INTO adopcion VALUES(
  seq_adopcion.nextval, 1, 'Eres lx elegidx', SYSDATE, seq_cliente.currval,
  'aaaaaaaa'
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaaa', SYSDATE-26, 3
);

UPDATE mascota SET estado_mascota_id = 4 WHERE folio_mascota_id = 'aaaaaaaa';

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaaa', SYSDATE-11, 4
);

INSERT INTO cliente VALUES(
  seq_cliente.nextval, 'CLIENTE 5', 'AP PAT C5', 'AP MAT C5', 'OCUPACION 5',
  'USR5', 'PWD5', 1, 1
);

-- rechazado
INSERT INTO adopcion VALUES(
  seq_adopcion.nextval, 2, 'El perro no tiene buena salud',
  NULL, seq_cliente.currval, 'aaaaaaab'
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaab', SYSDATE-22, 3
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaab', SYSDATE-7, 2
);

INSERT INTO cliente VALUES(
  seq_cliente.nextval, 'CLIENTE 6', 'AP PAT C6', 'AP MAT C6', 'OCUPACION 6',
  'USR6', 'PWD6', 0, 1
);

-- en proceso
INSERT INTO adopcion VALUES(
  seq_adopcion.nextval, 0, NULL, NULL, seq_cliente.currval, 'aaaaaaaf'
);

INSERT INTO adopcion VALUES(
  seq_adopcion.nextval, 0, NULL, NULL, seq_cliente.currval, 'aaaaaaaf'
);

UPDATE mascota SET estado_mascota_id = 3 WHERE folio_mascota_id = 'aaaaaaaf';

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaad', SYSDATE-4, 3
);

INSERT INTO historial_mascota VALUES(
  seq_historial_mascota.nextval, 'aaaaaaad', SYSDATE-3, 3
);

INSERT INTO revision VALUES('aaaaaaaa', 1, SYSDATE-15, 'r', 'AAAAA');
INSERT INTO revision VALUES('aaaaaaaa', 2, SYSDATE-11, 'c', 'BBBBB');
INSERT INTO revision VALUES('aaaaaaab', 1, SYSDATE-9, 'r', 'AAAAA');
INSERT INTO revision VALUES('aaaaaaac', 1, SYSDATE-8, 'r', 'AAAAA');
INSERT INTO revision VALUES('aaaaaaad', 1, SYSDATE-7, 'r', 'BBBBB');
INSERT INTO revision VALUES('aaaaaaae', 1, SYSDATE-6, 'r', 'BBBBB');
INSERT INTO revision VALUES('aaaaaaaf', 1, SYSDATE-5, 'r', 'BBBBB');

INSERT INTO revision_clinica VALUES(
  'aaaaaaaa', 2, 10, 500, 'Todo excelente, muy buena salud'
);

INSERT INTO revision_refugio VALUES(
  'aaaaaaaa', 1, 'Buena salud', NULL
);

INSERT INTO revision_refugio VALUES(
  'aaaaaaab', 1, 'Mala salud', NULL
);

INSERT INTO revision_refugio VALUES(
  'aaaaaaac', 1, 'Salud regular', NULL
);

INSERT INTO revision_refugio VALUES(
  'aaaaaaad', 1, 'Estomago sensible', NULL
);

INSERT INTO revision_refugio VALUES(
  'aaaaaaae', 1, 'Requiere monitoreo', NULL
);

INSERT INTO revision_refugio VALUES(
  'aaaaaaaf', 1, 'Problemas respiratorios menores', NULL
);

COMMIT

--
PROMPT ### Listo s-09-carga-inicial.sql ###

DISCONNECT
/
