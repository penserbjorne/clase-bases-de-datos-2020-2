--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  12/06/2020
--@Descripción:    Respuestas de la practica

/*
1. Genere un reporte que muestre nombre del artículo, clave, clave del status de
todos los artículos donados por el artista ‘William Harvey’. Emplear
sintaxis estándar.

R: Se deben obtener 3 registros.
*/

create table consulta_1 as
select a.nombre, a.clave_articulo, s.clave
  from status_articulo s
  join articulo a
    on a.status_articulo_id = s.status_articulo_id
  join articulo_famoso af
    on a.articulo_id = af.articulo_id
  where af.nombre_completo = 'William Harvey'
;


/*
2. Generar un reporte que muestre el id, nombre y clave de todos los artículos que
hayan sido entregados al cliente (status= ENTREGADO, no emplear
el id del status) en cualquier subasta y que hayan sido donados por 'BELGICA'.
Emplear natural join.

R: Se deben obtener 2 registros.
*/

create table consulta_2 as
select articulo_id, nombre, clave_articulo
  from status_articulo s
  join articulo a
    using(status_articulo_id)
  natural join articulo_donado
  join pais p
    using(pais_id)
  where s.clave = 'ENTREGADO'
    and p.descripcion = 'BELGICA'
;

/*
3. Empleando natural join, generar un reporte que muestre el id, nombre, precio
inicial, precio de venta y tipo de artículo, así como el nombre y fecha
inicio de la subasta de todos los artículos que compró el cliente MARICELA PAEZ
MARTINEZ durante las subastas realizadas en el 2010. Nota: Un
artículo se considera comprado cuando se registra el cliente que lo adquirió y
se registra el precio de venta. Para el caso de la fecha de inicio emplear
el formato como se indica en los siguientes ejemplos. Emplear como nombre de
columna fecha_inicio
2019/10/24 10:16:44 PM Para fechas después de las 12 PM
2019/10/25 10:19:03 AM Para fechas antes de las 12 PM

R: Se deben obtener el artículo con id 167
*/

create table consulta_3 as
select articulo_id, a.nombre, precio_inicial, precio_venta, tipo_articulo,
    s.nombre as NOMBRE_SUBASTA,
    to_char(fecha_inicio,'yyyy/mm/dd hh:mi:ss AM') as FECHA_INICIO
  from subasta s
  join articulo a
    using(subasta_id)
  natural join subasta_venta
  join cliente c
    using(cliente_id)
  where c.nombre = 'MARICELA'
    and c.apellido_paterno = 'PAEZ'
    and c.apellido_materno = 'MARTINEZ'
    and s.fecha_inicio between to_date('01/01/2010','dd/mm/yyyy')
    and to_date('31/12/2010','dd/mm/yyyy')
;
--Duda AM o PM


/*
4. Generar un reporte que muestre los datos de los clientes (id, nombre y apellidos)
y los datos de sus tarjetas (número de tarjeta, tipo, año de vigencia,
mes de vigencia) que ya hayan expirado. Notas:
a. para validar si ya la tarjeta expiró emplear el mes y año de vigencia.
b. Considerar que la consulta se ejecuta en noviembre del 2011
c. Si una tarjeta tiene mismo año y mes de expiración los valores 11/11, la
tarjeta aún se considera como vigente.

R: Se deben obtener 16 registros.
*/

create table consulta_4 as
select c.cliente_id, c.nombre, c.apellido_paterno, c.apellido_materno,
    t.numero_tarjeta, t.tipo_tarjeta, t.anio_vigencia, t.mes_vigencia
  from cliente c, tarjeta_cliente t
  where c.cliente_id = t.cliente_id
    and to_date(t.mes_vigencia||'-'||t.anio_vigencia,'mm-yy')
        <=
        to_date('11/11','mm/yy')
;

/*
5. Generar un reporte que muestre: identificador del artículo, nombre, clave, tipo,
año de hallazgo precio inicial y precio venta (para los que ya fueron
vendidos o entregados) de todos los artículos que sean de tipo arqueológico, y
que tengan un precio inicial mayor a $800,000. Emplear notación
SQL estándar.

R: Se deben obtener 10 registros de los cuales 3 ya fueron vendidos.
*/

