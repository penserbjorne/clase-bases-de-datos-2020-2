--@Autor:               Paul Aguilar
--@Fecha de creación:   16/05/2020
--@Descripción:         Modificación de la estructura de la base de datos

-- Por si hay error
WHENEVER SQLERROR EXIT

-- Definimos constantes
DEFINE usr_basic = 'PSAE_P0701_OPER'

-- Limpiamos variables
UNDEFINE pwd_oper

--
PROMPT ### Conectando como &usr_basic ###
PROMPT ### Ingrese el password de &usr_basic ###
connect &usr_basic/&&pwd_oper

-- Corrigiendo roles
PROMPT ### Corrigiendo roles permitidos en tabla pizzeria ###
ALTER TABLE pizzeria DROP COLUMN tipo;
ALTER TABLE pizzeria ADD (es_almacen NUMBER(1,0) NOT NULL);
ALTER TABLE pizzeria ADD (es_sucursal NUMBER(1,0) NOT NULL);
ALTER TABLE pizzeria ADD CONSTRAINT pizzeria_es_almacen_o_sucursal_chk CHECK(
  (es_almacen = 1 AND es_sucursal = 0) OR
  (es_almacen = 0 AND es_sucursal = 1) OR
  (es_almacen = 1 AND es_sucursal = 1)
);

-- Corrigiendo requiere_surtir de pizzeria_almacen
PROMPT ### Corrigiendo campo requiere_surtir de tabla pizzeria_almacen ###
ALTER TABLE pizzeria_almacen MODIFY(requiere_surtir NUMBER(1,0));
ALTER TABLE pizzeria_almacen ADD CONSTRAINT pizzeria_almacen_requiere_surtir_chk CHECK(
  requiere_surtir = 0 OR requiere_surtir = 1
);

-- Corrigiendo apellidos de empleado
PROMPT ### Corrigiendo apellidos de empleado ###
ALTER TABLE empleado RENAME COLUMN ap_pat TO ap_paterno;
ALTER TABLE empleado RENAME COLUMN ap_mat TO ap_materno;
ALTER TABLE empleado MODIFY (ap_materno VARCHAR2(40) NULL);

-- Corrigiendo status_id en status_pedido
PROMPT ### Corrigiendo status_id en status_pedido ###
ALTER TABLE pedido DROP CONSTRAINT pedido_status_id_fk;
ALTER TABLE pedido RENAME COLUMN status_id TO status_pedido_id;
ALTER TABLE status_pedido DROP CONSTRAINT status_pedido_pk;
ALTER TABLE status_pedido RENAME COLUMN status_id TO status_pedido_id;
ALTER TABLE status_pedido ADD CONSTRAINT status_pedido_pk PRIMARY KEY (status_pedido_id);
ALTER TABLE pedido ADD CONSTRAINT pedido_status_id_fk FOREIGN KEY (status_pedido_id)
  REFERENCES status_pedido(status_pedido_id);

-- Corrigiendo FK empleado_id en pizzeria
PROMPT ### Corrigiendo FK empleado_id en pizzeria ###
ALTER TABLE pizzeria DROP CONSTRAINT pizzeria_empleado_id_fk;
ALTER TABLE pizzeria DROP COLUMN empleado_id;
ALTER TABLE empleado ADD (pizzeria_id NUMBER(10,0) NOT NULL);
ALTER TABLE empleado ADD CONSTRAINT empleado_pizzeria_id_fk FOREIGN KEY (pizzeria_id)
  REFERENCES pizzeria(pizzeria_id);

-- Corrigiendo formato de las columnas importe_total y fecha_ing
PROMPT ### Corrigiendo formato de las columnas importe_total y fecha_ing ###
ALTER TABLE pedido MODIFY (importe_total NUMBER(10,0));
ALTER TABLE empleado MODIFY (fecha_ing DATE);

-- Corrigiendo feccha de apertura de sucursal
PROMPT ### Corrigiendo feccha de apertura de sucursal ###
ALTER TABLE sucursal ADD (fecha_apertura DATE DEFAULT sysdate NOT NULL);

