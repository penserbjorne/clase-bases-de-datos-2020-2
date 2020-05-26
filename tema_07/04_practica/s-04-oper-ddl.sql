--@Autor:               Paul Aguilar
--@Fecha de creación:   16/05/2020
--@Descripción:         Práctica 07 Complementaria - Caso pizzeria

-- Por si hay error
WHENEVER SQLERROR EXIT

-- Definimos constantes
DEFINE usr_basic = 'PSAE_P0701_OPER'

-- Limpiamos variables
UNDEFINE pwd_oper

-- Conectando como oper
PROMPT ### Conectando como SYS ###
PROMPT ### Ingrese el password SYS ###
connect sys as sysdba

-- Eliminamos secuencias y tablas si es que existen
PROMPT ### Limpiando secuencias ###
SET SERVEROUTPUT ON
DECLARE
  v_del BOOLEAN := FALSE;
  FUNCTION v_drop_sequence (v_sequence IN VARCHAR) RETURN BOOLEAN IS
    v_count NUMBER(1,0) := 0;
  BEGIN
    SELECT COUNT(*) INTO v_count
    FROM DBA_SEQUENCES
    WHERE SEQUENCE_NAME = v_sequence
    AND SEQUENCE_OWNER = '&usr_basic';
    IF v_count > 0 THEN
      EXECUTE IMMEDIATE 'DROP SEQUENCE &usr_basic..' ||  v_sequence;
      DBMS_OUTPUT.PUT_LINE('### Secuencia ' || v_sequence || ' eliminada ###');
      RETURN TRUE;
    END IF;
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('### No se pudo eliminar la secuencia ' || v_sequence || ' ###');
      DBMS_OUTPUT.PUT_LINE('### Error message was: ' || SQLERRM);
      RETURN FALSE;
  END;
BEGIN
  v_del := v_drop_sequence('SEQ_PIZZERIA');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('### Error message was: ' || SQLERRM);
END;
/

PROMPT ### Limpiando tablas ###
SET SERVEROUTPUT ON
DECLARE
  v_del BOOLEAN := FALSE;
  FUNCTION v_drop_table (v_table IN VARCHAR) RETURN BOOLEAN IS
    v_count NUMBER(1,0) := 0;
  BEGIN
    SELECT COUNT(*) INTO v_count
    FROM DBA_TABLES
    WHERE TABLE_NAME = v_table
    AND OWNER = '&usr_basic';
    IF v_count > 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLE &usr_basic..' ||  v_table || ' CASCADE CONSTRAINTS';
      DBMS_OUTPUT.PUT_LINE('### Tabla ' || v_table || ' eliminada ###');
      RETURN TRUE;
    END IF;
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('### No se pudo eliminar la tabla ' || v_table || ' ###');
      DBMS_OUTPUT.PUT_LINE('### Error message was: ' || SQLERRM);
      RETURN FALSE;
  END;
BEGIN
  v_del := v_drop_table('STATUS_PEDIDO');
  v_del := v_drop_table('PEDIDO');
  v_del := v_drop_table('EMPLEADO');
  v_del := v_drop_table('SUCURSAL');
  v_del := v_drop_table('EMPLEADO');
  v_del := v_drop_table('PIZZERIA_ALMACEN');
  v_del := v_drop_table('ALMACEN');
  v_del := v_drop_table('PIZZERIA');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('### Error message was: ' || SQLERRM);
END;
/

-- Conectando como oper
PROMPT ### Conectando como &usr_basic ###
PROMPT ### Ingrese el password de &usr_basic ###
connect &usr_basic/&&pwd_oper

--
-- sequence: seq_empleado
--

create sequence seq_pizzeria
    start with 10
    increment by 3
    minvalue 5
    maxvalue 10000000
    cache 3
    noorder
    cycle
;

--
-- table: empleado
--

create table empleado(
    empleado_id    number(10, 0)    not null,
    nombre         varchar2(40)     not null,
    ap_pat         varchar2(40)     not null,
    ap_mat         varchar2(40)     not null,
    fecha_ing      number(10, 2)    not null,
    constraint empleado_pk primary key (empleado_id)
);

--
-- table: pizzeria
--

create table pizzeria(
    pizzeria_id      number(10, 0)    not null,
    clave            varchar2(7)      not null,
    nombre           varchar2(40)     not null,
    direccion        varchar2(100)    not null,
    telefono         number(10, 0)    not null,
    num_empleados    number(10, 0)    not null,
    tipo             varchar2(1)      not null,
    empleado_id      number(10, 0)    not null,
    constraint pizzeria_pk primary key (pizzeria_id),
    constraint pizzeria_empleado_id_fk foreign key (empleado_id)
    references empleado(empleado_id)
);



--
-- table: almacen
--

create table pizzeria_almacen(
    pizzeria_id         number(10, 0)    not null,
    descripcion         varchar2(100)    not null,
    num_refrescos       number(10, 0)    not null,
    num_ingredientes    number(10, 0)    not null,
    requiere_surtir     varchar2(40)     not null,
    constraint almacen_pk primary key (pizzeria_id),
    constraint almacen_pizzeria_id_fk foreign key (pizzeria_id)
    references pizzeria(pizzeria_id)
);


--
-- table: sucursal
--

create table sucursal(
    pizzeria_id      number(10, 0)    not null,
    total_pedidos    number(10, 0)    not null,
    constraint sucursal_pk primary key (pizzeria_id),
    constraint sucursal_pizzeria_id_fk foreign key (pizzeria_id)
    references pizzeria(pizzeria_id)
);

--
-- table: status_pedido
--

create table status_pedido(
    status_id      number(10, 0)    not null,
    clave          varchar2(10)     not null,
    descripcion    varchar2(40)     not null,
    constraint status_pedido_pk primary key (status_id)
);


--
-- table: pedido
--

create table pedido(
    num_pedido         number(10, 0)    not null,
    pizzeria_id        number(10, 0)    not null,
    importe_total      date             not null,
    total_pizzas       number(10, 0)    not null,
    total_refrescos    number(10, 0)    not null,
    status_id          number(10, 0)    not null,
    constraint pedido_pk primary key (num_pedido, pizzeria_id),
    constraint pedido_pizzeria_id_fk foreign key (pizzeria_id)
    references sucursal(pizzeria_id),
    constraint pedido_status_id_fk foreign key (status_id)
    references status_pedido(status_id)
);

UNDEFINE usr_basic
UNDEFINE pwd_oper

Prompt Listo!
disconnect
