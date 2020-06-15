--@Autor(es):       Paul Aguilar, Ana Laura Pérez Bueno
--@Fecha creación:  12/06/2020
--@Descripción:    Creación de usuarios

--PROMPT ### Conectando al usuario paap_p1101_subastas
--CONNECT paap_p1101_subastas/paap;

/*
1. Seleccionar el número total de artículos que pertenecen a las subastas del 2010,
así como el total de los ingresos obtenidos en las subastas del 2010.
Emplear como nombres de columnas: num_articulos, ingresos. Emplear sintaxis
estándar.

R: Se han vendido 309 artículos
*/

create table consulta_1 as
select count(*) as total_articulos, sum(sv.precio_venta) as total
  from subasta s
  join articulo a
    on s.subasta_id = a.subasta_id
  left join subasta_venta sv
    on sv.articulo_id = a.articulo_id
  where s.fecha_inicio between
    to_date('01/01/2010','dd/mm/yyyy')
    and
    to_date('31/12/2010','dd/mm/yyyy')
;

/*
2. Mostrar el total de artículos que no fueron vendidos en las subastas del 2010

R: El resultado debe estar entre 187 y 190
*/

create table consulta_2 as
select count(*) as total_articulos
  from subasta s
  join articulo a
      on s.subasta_id=a.subasta_id
  join status_articulo sa
      on a.status_articulo_id = sa.status_articulo_id
  where s.fecha_inicio between to_date('01/01/2010','dd/mm/yyyy')
      and to_date('31/12/2010','dd/mm/yyyy')
      and sa.clave not in ('VENDIDO', 'ENTREGADO')
;

/*
3.Generar una consulta que contenga las siguientes columnas considerando
únicamente a la subasta ‘EXPO-MAZATLAN’
Precio inicial del artículo más barato ARTICULO.PRECIO_INICIAL
Precio Inicial más caro
Precio de venta más barato,         SUBASTA_VENTA.PRECIO_VENTA
Precio de venta más caro

R: El resultado es un solo registro con las 4 columnas anteriores, el precio más
barato de compra es 34001.52.
*/

create table consulta_3 as
select min(a.precio_inicial) as "Precio inicial más barato",
    max(a.precio_inicial) as "Precio inicial más caro",
    min(sv.precio_venta) as "Precio venta más barato",
    max(sv.precio_venta) as "Precio venta más caro"
  from subasta s
  join articulo a
      on a.subasta_id = s.subasta_id
  join subasta_venta sv
      on a.articulo_id = sv.articulo_id
  where s.nombre = 'EXPO-MAZATLAN'
;

/*
4. Se ha detectado que en la base de datos existen clientes nacidos entre los
años 1970 y 1975 que tienen registrada al menos una tarjeta de crédito,
pero que no han comprado artículos en las subastas. Generar un reporte que
muestre el identificador, el email y el número de tarjeta de dichos
clientes. Tip: Los clientes que no han comprado artículos no tienen registro en
subasta_venta.

R: Se obtiene un solo registro.
*/


create table consulta_4 as
select c.cliente_id, c.email, tc.numero_tarjeta
  from  tarjeta_cliente tc
  join cliente c
    on tc.cliente_id = c.cliente_id
  where
    c.fecha_nacimiento between
    to_date('01/01/1970','dd/mm/yyyy') and to_date('31/12/1975','dd/mm/yyyy')
    and c.cliente_id not in
    (
        select cliente_id
        from subasta_venta
    )
;

/*
5. Se desea generar un reporte estadístico que contenga la cantidad de artículos
que hayan sido vendidos o entregados para cada uno de los tipos
existentes. Genere una sentencia SQL que genere el reporte solicitado mostrando
el número de artículos, el tipo de artículo y la clave del status.

R: Se deben obtener 6 registros.
*/