-- Corrigiendo la clave de la pizzeria
PROMPT ### Corrigiendo la clave de la pizzeria ###
ALTER TABLE pizzeria MODIFY (clave VARCHAR2(10));
ALTER TABLE pizzeria ADD CONSTRAINT pizzeria_clave_chk CHECK(
  (es_almacen = 1 AND es_sucursal = 0 AND clave LIKE 'PIZ-A-%') OR
  (es_almacen = 0 AND es_sucursal = 1 AND clave LIKE 'PIZ-S-%') OR
  (es_almacen = 1 AND es_sucursal = 1 AND clave LIKE 'PIZ-AS-%')
);

-- Corrigiendo PK de pedido
PROMPT ### Corrigiendo PK de pedido ###
ALTER TABLE pedido DROP CONSTRAINT pedido_pk;
ALTER TABLE pedido RENAME COLUMN num_pedido TO pedido_id;
ALTER TABLE pedido ADD CONSTRAINT pedido_pk PRIMARY KEY (pedido_id);
ALTER TABLE pedido ADD CONSTRAINT pedido_num_pedido_pizzeria_uk
  UNIQUE (pedido_id, pizzeria_id);

-- Corrigiendo fecha de ingreso del empelado
PROMPT ### Corrigiendo fecha de ingreso del empelado ###
ALTER TABLE empleado RENAME COLUMN fecha_ing TO fecha_ingreso;

-- Corrigiendo longitud maxima del telefono de una pizzeria
PROMPT ### Corrigiendo longitud maxima del telefono de una pizzeria ###
ALTER TABLE pizzeria ADD CONSTRAINT pizzeria_telefono_chk CHECK(
  telefono <= 9999999999
);

-- Corrigiendo el nombre de pizzeria_almacen a almacen
PROMPT ### Corrigiendo el nombre de pizzeria_almacen a almacen ###
ALTER TABLE pizzeria_almacen RENAME TO almacen;

--- Corrigiendo la secuencia seq_pizzeria
PROMPT ### Corrigiendo la secuencia seq_pizzeria ###
ALTER SEQUENCE seq_pizzeria
  NOCYCLE
  INCREMENT BY 4
  MINVALUE 7
  CACHE 7
;

-- Verificando los cambios
PROMPT ### Verificando los cambios ###
-- 1
PROMPT ### 1 ###
insert into pizzeria(pizzeria_id,clave,nombre,direccion,
  telefono,num_empleados,es_almacen,es_sucursal)
  values(1,'PIZ-AS-001','Pizzas Cachos','Av. Juarez 512',5510028938,
    200,1,1);

--2
PROMPT ### 2 ###
insert into pizzeria(pizzeria_id,clave,nombre,direccion,
  telefono,num_empleados,es_almacen,es_sucursal)
  values(2,'PIZ-S-002','Pizza Planeta','Av. Constitucion de 1917 10',5513523978,
    400,0,1);

--3
PROMPT ### 3 ###
insert into empleado(empleado_id,nombre,ap_paterno,ap_materno,
  fecha_ingreso,pizzeria_id)
  values(1,'Daniel','Lopez',null,sysdate,1);

--4
PROMPT ### 4 ###
insert into almacen(pizzeria_id,descripcion,num_refrescos,
  num_ingredientes,requiere_surtir)
  values(1,'Almacen para pizza planeta',80,100,0);

--5
PROMPT ### 5 ###
insert into sucursal(pizzeria_id,fecha_apertura,total_pedidos)
  values(2,sysdate,500);

--6
PROMPT ### 6 ###
insert into status_pedido(status_pedido_id,clave,descripcion)
  values(1,'ACTIVO', 'SOLICITADO');

--7
PROMPT ### 7 ###
insert into pedido(pedido_id,importe_total,total_pizzas,total_refrescos,
  pizzeria_id,status_pedido_id)
  values(1,145.50,1,2,2,1);

-- Limpiamos entorno
PROMPT ### Limpiando entorno ###
UNDEFINE usr_basic
UNDEFINE pwd_oper

--
PROMPT ### s-05-oper-alter.sql termino con exito ###
disconnect;
