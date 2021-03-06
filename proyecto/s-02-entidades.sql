--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  24/06/2020
--@Descripción:     Script para creación de entidades y sus constraints

--
PROMPT ### Conectando a ap_proy_admin ###
CONNECT ap_proy_admin/admin

-- Por si hay error, sabemos que podria marcar, continuamos
WHENEVER SQLERROR CONTINUE

--
PROMPT ### Eliminando tablas ###
DROP TABLE centro_operativo CASCADE CONSTRAINTS;
DROP TABLE refugio CASCADE CONSTRAINTS;
DROP TABLE clinica CASCADE CONSTRAINTS;
DROP TABLE oficina CASCADE CONSTRAINTS;
DROP TABLE sitio_web CASCADE CONSTRAINTS;
DROP TABLE empleado CASCADE CONSTRAINTS;
DROP TABLE grado CASCADE CONSTRAINTS;
DROP TABLE tipo_mascota CASCADE CONSTRAINTS;
DROP TABLE estado_mascota CASCADE CONSTRAINTS;
DROP TABLE mascota CASCADE CONSTRAINTS;
DROP TABLE historial_mascota CASCADE CONSTRAINTS;
DROP TABLE origen_mascota CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE adopcion CASCADE CONSTRAINTS;
DROP TABLE revision CASCADE CONSTRAINTS;
DROP TABLE revision_clinica CASCADE CONSTRAINTS;
DROP TABLE revision_refugio CASCADE CONSTRAINTS;

-- Por si hay error
WHENEVER SQLERROR EXIT

---
PROMPT ### Creando tablas ###

PROMPT ### Creando tabla centro_operativo ###
CREATE TABLE centro_operativo(
  codigo_centro_id    VARCHAR2(5)      NOT NULL,
  nombre              VARCHAR2(50)     NOT NULL,
  direccion           VARCHAR2(100)    NOT NULL,
  latitud             NUMBER(15, 6)     NOT NULL,
  longitud            NUMBER(15, 6)     NOT NULL,
  es_refugio          NUMBER(1, 0)     DEFAULT  0,
  es_clinica          NUMBER(1, 0)     DEFAULT  0,
  es_oficina          NUMBER(1, 0)     DEFAULT  0,
  gerente             NUMBER(10, 0)    NOT NULL,
  CONSTRAINT centro_operativo_pk PRIMARY KEY (codigo_centro_id),
  CONSTRAINT centro_operativo_es_refugio_chk CHECK( es_refugio IN (0,1) ),
  CONSTRAINT centro_operativo_es_clinica_chk CHECK( es_clinica IN (0,1) ),
  CONSTRAINT centro_operativo_es_oficina_chk CHECK( es_oficina IN (0,1) )
);

PROMPT ### Creando tabla refugio ###
CREATE TABLE refugio(
  codigo_centro_id    VARCHAR2(5)      NOT NULL,
  num_registro        VARCHAR2(20)     NOT NULL,
  capacidad_max       NUMBER(10, 0)    NOT NULL,
  logo_img            BLOB,
  lema                VARCHAR2(100)    DEFAULT 'Proteger, cuidar y amar',
  CONSTRAINT refugio_pk PRIMARY KEY (codigo_centro_id),
  CONSTRAINT refugio_codigo_centro_fk FOREIGN KEY (codigo_centro_id)
    REFERENCES centro_operativo(codigo_centro_id),
  CONSTRAINT refugio_num_registro_uk UNIQUE (num_registro)
);

PROMPT ### Creando tabla clinica ###
CREATE TABLE clinica(
  codigo_centro_id    VARCHAR2(5)     NOT NULL,
  hora_inicio         DATE            NOT NULL,
  hora_fin            DATE            NOT NULL,
  horas_servicio      AS  ( (hora_fin - hora_inicio) * 24 ) VIRTUAL,
  tel_clientes        VARCHAR2(11),
  tel_emergencias     VARCHAR2(11),
  CONSTRAINT clinica_pk PRIMARY KEY (codigo_centro_id),
  CONSTRAINT clinica_codigo_centro_fk FOREIGN KEY (codigo_centro_id)
    REFERENCES centro_operativo(codigo_centro_id)
);

