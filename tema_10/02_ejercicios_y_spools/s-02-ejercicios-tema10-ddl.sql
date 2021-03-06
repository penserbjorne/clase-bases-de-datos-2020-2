--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      Particular
-- Project :      controlEscolar.dm1
-- Author :       Jorge
--
-- Date Created : Wednesday, May 16, 2018 21:14:33
-- Target DBMS : Oracle 11g
--

-- 
-- SEQUENCE: ASIGNATURA_SEQ 
--

CREATE SEQUENCE ASIGNATURA_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 20
    NOORDER
;

-- 
-- SEQUENCE: AUDITORIA_EXTRAORDINARIO_SEQ 
--

CREATE SEQUENCE AUDITORIA_EXTRAORDINARIO_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 20
    NOORDER
;

-- 
-- SEQUENCE: CURSO_SEQ 
--

CREATE SEQUENCE CURSO_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 20
    NOORDER
;

-- 
-- SEQUENCE: ESTUDIANTE_INSCRITO_SEQ 
--

CREATE SEQUENCE ESTUDIANTE_INSCRITO_SEQ
    START WITH 30
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 20
    NOORDER
;

-- 
-- SEQUENCE: ESTUDIANTE_SEQ 
--

CREATE SEQUENCE ESTUDIANTE_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 20
    NOORDER
;

-- 
-- SEQUENCE: HORARIO_CURSO_SEQ 
--

CREATE SEQUENCE HORARIO_CURSO_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 20
    NOORDER
;

-- 
-- SEQUENCE: PLAN_ESTUDIOS_SEQ 
--

CREATE SEQUENCE PLAN_ESTUDIOS_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 20
    NOORDER
;

-- 
-- SEQUENCE: PROFESOR_SEQ 
--

CREATE SEQUENCE PROFESOR_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 20
    NOORDER
;

-- 
-- SEQUENCE: SEMESTRE_SEQ 
--

CREATE SEQUENCE SEMESTRE_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 20
    NOORDER
;

-- 
-- TABLE: PLAN_ESTUDIOS 
--

CREATE TABLE PLAN_ESTUDIOS(
    PLAN_ESTUDIOS_ID    NUMBER(2, 0)    NOT NULL,
    CLAVE               VARCHAR2(7)     NOT NULL,
    FECHA_APROBACION    DATE            NOT NULL,
    FECHA_INICIO        DATE            NOT NULL,
    FECHA_FIN           DATE,
    CONSTRAINT PK2 PRIMARY KEY (PLAN_ESTUDIOS_ID)
)
;



-- 
-- TABLE: ASIGNATURA 
--

CREATE TABLE ASIGNATURA(
    ASIGNATURA_ID              NUMBER(10, 0)    NOT NULL,
    NOMBRE                     VARCHAR2(50)     NOT NULL,
    CREDITOS                   NUMBER(2, 0)     NOT NULL,
    ASIGNATURA_REQUERIDA_ID    NUMBER(10, 0),
    PLAN_ESTUDIOS_ID           NUMBER(2, 0)     NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY (ASIGNATURA_ID), 
    CONSTRAINT RefPLAN_ESTUDIOS2 FOREIGN KEY (PLAN_ESTUDIOS_ID)
    REFERENCES PLAN_ESTUDIOS(PLAN_ESTUDIOS_ID),
    CONSTRAINT RefASIGNATURA1 FOREIGN KEY (ASIGNATURA_REQUERIDA_ID)
    REFERENCES ASIGNATURA(ASIGNATURA_ID)
)
;



-- 
-- TABLE: ESTUDIANTE 
--

CREATE TABLE ESTUDIANTE(
    ESTUDIANTE_ID       NUMBER(18, 0)    NOT NULL,
    NOMBRE              VARCHAR2(50)     NOT NULL,
    APELLIDO_PATERNO    VARCHAR2(50)     NOT NULL,
    APELLIDO_MATERNO    VARCHAR2(50)     NOT NULL,
    FECHA_NACIMIENTO    DATE             NOT NULL,
    FOTOGRAFIA          BLOB,
    PLAN_ESTUDIOS_ID    NUMBER(2, 0)     NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY (ESTUDIANTE_ID), 
    CONSTRAINT RefPLAN_ESTUDIOS3 FOREIGN KEY (PLAN_ESTUDIOS_ID)
    REFERENCES PLAN_ESTUDIOS(PLAN_ESTUDIOS_ID)
)
;



-- 
-- TABLE: AUDITORIA_EXTRAORDINARIO 
--

CREATE TABLE AUDITORIA_EXTRAORDINARIO(
    AUDITORIA_EXTRAORDINARIO_ID    NUMBER(10, 0)    NOT NULL,
    FECHA_CAMBIO                   DATE             NOT NULL,
    USUARIO                        VARCHAR2(30)     NOT NULL,
    CALIFICACION_NUEVA             NUMBER(3, 1)     NOT NULL,
    CALIFICACION_ANTERIOR          NUMBER(3, 1)     NOT NULL,
    ESTUDIANTE_ID                  NUMBER(18, 0)    NOT NULL,
    ASIGNATURA_ID                  NUMBER(10, 0)    NOT NULL,
    CONSTRAINT PK12 PRIMARY KEY (AUDITORIA_EXTRAORDINARIO_ID), 
    CONSTRAINT RefESTUDIANTE27 FOREIGN KEY (ESTUDIANTE_ID)
    REFERENCES ESTUDIANTE(ESTUDIANTE_ID),
    CONSTRAINT RefASIGNATURA28 FOREIGN KEY (ASIGNATURA_ID)
    REFERENCES ASIGNATURA(ASIGNATURA_ID)
)
;



