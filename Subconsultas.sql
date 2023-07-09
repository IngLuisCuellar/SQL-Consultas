-- Haciendo subconsultas --

SELECT DISTINCT BARRIO FROM tabla_de_vendedores;

SELECT * FROM tabla_de_clientes WHERE BARRIO
in ('Condesa','Del Valle', 'Contadero', 'Oblatos');

##Aplicando

SELECT * FROM tabla_de_clientes WHERE BARRIO
in (SELECT DISTINCT BARRIO FROM tabla_de_vendedores);

SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO 
FROM tabla_de_productos GROUP BY ENVASE;

SELECT X.ENVASE, X.PRECIO_MAXIMO FROM
(SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO 
FROM tabla_de_productos GROUP BY ENVASE) X
WHERE X.PRECIO_MAXIMO >= 10;

-- Ejercicio --

SELECT DNI, COUNT(*) FROM facturas
WHERE YEAR(FECHA_VENTA) = 2016
GROUP BY DNI
HAVING COUNT(*) > 2000;

-- Haciendo una consulta equivalente con subconsultas --

SELECT X.DNI, X.CONTADOR FROM 
(SELECT DNI, COUNT(*) AS CONTADOR FROM facturas
WHERE YEAR(FECHA_VENTA) = 2016
GROUP BY DNI) X WHERE X.CONTADOR > 2000;