PROMPT ### Creando tabla oficina ###
CREATE TABLE oficina(
  codigo_centro_id       VARCHAR2(5)      NOT NULL,
  rfc                    VARCHAR2(13)     NOT NULL,
  firma_electronica      BLOB,
  representante_legal    VARCHAR2(100)    NOT NULL,
  CONSTRAINT oficina_pk PRIMARY KEY (codigo_centro_id),
  CONSTRAINT oficina_codigo_centro_fk FOREIGN KEY (codigo_centro_id)
    REFERENCES centro_operativo(codigo_centro_id)
  --CONSTRAINT oficina_rfc_uk UNIQUE (rfc)
);

PROMPT ### Creando tabla sitio_web ###
CREATE TABLE sitio_web(
  sitio_web_id        NUMBER(10, 0)    GENERATED BY DEFAULT ON NULL AS IDENTITY
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOCYCLE,
  url                 VARCHAR2(50)     NOT NULL,
  codigo_centro_id    VARCHAR2(5),
  CONSTRAINT sitio_web_pk PRIMARY KEY (sitio_web_id),
  CONSTRAINT sitio_web_codigo_centro_fk FOREIGN KEY (codigo_centro_id)
    REFERENCES centro_operativo(codigo_centro_id)
);

PROMPT ### Creando tabla empleado ###
CREATE TABLE empleado(
  empleado_id          NUMBER(10, 0)    NOT NULL,
  curp                 VARCHAR2(18)     NOT NULL,
  fecha_ingreso        DATE             DEFAULT  SYSDATE,
  email                VARCHAR2(50)     NOT NULL,
  nombre               VARCHAR2(50)     NOT NULL,
  apellido_pat         VARCHAR2(50)     NOT NULL,
  apellido_mat         VARCHAR2(50),
  sueldo               NUMBER(7, 2)     NOT NULL,
  es_gerente           NUMBER(1, 0)     DEFAULT  0,
  es_veterinario       NUMBER(1, 0)     DEFAULT  0,
  es_administrativo    NUMBER(1, 0)     DEFAULT  0,
  codigo_centro_id     VARCHAR2(5),
  CONSTRAINT empleado_pk PRIMARY KEY (empleado_id),
  CONSTRAINT empleado_codigo_centro_fk FOREIGN KEY (codigo_centro_id)
    REFERENCES centro_operativo(codigo_centro_id),
  CONSTRAINT empleado_es_gerente_chk CHECK( es_gerente IN (0,1) ),
  CONSTRAINT empleado_es_veterinario_chk CHECK( es_veterinario IN (0,1) ),
  CONSTRAINT empleado_es_administrativo_chk CHECK( es_administrativo IN (0,1) )
  --CONSTRAINT empleado_curp_uk UNIQUE (curp)
);

ALTER TABLE centro_operativo ADD CONSTRAINT centro_operativo_gerente_fk
    FOREIGN KEY (gerente) REFERENCES empleado(empleado_id)
;

PROMPT ### Creando tabla grado ###
CREATE TABLE grado(
  grado_id        NUMBER(10, 0)    GENERATED BY DEFAULT ON NULL AS IDENTITY
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOCYCLE,
  cedula          NUMBER(8, 0),
  titulo          NUMBER(10, 0)    NOT NULL,
  fecha_titulo    DATE             NOT NULL,
  empleado_id     NUMBER(10, 0)    NOT NULL,
  CONSTRAINT grado_pk PRIMARY KEY (grado_id),
  CONSTRAINT grado_empleado_fk FOREIGN KEY (empleado_id)
    REFERENCES empleado(empleado_id),
  CONSTRAINT grado_titulo_uk UNIQUE (titulo)
);

PROMPT ### Creando tabla tipo_mascota ###
CREATE TABLE tipo_mascota(
  tipo_mascota_id    NUMBER(10, 0)    GENERATED BY DEFAULT ON NULL AS IDENTITY
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOCYCLE,
  nombre             VARCHAR2(50)     NOT NULL,
  subcategoria       VARCHAR2(50)     NOT NULL,
  cuidados           NUMBER(1, 0)     NOT NULL,
  CONSTRAINT tipo_mascota_pk PRIMARY KEY (tipo_mascota_id)
);