create table consulta_5 as
select count(*) as num_articulos, a.tipo_articulo, s.clave
  from articulo a, status_articulo s
  where s.status_articulo_id = a.status_articulo_id
    and s.clave in ('VENDIDO','ENTREGADO')
  group by a.tipo_articulo,s.clave
;

/*
6. Suponga que se desea generar un reporte anual que muestre los totales
recaudados en cada subasta realizada en el 2009, y por cada tipo de artículo.
Genere un reporte que muestre, el nombre de la subasta, la fecha de inicio, el
lugar en la que se realizó, el tipo de articulo y el monto total recaudado
ordenadas del mayor al menor monto obtenido Emplear notación SQL estándar.

R: Se deben obtener 18 registros.
*/

create table consulta_6 as
select s.nombre, s.fecha_inicio, s.lugar, a.tipo_articulo,
    sum(sv.precio_venta) as monto_total
  from subasta s
  join articulo a
    on s.subasta_id = a.subasta_id
  join subasta_venta sv
    on sv.articulo_id = a.articulo_id
  where s.fecha_inicio between
    to_date('01/01/2009','dd/mm/yyyy') and to_date('31/12/2009','dd/mm/yyyy')
  group by s.nombre, s.fecha_inicio, s.lugar, a.tipo_articulo
  order by 5 desc
;

/*
7. La empresa desea regalar un artículo a todos los clientes que cumplan con
alguna de las siguientes condiciones:
a. Que el cliente haya comprado más de 5 productos desde que se registró en la
base de datos.
b. Que el monto total de todos los productos que haya comprado supere a los
$3,000,000.
Generar una sentencia SQL empleando operadores del álgebra relacional
(Set operators). Determine id, nombre, apellidos, numero de productos
comprados y monto total.

R: Los montos totales y el número de artículos son:
TOTAL NUM_ARTICULOS
========== =============
4487933.17 6
3542077.21 4
3034465.63 4
3421015.72 5
3083806.95 4
3859436.78 4
3116215.04 5
3481850.47 6
*/

create table consulta_7 as
select  c.cliente_id, c.nombre, c.apellido_paterno, c.apellido_materno,
    count(*) as num_articulos, sum(sv.precio_venta) as total
  from cliente c
  join subasta_venta sv
    on c.cliente_id = sv.cliente_id
  group by  c.cliente_id, c.nombre, c.apellido_paterno, c.apellido_materno
  having count(*) > 5
union
select  c.cliente_id, c.nombre, c.apellido_paterno, c.apellido_materno,
    count(*) as num_articulos, sum(sv.precio_venta) as total
  from cliente c
  join subasta_venta sv
    on c.cliente_id = sv.cliente_id
  group by  c.cliente_id, c.nombre, c.apellido_paterno, c.apellido_materno
  having sum(sv.precio_venta) > 3000000
;

/*
8. Para cada una de las subastas que se realizaron durante los meses enero,
marzo y junio del 2010, mostrar id, nombre, fecha inicio de la subasta, así
como el nombre y clave del artículo más caro (precio venta) que se haya vendido
o entregado.

R: Se deben obtener 11 registros.
*/

create table consulta_8 as
select s.subasta_id, s.nombre as nombre_subasta, s.fecha_inicio, a.nombre,
    a.clave_articulo, q1.mas_caro
  from
  (
    select s.subasta_id, s.nombre, s.fecha_inicio,
        max(sv.precio_venta) as mas_caro
      from subasta s, articulo a, subasta_venta sv
      where s.subasta_id = a.subasta_id
      and sv.articulo_id = a.articulo_id(+)
      and
      (
        s.fecha_inicio between
        to_date('01/01/2010','dd/mm/yyyy') and to_date('31/01/2010','dd/mm/yyyy')
        or s.fecha_inicio between
        to_date('01/03/2010','dd/mm/yyyy') and to_date('31/03/2010','dd/mm/yyyy')
        or s.fecha_inicio between
        to_date('01/06/2010','dd/mm/yyyy') and to_date('30/06/2010','dd/mm/yyyy')
      )
      group by s.subasta_id, s.nombre, s.fecha_inicio
  ) q1, articulo a, subasta_venta sv, subasta s
  where a.subasta_id = s.subasta_id
    and sv.articulo_id = a.articulo_id
    and
    (
      s.fecha_inicio between
      to_date('01/01/2010','dd/mm/yyyy') and to_date('31/01/2010','dd/mm/yyyy')
      or s.fecha_inicio between
      to_date('01/03/2010','dd/mm/yyyy') and to_date('31/03/2010','dd/mm/yyyy')
      or s.fecha_inicio between
      to_date('01/06/2010','dd/mm/yyyy') and to_date('30/06/2010','dd/mm/yyyy')
    )
    and sv.precio_venta = q1.mas_caro