-- 
-- TABLE: PROFESOR 
--

CREATE TABLE PROFESOR(
    PROFESOR_ID         NUMBER(10, 0)    NOT NULL,
    NOMBRE              VARCHAR2(50)     NOT NULL,
    APELLIDO_PATERNO    VARCHAR2(50)     NOT NULL,
    APELLIDO_MATERNO    VARCHAR2(10),
    RFC                 VARCHAR2(18)     NOT NULL,
    FECHA_NACIMIENTO    DATE             NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY (PROFESOR_ID)
)
;



-- 
-- TABLE: SEMESTRE 
--

CREATE TABLE SEMESTRE(
    SEMESTRE_ID     NUMBER(18, 0)    NOT NULL,
    ANIO            NUMBER(4, 0)     NOT NULL,
    PERIODO         NUMBER(1, 0)     NOT NULL,
    FECHA_INICIO    DATE             NOT NULL,
    FECHA_FIN       DATE             NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY (SEMESTRE_ID)
)
;



-- 
-- TABLE: CURSO 
--

CREATE TABLE CURSO(
    CURSO_ID         NUMBER(10, 0)    NOT NULL,
    CUPO_MAXIMO      NUMBER(2, 0)     NOT NULL,
    PROFESOR_ID      NUMBER(10, 0)    NOT NULL,
    ASIGNATURA_ID    NUMBER(10, 0)    NOT NULL,
    SEMESTRE_ID      NUMBER(18, 0)    NOT NULL,
    CLAVE_GRUPO      CHAR(3)          NOT NULL,
    CONSTRAINT PK9 PRIMARY KEY (CURSO_ID), 
    CONSTRAINT RefPROFESOR7 FOREIGN KEY (PROFESOR_ID)
    REFERENCES PROFESOR(PROFESOR_ID),
    CONSTRAINT RefASIGNATURA22 FOREIGN KEY (ASIGNATURA_ID)
    REFERENCES ASIGNATURA(ASIGNATURA_ID),
    CONSTRAINT RefSEMESTRE23 FOREIGN KEY (SEMESTRE_ID)
    REFERENCES SEMESTRE(SEMESTRE_ID)
)
;



-- 
-- TABLE: HORARIO 
--

CREATE TABLE HORARIO(
    HORARIO_ID     NUMBER(18, 0)    NOT NULL,
    DIA_SEMANA     NUMBER(1, 0)     NOT NULL,
    HORA_INICIO    DATE             NOT NULL,
    HORA_FIN       DATE             NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY (HORARIO_ID)
)
;



-- 
-- TABLE: CURSO_HORARIO 
--

CREATE TABLE CURSO_HORARIO(
    CURSO_HORARIO_ID    NUMBER(18, 0)    NOT NULL,
    CURSO_ID            NUMBER(10, 0)    NOT NULL,
    HORARIO_ID          NUMBER(18, 0)    NOT NULL,
    CONSTRAINT PK10 PRIMARY KEY (CURSO_HORARIO_ID), 
    CONSTRAINT RefHORARIO19 FOREIGN KEY (HORARIO_ID)
    REFERENCES HORARIO(HORARIO_ID),
    CONSTRAINT RefCURSO20 FOREIGN KEY (CURSO_ID)
    REFERENCES CURSO(CURSO_ID)
)
;



-- 
-- TABLE: ESTUDIANTE_EXTRAORDINARIO 
--

CREATE TABLE ESTUDIANTE_EXTRAORDINARIO(
    ESTUDIANTE_ID    NUMBER(18, 0)    NOT NULL,
    NUM_EXAMEN       NUMBER(3, 0)     NOT NULL,
    CALIFICACION     NUMBER(3, 1)     NULL,
    ASIGNATURA_ID    NUMBER(10, 0)    NOT NULL,
    CONSTRAINT PK11 PRIMARY KEY (ESTUDIANTE_ID, NUM_EXAMEN), 
    CONSTRAINT RefESTUDIANTE25 FOREIGN KEY (ESTUDIANTE_ID)
    REFERENCES ESTUDIANTE(ESTUDIANTE_ID),
    CONSTRAINT RefASIGNATURA26 FOREIGN KEY (ASIGNATURA_ID)
    REFERENCES ASIGNATURA(ASIGNATURA_ID)
)
;



-- 
-- TABLE: ESTUDIANTE_INSCRITO 
--

CREATE TABLE ESTUDIANTE_INSCRITO(
    CURSO_ID                  NUMBER(10, 0),
    ESTUDIANTE_INSCRITO_ID    NUMBER(10, 0)    NOT NULL,
    ESTUDIANTE_ID             NUMBER(18, 0),
    CALIFICACION              NUMBER(2, 0),
    CONSTRAINT PK4 PRIMARY KEY (ESTUDIANTE_INSCRITO_ID), 
    CONSTRAINT RefCURSO12 FOREIGN KEY (CURSO_ID)
    REFERENCES CURSO(CURSO_ID),
    CONSTRAINT RefESTUDIANTE24 FOREIGN KEY (ESTUDIANTE_ID)
    REFERENCES ESTUDIANTE(ESTUDIANTE_ID)
)
;