create table consulta_5 as
select a.articulo_id, a.nombre, a.clave_articulo, a.tipo_articulo,
    aa.anio_hallazgo, a.precio_inicial, s.precio_venta
  from subasta_venta s
  right outer join articulo a
    on s.articulo_id =  a.articulo_id
  join articulo_arqueologico aa
    on a.articulo_id = aa.articulo_id
  where  a.tipo_articulo = 'A'
    and a.precio_inicial >= 800000
;


/*
6. Generar un reporte que muestre nombre, apellidos, email, de todos los clientes
cuya ocupación sea ABOGADO, y en caso de tener registrado una o
más tarjetas de crédito, incluir el tipo de tarjeta. Emplear notación SQL
anterior compatible con Oracle.

R: Se deben obtener 5 clientes, uno de ellos cuenta con 2 tarjetas.
*/

create table consulta_6 as
select c.nombre, c.apellido_paterno, c.apellido_materno, c.email,
    c.ocupacion, tc.tipo_tarjeta
  from cliente c, tarjeta_cliente tc
  where c.cliente_id = tc.cliente_id(+)
  and c.ocupacion = 'ABOGADO'
;



/*
7. Suponga que se desea retirar del catálogo a todos los artículos que tengan un
precio inicial de más de 900,000, siempre y cuando el artículo todavía
no inicie el proceso de subasta, es decir, el artículo no debe tener status
EN SUBASTA, ENTREGADO O VENDIDO. Empleando operadores del álgebra
relacional (operadores SET: union, intersection, minus), determine el id,
nombre, clave, precio inicial y e identificador del status de los
artículos que se deben retirar.

R: Se deben obtener 6 artículos, verificar su precio.
*/

create table consulta_7 as
select articulo_id, nombre, clave_articulo, precio_inicial, status_articulo_id
  from articulo
  where precio_inicial > 900000
  minus
  (
    select articulo_id, nombre, clave_articulo, precio_inicial, a.status_articulo_id
      from articulo a
      join status_articulo s
        on a.status_articulo_id = s.status_articulo_id
      where s.clave = 'ENTREGADO'
    union
    select articulo_id, nombre, clave_articulo, precio_inicial, a.status_articulo_id
      from articulo a
      join status_articulo s
        on a.status_articulo_id = s.status_articulo_id
      where s.clave = 'EN SUBASTA'
    union
    select articulo_id, nombre, clave_articulo, precio_inicial, a.status_articulo_id
      from articulo a
      join status_articulo s
        on a.status_articulo_id = s.status_articulo_id
      where s.clave = 'VENDIDO'
  )
;
/*
8. SUBMEX ha decido incrementar en un 10% el precio inicial de todos aquellos
artículos arqueológicos que tengan más de 150 años de antigüedad y
que aún no se han incluido en un proceso de subasta, es decir, solo se han
registrado en la BD. Determine
id, clave, nombre, id de status, año dehallazgo, y antigüedad en años
de dichos artículos.

R: Se deben obtener al menos 7 artículos.
*/

create table consulta_8 as
select a.articulo_id, a.clave_articulo, a.nombre, a.status_articulo_id,
    aa.anio_hallazgo, to_char(sysdate,'yyyy')-aa.anio_hallazgo as "Antigüedad"
  from articulo a
  join articulo_arqueologico aa
    on a.articulo_id = aa.articulo_id
  join status_articulo s
    on s.status_articulo_id = a.status_articulo_id
  where s.clave = 'REGISTRADO'
    and to_char(sysdate,'yyyy')-aa.anio_hallazgo > 150
;

/*
9. Suponga que un cliente decide realizar una consulta en el catálogo de artículos.
El cliente está interesado por todos aquellos artículos cuyo nombre
o descripción hagan referencia o hablen de la palabra “Colonial” que no han sido
aún vendidos, y que el articulo este en proceso de ser subastado.
Generar la sentencia SQL que muestre el nombre y tipo de todos los artículos que
cumplan con los criterios de búsqueda.

R: Se debe obtener 1 registro.
*/