PROMPT ### Creando tabla estado_mascota ###
CREATE TABLE estado_mascota(
  estado_mascota_id    NUMBER(10, 0)   GENERATED BY DEFAULT ON NULL AS IDENTITY
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOCYCLE,
  descripcion          VARCHAR2(30)    NOT NULL,
  CONSTRAINT estado_mascota_pk PRIMARY KEY (estado_mascota_id)
);

PROMPT ### Creando tabla mascota ###
CREATE TABLE mascota(
  folio_mascota_id     VARCHAR2(8)      NOT NULL,
  nombre               VARCHAR2(50)     NOT NULL,
  fecha_ingreso        DATE             DEFAULT  SYSDATE,
  fecha_nacimiento     DATE             NOT NULL,
  causa_muerte         VARCHAR2(250),
  codigo_centro_id     VARCHAR2(5),
  tipo_mascota_id      NUMBER(10, 0)    NOT NULL,
  estado_mascota_id    NUMBER(10, 0)    NOT NULL,
  CONSTRAINT mascota_pk PRIMARY KEY (folio_mascota_id),
  CONSTRAINT mascota_codigo_centro_fk FOREIGN KEY (codigo_centro_id)
    REFERENCES centro_operativo(codigo_centro_id),
  CONSTRAINT mascota_tipo_mascota_fk FOREIGN KEY (tipo_mascota_id)
    REFERENCES tipo_mascota(tipo_mascota_id),
  CONSTRAINT mascota_estado_mascota_fk FOREIGN KEY (estado_mascota_id)
    REFERENCES estado_mascota(estado_mascota_id)
);

PROMPT ### Creando tabla historial_mascota ###
CREATE TABLE historial_mascota(
  historial_mascota_id    NUMBER(10, 0)    NOT NULL,
  folio_mascota_id        VARCHAR2(8)      NOT NULL,
  fecha                   DATE             DEFAULT  SYSDATE,
  estado_mascota_id       NUMBER(10, 0)    NOT NULL,
  CONSTRAINT historial_mascota_pk PRIMARY KEY (historial_mascota_id),
  CONSTRAINT historial_mascota_folio_mascota_fk FOREIGN KEY (folio_mascota_id)
    REFERENCES mascota(folio_mascota_id),
  CONSTRAINT historial_mascota_estado_mascota_fk FOREIGN KEY (estado_mascota_id)
    REFERENCES estado_mascota(estado_mascota_id)
);

PROMPT ### Creando tabla origen_mascota ###
CREATE TABLE origen_mascota(
  origen_mascota_id    NUMBER(10, 0)    NOT NULL,
  folio_mascota_id     VARCHAR2(8)      NOT NULL,
  tipo_origen          CHAR(1)          DEFAULT  'a',
  nombre_donador       VARCHAR2(100),
  mascota_madre_id     VARCHAR2(8),
  mascota_padre_id     VARCHAR2(8),
  CONSTRAINT origen_mascota_pk PRIMARY KEY (origen_mascota_id),
  CONSTRAINT origen_mascota_folio_mascota_fk FOREIGN KEY (folio_mascota_id)
    REFERENCES mascota(folio_mascota_id),
  CONSTRAINT origen_mascota_padre_fk FOREIGN KEY (mascota_padre_id)
    REFERENCES mascota(folio_mascota_id),
  CONSTRAINT origen_mascota_madre_fk FOREIGN KEY (mascota_madre_id)
    REFERENCES mascota(folio_mascota_id),
  CONSTRAINT origen_mascota_tipo_origen_chk CHECK( tipo_origen IN ('a','d','c') )
);

