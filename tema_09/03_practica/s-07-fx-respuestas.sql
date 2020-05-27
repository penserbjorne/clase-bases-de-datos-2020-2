--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  26/05/2020
--@Descripción:    Creación de usuarios

-- CONNECT paap_p0903_fx/paap;

/* Ejercicio 1 */

PROMPT ### Ejercicio 1

-- DROP TABLE consulta_1 CASCADE CONSTRAINTS;

CREATE TABLE consulta_1 AS
    SELECT id, nombre, clave, municipio,
        TO_CHAR(ultima_revision, 'dd/mm/yyyy HH24:MI:SS "hrs."') AS ULTIMA_REVISION
        FROM aeropuerto
        WHERE
            tipo = 'closed' AND
            ultima_revision
                BETWEEN TO_DATE('10/2012','mm/yyyy') AND TO_DATE('03/2015','mm/yyyy');

-- SELECT * FROM consulta_1;

/* Ejercicio 2 */

PROMPT ### Ejercicio 2

-- DROP TABLE consulta_2 CASCADE CONSTRAINTS;

CREATE TABLE consulta_2 AS
    SELECT id, nombre, municipio, region_iso,
        elevacion * 3.281 as ELEVACION_METROS
        FROM aeropuerto
        WHERE tipo='large_airport'
        ORDER BY ELEVACION_METROS DESC;
        
-- SELECT * FROM consulta_2;

/* Ejercicio 3 */

PROMPT ### Ejercicio 3

-- DROP TABLE consulta_3 CASCADE CONSTRAINTS;

CREATE TABLE consulta_3 AS
    SELECT nombre, 
        TRUNC(ABS( (latitud/90) * 10002.29 ), 4) AS LAT_CARTESIANA, 
        TRUNC(ABS( (longitud/90) * 10002.29), 4) AS LONG_CARTESIANA,
        TRUNC(latitud, 4) AS LATITUD_GRADOS,
        TRUNC(longitud, 4) AS LONGITUD_GRADOS
        FROM aeropuerto
        WHERE
            region_iso = 'MX-OAX';

-- SELECT * FROM consulta_3;

/* Ejercicio 4 */

PROMPT ### Ejercicio 4

-- DROP TABLE consulta_4 CASCADE CONSTRAINTS;

CREATE TABLE consulta_4 AS
    SELECT a2.nombre, a2.tipo,
        a1.latitud AS LATITUD_BENITO,
        a1.longitud AS LONGITUD_BENITO,
        a2.latitud AS LATITUD_OTRO,
        a2.longitud AS LONGITUD_OTRO,
        TRUNC(
            SQRT(
                POWER(
                    TRUNC(ABS( (a1.latitud/90) * 10002.29 ), 5)
                    -
                    TRUNC(ABS( (a2.latitud/90) * 10002.29 ), 5)
                    ,2
                ) +
                POWER(
                    TRUNC(ABS( (a1.longitud/90) * 10002.29), 5)
                    -
                    TRUNC(ABS( (a2.longitud/90) * 10002.29), 5)
                    ,2
                )
            ), 5
        ) AS distancia
    FROM aeropuerto a1, aeropuerto a2
    WHERE a1.id = 4731          -- aeropuerto Benito Juárez.
    AND a2.region_iso = 'MX-DIF'
    AND a2.id <> 4731           -- a2 no debe ser el mismo aeropuerto Benito Juarez ya que la
                                -- distancia sería cero.
    AND a2.tipo <> 'closed'     -- excluir a los aeropuertos cerrados.
    ORDER BY distancia ASC;

-- SELECT * FROM consulta_4;

-- select * from CONSULTA_4;
-- select * from CONSULTA_R4;
-- select * from CONSULTA_4 minus select * from CONSULTA_R4;

/* Ejercicio 5 */

PROMPT ### Ejercicio 5

-- DROP TABLE consulta_5 CASCADE CONSTRAINTS;

CREATE TABLE consulta_5 AS
    SELECT id, clave, nombre, municipio, codigo_gps, codigo_iata,
        TO_CHAR(ultima_revision, 'FMday"," month dd "of" yyyy "at" hh24:mi:ss')
        AS ULTIMA_REVISION
        FROM aeropuerto
        WHERE
            region_iso = 'MX-CHP';

-- SELECT * FROM consulta_5;

-- select * from CONSULTA_5;
-- select * from CONSULTA_R5;
-- select * from CONSULTA_5 minus select * from CONSULTA_R5;