create table consulta_9 as
select a.nombre, a.tipo_articulo
  from articulo a
  join status_articulo s
    on a.status_articulo_id = s.status_articulo_id
  where
    (
      instr(a.nombre,'Colonial') > 0
      or
      instr(a.descripcion,'Colonial') > 0
    )
    and s.clave <> 'REGISTRADO'
;

/*
10. Suponga que se desea generar un reporte a detalle de todos los artículos que
fueron comprados y pagados con la tarjeta de crédito
5681375824866375. Los datos que el reporte debe mostrar son los siguientes:
a. Fecha de la factura en formato dd/mm/yyyy, emplear 'fecha_factura' como
nombre de columna.
b. Numero de la tarjeta
c. Nombre y apellidos del cliente
d. Precio de venta de cada articulo
e. Precio de compra de cada articulo
f. Diferencia entre el precio de compra y el de venta
g. Nombre y clave del artículo
h. Tipo de artículo
i.Nombre completo del famoso al que perteneció el articulo (en caso de ser
articulo perteneciente a un famoso)
j.Año de hallazgo, en caso de que el artículo sea arqueológico.
k. Clave del país, en caso de que el articulo haya sido donado por dicho país.
Emplear Notación estándar

R: Se deben obtener 4 registros.
*/

create table consulta_10 as
select to_char(fc.fecha_factura,'dd/mm/yyyy') as "fecha_factura",
    tc.numero_tarjeta, c.nombre as NOMBRE_CLIENTE,c.apellido_paterno,
    c.apellido_materno, sv.precio_venta, a.precio_inicial,
    sv.precio_venta-a.precio_inicial as DIFERENCIA, a.nombre as NOBRE_ARTICULO,
    a.clave_articulo,   a.tipo_articulo, af.nombre_completo, aa.anio_hallazgo,
    p.clave
  from factura_cliente fc
  join tarjeta_cliente tc
    on fc.tarjeta_cliente_id = tc.tarjeta_cliente_id
  join cliente c
    on tc.cliente_id = c.cliente_id
  right join subasta_venta sv
    on fc.factura_cliente_id = sv.factura_cliente_id
  right join articulo a
    on a.articulo_id  = sv.articulo_id
  left join articulo_famoso af
    on af.articulo_id = a.articulo_id
  left join articulo_arqueologico aa
    on aa.articulo_id = a.articulo_id
  left join articulo_donado ad
    on ad.articulo_id = a.articulo_id
  left join pais p
    on p.pais_id = ad.pais_id
  where tc.numero_tarjeta = 5681375824866375
;


/*
11. Reescribir la consulta anterior pero ahora empleando notación anterior
compatible con Oracle.

R: Se deben obtener 4 registros.
*/

create table consulta_11 as
select to_char(fc.fecha_factura,'dd/mm/yyyy') as "fecha_factura",
    tc.numero_tarjeta, c.nombre as NOMBRE_CLIENTE,c.apellido_paterno,
    c.apellido_materno, sv.precio_venta, a.precio_inicial,
    sv.precio_venta-a.precio_inicial as DIFERENCIA, a.nombre as NOBRE_ARTICULO,
    a.clave_articulo,   a.tipo_articulo, af.nombre_completo, aa.anio_hallazgo,
    p.clave
  from factura_cliente fc, tarjeta_cliente tc, cliente c, subasta_venta sv,
    articulo a, articulo_famoso af, articulo_arqueologico aa, articulo_donado ad,
    pais p
  where fc.tarjeta_cliente_id = tc.tarjeta_cliente_id
    and tc.cliente_id = c.cliente_id
    and fc.factura_cliente_id(+)  = sv.factura_cliente_id
    and a.articulo_id  = sv.articulo_id(+)
    and af.articulo_id(+) = a.articulo_id
    and aa.articulo_id(+) = a.articulo_id
    and ad.articulo_id(+) = a.articulo_id
    and p.pais_id(+) = ad.pais_id
    and tc.numero_tarjeta = 5681375824866375
;