PROMPT ### Creando tabla cliente ###
CREATE TABLE cliente(
  id_cliente      NUMBER(10, 0)    NOT NULL,
  nombre          VARCHAR2(50)     NOT NULL,
  apellido_pat    VARCHAR2(50)     NOT NULL,
  apellido_mat    VARCHAR2(50),
  ocupacion       VARCHAR2(50),
  username        VARCHAR2(20)     NOT NULL,
  password        VARCHAR2(20)     NOT NULL,
  es_donador      NUMBER(1, 0)     DEFAULT  0,
  es_adoptante    NUMBER(1, 0)     DEFAULT  0,
  CONSTRAINT cliente_pk PRIMARY KEY (id_cliente),
  CONSTRAINT cliente_es_donador_chk CHECK( es_donador IN (0,1) ),
  CONSTRAINT cliente_es_adoptante_chk CHECK( es_adoptante IN (0,1) )
  --CONSTRAINT cliente_username_uk UNIQUE (username)
);

PROMPT ### Creando tabla adopcion ###
-- Estado adopcion
  -- 0: En proceso
  -- 1: Aprobado
  -- 2: Rechazado
CREATE TABLE adopcion(
  adopcion_id         NUMBER(10, 0)    NOT NULL,
  estado_solicitud    NUMBER(1, 0)     DEFAULT  0,
  razon               VARCHAR2(100),
  fecha               DATE,
  id_cliente          NUMBER(10, 0)    NOT NULL,
  folio_mascota_id    VARCHAR2(8)      NOT NULL,
  CONSTRAINT adopcion_pk PRIMARY KEY (adopcion_id),
  CONSTRAINT adopcion_cliente_fk FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente),
  CONSTRAINT adopcion_mascota_fk FOREIGN KEY (folio_mascota_id)
    REFERENCES mascota(folio_mascota_id),
  CONSTRAINT adopcion_estado_solicitud_chk CHECK( estado_solicitud IN (0,1,2) )
);

PROMPT ### Creando tabla revision ###
CREATE TABLE revision(
  folio_mascota_id    VARCHAR2(8)      NOT NULL,
  num_revision        NUMBER(10, 0)    NOT NULL,
  fecha               DATE             DEFAULT  SYSDATE,
  tipo_revision       CHAR(1)          DEFAULT  'r',
  codigo_centro_id    VARCHAR2(5)      NOT NULL,
  CONSTRAINT revision_pk PRIMARY KEY (folio_mascota_id, num_revision),
  CONSTRAINT revision_centro_operativo_fk FOREIGN KEY (codigo_centro_id)
    REFERENCES centro_operativo(codigo_centro_id),
  CONSTRAINT revision_mascota_fk FOREIGN KEY (folio_mascota_id)
    REFERENCES mascota(folio_mascota_id),
  CONSTRAINT revision_tipo_revision_chk CHECK( tipo_revision IN ('c', 'r') )
);

PROMPT ### Creando tabla revision_clinica ###
CREATE TABLE revision_clinica(
  folio_mascota_id    VARCHAR2(8)      NOT NULL,
  num_revision        NUMBER(10, 0)    NOT NULL,
  calificacion        NUMBER(2, 0)     NOT NULL,
  costo               NUMBER(5, 2)     NOT NULL,
  observaciones       VARCHAR2(500)    NOT NULL,
  CONSTRAINT revision_clinica_pk PRIMARY KEY (folio_mascota_id, num_revision),
  CONSTRAINT revision_clinica_revision_fk FOREIGN KEY (folio_mascota_id, num_revision)
    REFERENCES revision(folio_mascota_id, num_revision)
);

PROMPT ### Creando tabla revision_refugio ###
CREATE TABLE revision_refugio(
  folio_mascota_id    VARCHAR2(8)      NOT NULL,
  num_revision        NUMBER(10, 0)    NOT NULL,
  diagnostico         VARCHAR2(500)    NOT NULL,
  foto                BLOB,
  CONSTRAINT revision_refugio_pk PRIMARY KEY (folio_mascota_id, num_revision),
  CONSTRAINT revision_refugio_revision_fk FOREIGN KEY (folio_mascota_id, num_revision)
    REFERENCES revision(folio_mascota_id, num_revision)
);

--
PROMPT ### Listo s-02-entidades.sql ###

DISCONNECT
/
