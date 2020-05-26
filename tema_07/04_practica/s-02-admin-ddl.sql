--@Autor:               Paul Aguilar
--@Fecha de creación:   06/05/2020
--@Descripción:         Creación de roles y usuarios

-- Por si hay error
WHENEVER SQLERROR EXIT

-- Definimos constantes
DEFINE usr_admin = 'PSAE_P0701_ADMIN'

-- Limpiamos variables
UNDEFINE pwd_admin

--
PROMPT ### Conectando como &usr_admin ###
PROMPT ### Ingrese el password de &usr_admin ###
CONNECT &usr_admin/&&pwd_admin

-- Eliminamos secuencias, vistas y tablas si es que existen
PROMPT ### Limpiando secuencias ###
SET SERVEROUTPUT ON
DECLARE
  v_del BOOLEAN := FALSE;
  FUNCTION v_drop_sequence (v_sequence IN VARCHAR) RETURN BOOLEAN IS
    v_count NUMBER(1,0) := 0;
  BEGIN
    SELECT COUNT(*) INTO v_count
    FROM USER_SEQUENCES
    WHERE SEQUENCE_NAME = v_sequence;
    IF v_count > 0 THEN
      EXECUTE IMMEDIATE 'DROP SEQUENCE ' ||  v_sequence;
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
  v_del := v_drop_sequence('SEQ_ESTUDIANTE');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('### Error message was: ' || SQLERRM);
END;
/

PROMPT ### Limpiando vistas ###
SET SERVEROUTPUT ON
DECLARE
  v_del BOOLEAN := FALSE;
  FUNCTION v_drop_view (v_view IN VARCHAR) RETURN BOOLEAN IS
    v_count NUMBER(1,0) := 0;
  BEGIN
    SELECT COUNT(*) INTO v_count
    FROM USER_VIEWS
    WHERE VIEW_NAME = v_view;
    IF v_count > 0 THEN
      EXECUTE IMMEDIATE 'DROP VIEW ' ||  v_view || ' CASCADE CONSTRAINTS';
      DBMS_OUTPUT.PUT_LINE('### Vista ' || v_view || ' eliminada ###');
      RETURN TRUE;
    END IF;
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('### No se pudo eliminar la vista ' || v_view || ' ###');
      DBMS_OUTPUT.PUT_LINE('### Error message was: ' || SQLERRM);
      RETURN FALSE;
  END;
BEGIN
  v_del := v_drop_view('V_ESTUDIANTE');
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
    FROM USER_TABLES
    WHERE TABLE_NAME = v_table;
    IF v_count > 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLE ' ||  v_table || ' CASCADE CONSTRAINTS';
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
  v_del := v_drop_table('ESTUDIANTE');
  v_del := v_drop_table('REGULAR');
  v_del := v_drop_table('OYENTE');
  v_del := v_drop_table('ASIGNATURA');
  v_del := v_drop_table('OYENTE_ASIGNATURA');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('### Error message was: ' || SQLERRM);
END;
/

--
PROMPT ### Creando secuencias ###

PROMPT ### Creando secuencia SEQ_ESTUDIANTE ###
CREATE SEQUENCE SEQ_ESTUDIANTE
  START WITH 10
  INCREMENT BY 3
  NOMAXVALUE
  MINVALUE 1
  NOCYCLE
  CACHE 5
  ;
PROMPT ### Secuencia SEQ_ESTUDIANTE creada ###

PROMPT ### Valores de la secuencia SEQ_ESTUDIANTE ###
SELECT SEQ_ESTUDIANTE.NEXTVAL FROM DUAL;
SELECT SEQ_ESTUDIANTE.CURRVAL FROM DUAL;

--
PROMPT ### Creando tablas ###

PROMPT ### Creando tabla ESTUDIANTE ###
CREATE TABLE ESTUDIANTE (
  estudiante_id NUMBER(10,0)  NOT NULL,
  nombre        VARCHAR2(40)  NOT NULL,
  ap_paterno    VARCHAR2(40)  NOT NULL,
  ap_materno    VARCHAR2(40),
  num_cuenta    NUMBER(9,0)   NOT NULL,
  tipo          CHAR(1)       NOT NULL,
  CONSTRAINT estudiante_pk PRIMARY KEY (estudiante_id),
  CONSTRAINT estudiante_tipo_chk CHECK(
    tipo IN ('O', 'R')
  ),
  CONSTRAINT estudiante_num_cuenta_chk CHECK(
    (tipo = 'R' AND SUBSTR(TO_CHAR(num_cuenta), 1, 2) = '31')
    OR
    (tipo = 'O' AND SUBSTR(TO_CHAR(num_cuenta), 1, 2) = '30')
  ),
  CONSTRAINT estudiante_num_cuenta_uk UNIQUE (num_cuenta)
);
CREATE INDEX estudiante_num_cuenta_uik ON ESTUDIANTE(
  SUBSTR(TO_CHAR(num_cuenta), 3, 6)
);
PROMPT ### Tabla ESTUDIANTE creada ###