/* Ejercio 6 */

PROMPT ### Ejercicio 6

ALTER SESSION SET nls_language=spanish;

-- DROP TABLE consulta_6 CASCADE CONSTRAINTS;

CREATE TABLE consulta_6 AS
    SELECT id,
        TO_CHAR(ultima_revision, 'dd/FMmonth/yyyy') AS ULTIMA_REVISION,
        TO_DATE('01/01/2018', 'dd/mm/yy') - TRUNC(ultima_revision) AS FALTAN
        FROM aeropuerto
        WHERE
            TO_CHAR(ultima_revision, 'dd/mm') = '10/12' OR
            TO_CHAR(ultima_revision, 'dd/mm') = '15/12'
        ORDER BY FALTAN DESC;

ALTER SESSION SET nls_language=american;

-- SELECT * FROM consulta_6;

/* Ejercicio 7 */

PROMPT ### Ejercicio 7

-- DROP TABLE consulta_7 CASCADE CONSTRAINTS;

CREATE TABLE consulta_7 AS
    SELECT 
        UNIQUE DECODE(UPPER(tipo), 'HELIPORT',  'H',
                            'CLOSED',           'C',
                            'SMALL_AIRPORT',    'S',
                            'LARGE_AIRPORT',    'L',
                            'MEDIUM_AIRPORT',   'M', 
                            'SEAPLANE_BASE',    'B') AS CLAVE_TIPO,
        UPPER(tipo) AS TIPO
        FROM aeropuerto;

-- SELECT * FROM consulta_7;

/* Ejercicio 8 */

PROMPT ### Ejercicio 8

-- DROP TABLE consulta_8 CASCADE CONSTRAINTS;

CREATE TABLE consulta_8 AS
    SELECT
        TO_CHAR(
            LPAD(id, 6, '0')
            || '-'
            || SUBSTR(region_iso,4, 3)
            || '-'
            || SUBSTR(UPPER(municipio), (LENGTH(UPPER(municipio)) - 1), 2)
        )
        AS FOLIO,
        region_iso, municipio, wikipedia_link
        FROM aeropuerto
        WHERE
            wikipedia_link IS NOT NULL;
            
-- SELECT * FROM consulta_8;


/* Ejercicio 9 */

PROMPT ### Ejercicio 9

--DROP TABLE consulta_9 CASCADE CONSTRAINTS;

CREATE TABLE consulta_9 AS
    SELECT
        TO_CHAR(
            LPAD(id, 6, '0')
            || '-'
            || SUBSTR(region_iso,4, 3)
            || '-'
            || SUBSTR(
                        NVL(UPPER(municipio), 'NNNN'),
                        (LENGTH( NVL(UPPER(municipio), 'NNNN') ) - 1),
                        2
                    )
        )
        AS FOLIO,
        region_iso, municipio, wikipedia_link
        FROM aeropuerto
        WHERE
            wikipedia_link IS NOT NULL;

-- SELECT * FROM consulta_9;

/* Ejercicio 10 */

PROMPT ### Ejercicio 10

--DROP TABLE consulta_10 CASCADE CONSTRAINTS;

CREATE TABLE consulta_10 AS
    SELECT nombre,
        pagina_web,
        SUBSTR(
            pagina_web,
            NULLIF(
                    INSTR(pagina_web, '?', 1, 1),
                    0
                ) + 1,
            LENGTH(pagina_web)
            )
        AS PARAMETROS
        FROM aeropuerto
        WHERE
            pagina_web IS NOT NULL;
            
-- SELECT * FROM consulta_10;

/* Ejercicio 11 */

PROMPT ### Ejercicio 11

-- DROP TABLE consulta_11 CASCADE CONSTRAINTS;

CREATE TABLE consulta_11 AS
    SELECT nombre, municipio,
        SUBSTR(
            wikipedia_link,
            INSTR(wikipedia_link, '/', 1, 4),
            LENGTH(wikipedia_link)
            )
        AS PATH,
        LENGTH(nombre)
        +
        NVL(
            LENGTH(municipio),
            0
        )
        +
        NVL(
            LENGTH(
                SUBSTR(
                    wikipedia_link,
                    INSTR(wikipedia_link, '/', 1, 4),
                    LENGTH(wikipedia_link)
                    )
            ),
            0
        )
        AS TOTAL_LONGITUD
        FROM aeropuerto
        WHERE
            tipo = 'small_airport' AND
            region_iso = 'MX-BCS';
    
-- SELECT * FROM consulta_11;