;

/*
9. Calcular el monto total de la última factura del cliente GALILEA GOMEZ GONZALEZ.

R: Se debe obtener $ 1765264.89
*/
create table consulta_9 as
select sum(sv.precio_venta) as monto_total
  from cliente c
  join subasta_venta sv
    on c.cliente_id = sv.cliente_id
  join factura_cliente fc
    on fc.factura_cliente_id = sv.factura_cliente_id
  where fc.fecha_factura =
  (
    select max(fc.fecha_factura)
      from cliente c
      join subasta_venta sv
        on c.cliente_id = sv.cliente_id
      join factura_cliente fc
        on fc.factura_cliente_id = sv.factura_cliente_id
      where c.nombre = 'GALILEA'
        and c.apellido_paterno = 'GOMEZ'
        and c.apellido_materno = 'GONZALEZ'
  )
;

/*
10. Suponga que, para el próximo año, la empresa va a repetir la misma ronda de
subastas por el éxito que tuvieron durante el 2010 a excepto de todas
aquellas que hayan vendido 3 o menos artículos. Determinar id de la subasta,
nombre, número de artículos vendidos de las subastas que podrán ser
repetidas ordenadas por id.

R: Se deben obtener 11 subastas.
*/

create table consulta_10 as
select q1.subasta_id, s.nombre, q1.num_articulos
  from
  (
    select s.subasta_id, count(*) as num_articulos
      from subasta s, articulo a, subasta_venta sv
      where s.subasta_id = a.subasta_id
        and a.articulo_id = sv.articulo_id
      group by s.subasta_id
      having count(*) > 3
  ) q1, subasta s
  where q1.subasta_id = s.subasta_id
    and s.fecha_inicio between
      to_date('01/01/2010','dd/mm/yyyy') and to_date('31/12/2010','dd/mm/yyyy')
  order by 1 asc
;

/*
11. En julio del 2010 la empresa lanzó una promoción de venta de Motocicletas en
sus subastas. Se desea generar un reporte que muestre los siguientes
datos:
a. Identificador de la subasta, fecha de inicio, identificador del artículo,
nombre del artículo, precio inicial del artículo de todas las
motocicletas que se vendieron o entregaron a un cliente en las subastas que se
realizaron en el periodo que duró la promoción.
b. Agregar una columna más al reporte (columna de referencia), que indique el
promedio del precio inicial de todas las motocicletas
considerando todo el año 2010 sin importar si estas fueron vendidas o entregadas
a un cliente.

R: Se debe obtener solo un artículo con id = 386,
promedio general = 412386.15208333335
*/

create table consulta_11 as
select s.subasta_id, s.fecha_inicio, a.articulo_id,
     a.nombre as "NOMBRE DEL ARTICULO", a.precio_inicial as "PRECIO INICIAL",
    (
        select avg(a.precio_inicial)
            from articulo a, subasta s
            where a.subasta_id = s.subasta_id
                and s.fecha_inicio between
                    to_date('01/01/2010','dd/mm/yyyy') and to_date('31/12/2010','dd/mm/yyyy')
                and instr(a.nombre,'Motocicleta') > 0
    ) as PROMEDIO
    from subasta_venta sv, articulo a, subasta s, status_articulo sa
    where sv.articulo_id = a.articulo_id
        and a.subasta_id = s.subasta_id
        and sa.status_articulo_id = a.status_articulo_id
        and (sa.clave = 'VENDIDO' or sa.clave = 'ENTREGADO')
        and s.fecha_inicio between
            to_date('01/07/2010','dd/mm/yyyy') and to_date('31/07/2010','dd/mm/yyyy')
        and instr(a.nombre,'Motocicleta') > 0