PROMPT ### Creando tabla REGULAR ###
CREATE TABLE REGULAR (
  estudiante_id     NUMBER(10,0)  NOT NULL,
  semestre          NUMBER(2,0)   NOT NULL,
  promedio_general  NUMBER(4,2)   NOT NULL,
  CONSTRAINT regular_pk PRIMARY KEY (estudiante_id),
  CONSTRAINT regular_estudiante_id_fk FOREIGN KEY (estudiante_id)
    REFERENCES ESTUDIANTE(estudiante_id)
);
PROMPT ### Tabla REGULAR creada ###

PROMPT ### Creando tabla OYENTE ###
CREATE TABLE OYENTE (
  estudiante_id       NUMBER(10,0)  NOT NULL,
  num_recursamientos  NUMBER(2,0)   NOT NULL,
  num_extraordinarios NUMBER(2,0)   NOT NULL,
  CONSTRAINT oyente_pk PRIMARY KEY (estudiante_id),
  CONSTRAINT oyente_estudiante_id_fk FOREIGN KEY (estudiante_id)
    REFERENCES ESTUDIANTE(estudiante_id),
  CONSTRAINT oyente_suma_chk CHECK(
    (num_recursamientos + num_recursamientos) <= 10
  )
);
PROMPT ### Tabla OYENTE creada ###

PROMPT ### Creando tabla ASIGNATURA ###
CREATE TABLE ASIGNATURA (
  asignatura_id         NUMBER(10,0)  NOT NULL,
  nombre                VARCHAR2(40)  NOT NULL,
  clave                 NUMBER(4,0)   NOT NULL,
  creditos              NUMBER(2,0)   NOT NULL,
  asignatura_requerida_id  NUMBER(10,0),
  CONSTRAINT asignatura_pk PRIMARY KEY (asignatura_id),
  CONSTRAINT asignatura_asignatura_requerida_id_fk FOREIGN KEY (asignatura_requerida_id)
    REFERENCES ASIGNATURA(asignatura_id),
  CONSTRAINT asignatura_clave_uk UNIQUE (clave)
);
CREATE INDEX asignatura_asignatura_requerida_id_ix ON ASIGNATURA(asignatura_requerida_id);
PROMPT ### Tabla ASIGNATURA creada ###

PROMPT ### Creando tabla OYENTE_ASIGNATURA ###
CREATE TABLE OYENTE_ASIGNATURA (
  estudiante_id     NUMBER(10,0)  NOT NULL,
  asignatura_id     NUMBER(10,0)  NOT NULL,
  fecha_aprobacion  DATE          DEFAULT sysdate,
  calificacion      NUMBER(2,0),
  CONSTRAINT oyente_asignatura_pk PRIMARY KEY (estudiante_id, asignatura_id),
  CONSTRAINT oyente_asignatura_estudiante_fk FOREIGN KEY (estudiante_id)
    REFERENCES OYENTE(estudiante_id),
  CONSTRAINT oyente_asignatura_asignatura_fk FOREIGN KEY (asignatura_id)
    REFERENCES ASIGNATURA(asignatura_id),
  CONSTRAINT oyente_asignatura_califiacion_chk CHECK(
    calificacion BETWEEN 5 AND 10
  )
);
PROMPT ### Tabla OYENTE_ASIGNATURA creada ###

PROMPT ### Tablas creadas ###

PROMPT ### Creando vistas ###

PROMPT ### Creando vista V_ESTUDIANTE ###
CREATE OR REPLACE VIEW V_ESTUDIANTE(
  estudiante_id, nombre, semestre, num_cuenta
)
AS
SELECT e.estudiante_id, e.nombre, r.semestre, e.num_cuenta
FROM ESTUDIANTE e, REGULAR r
WHERE e.estudiante_id = r.estudiante_id;

PROMPT ### Vista V_ESTUDIANTE creada ###

PROMPT ### Vistas creadas ###

-- Limpiamos entorno
PROMPT ### Limpiando entorno ###
UNDEFINE usr_admin
UNDEFINE pwd_admin

--
PROMPT ### s-02-admin-ddl.sql termino con exito ###
disconnect;