;

/*
12. La empresa decide reconocer a ciertos países por su buena participación:
Generar un reporte con todos los datos de los países que han donado 3 o
más artículos con un precio de venta inicial mayor a $300,000

R: Se deben obtener 2 países.
*/

create table consulta_12 as
select p.*
  from
  (
    select p.pais_id, count(*) as num_donaciones
      from articulo_donado ad, pais p, articulo a
      where ad.pais_id = p.pais_id
        and a.articulo_id = ad.articulo_id
        and a.precio_inicial > 300000
      group by p.pais_id
      having count(*) > 2
  ) q1, pais p
  where  p.pais_id = q1.pais_id
;

/*
13. Generar una consulta que determine el id, nombre, fecha inicio e importe
total de ventas de las subastas que durante el año 2010 hayan logrado
obtener $3,000,000 o más en ventas.
R: Se deben obtener 5 subastas.
*/

create table consulta_13 as
select s.subasta_id, s.nombre, s.fecha_inicio,
    sum(sv.precio_venta) as total_ventas
  from subasta s
  join articulo a
    on a.subasta_id = s.subasta_id
  join subasta_venta sv
    on a.articulo_id = sv.articulo_id
  where s.fecha_inicio between
    to_date('01/01/2010','dd/mm/yyyy') and to_date('31/12/2010','dd/mm/yyyy')
  group by s.subasta_id, s.nombre, s.fecha_inicio
  having sum(sv.precio_venta) >= 3000000
;


/*
14. Se ha detectado que en la base de datos existen compras realizadas por
algunos clientes sin factura con montos de más de $1,000,000, ya que la
empresa tiene como política, que toda compra igual o superior a dicho monto,
debe generar factura. Determine una sentencia SQL que muestre
nombre, apellidos, y el total del monto a cubrir, con la finalidad de
notificarle al cliente la inexistencia de su factura.

R: Se deben obtener 6 registros.
*/

create table consulta_14 as
select c.nombre, c.apellido_paterno, c.apellido_materno,
    sum(sv.precio_venta) as total_monto
  from cliente c
  join subasta_venta sv
    on c.cliente_id = sv.cliente_id
  where sv.factura_cliente_id is null
  group by c.nombre, c.apellido_paterno, c.apellido_materno
  having sum(sv.precio_venta) >1000000
;

/*
15. Seleccionar todos los datos de la subasta que ha vendido el mayor número de
artículos registrada en la base de datos.

R: La subasta que más vendió se realizó en Cuernavaca y vendió 6 artículos.
*/

create table consulta_15 as
select s.*
  from
  (
    select s.subasta_id, count(*) as total_articulos
      from subasta s
      join articulo a
        on s.subasta_id=a.subasta_id
      join status_articulo sa
        on a.status_articulo_id= sa.status_articulo_id
      where sa.clave in ('VENDIDO', 'ENTREGADO')
      group by s.subasta_id
      having count(*) =
      (
        select max(q1.total_articulos)
          from
          (
            select s.subasta_id, count(*) as total_articulos
              from subasta s
              join articulo a
                on s.subasta_id=a.subasta_id
              join status_articulo sa
                on a.status_articulo_id= sa.status_articulo_id
              where sa.clave in ('VENDIDO', 'ENTREGADO')
              group by s.subasta_id
          ) q1 , subasta s
          where q1.subasta_id = s.subasta_id
      )
  ) q2, subasta s
  where q2.subasta_id = s.subasta_id
;
