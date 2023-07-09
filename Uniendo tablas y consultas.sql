-- Usando de JOINS --

SELECT * FROM tabla_de_vendedores;
SELECT * FROM facturas;

-- INNER JOIN --

SELECT * FROM tabla_de_vendedores A
INNER JOIN 
facturas B
ON A.MATRICULA = B.MATRICULA;

SELECT A.NOMBRE, B.MATRICULA, COUNT(*) FROM tabla_de_vendedores A
INNER JOIN 
facturas B
ON A.MATRICULA = B.MATRICULA
GROUP BY A.NOMBRE, B.MATRICULA;

## Facturación anual de la empresa
SELECT YEAR(FECHA_VENTA), SUM(CANTIDAD * PRECIO) AS FACTURACION
FROM facturas F 
INNER JOIN 
items_facturas IFa 
ON F.NUMERO = IFa.NUMERO
GROUP BY YEAR(FECHA_VENTA);

-- CROSS JOIN -- 
## Forma antigua de hacer un inner join
SELECT A.NOMBRE, B.MATRICULA, COUNT(*) FROM tabla_de_vendedores A, facturas B
WHERE A.MATRICULA = B.MATRICULA
GROUP BY A.NOMBRE, B.MATRICULA;

-- LEFT y RIGHT JOIN --

SELECT COUNT(*) FROM tabla_de_clientes; #Conocer la cantidad

SELECT DISTINCT A.DNI, A.NOMBRE, B.DNI FROM tabla_de_clientes A 
INNER JOIN 
facturas B
ON A.DNI = B.DNI;

SELECT DISTINCT A.DNI, A.NOMBRE, B.DNI FROM tabla_de_clientes A 
LEFT JOIN 
facturas B
ON A.DNI = B.DNI;

SELECT DISTINCT A.DNI, A.NOMBRE, B.DNI FROM tabla_de_clientes A 
RIGHT JOIN 
facturas B
ON A.DNI = B.DNI;

-- FULL y CROSS JOIN --

SELECT * FROM tabla_de_clientes;
SELECT * FROM tabla_de_vendedores;

SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.BARRIO,
tabla_de_vendedores.NOMBRE
FROM tabla_de_clientes
INNER JOIN
tabla_de_vendedores
on tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO; 

-- Estructura UNION --
## Permite unir 2 o más tablas, con el mismo numero de campos y de los mismos tipos
##Tiene distinct incorporado

SELECT DISTINCT BARRIO FROM tabla_de_clientes;
SELECT DISTINCT BARRIO FROM tabla_de_vendedores;

SELECT BARRIO FROM tabla_de_clientes
UNION
SELECT BARRIO FROM tabla_de_vendedores;

SELECT BARRIO, NOMBRE, 'Cliente' as TIPO FROM tabla_de_clientes
UNION
SELECT BARRIO, NOMBRE,  'Vendedor' as TIPO FROM tabla_de_vendedores;

SELECT BARRIO, NOMBRE, 'Cliente' as TIPO, DNI FROM tabla_de_clientes
UNION ##Si bien no son del mismo tamaño DNI y MATRICULA, son del mismo tipo
SELECT BARRIO, NOMBRE,  'Vendedor' as TIPO, MATRICULA FROM tabla_de_vendedores;

-- UNION ALL si permite los distintos --

SELECT BARRIO FROM tabla_de_clientes
UNION ALL
SELECT BARRIO FROM tabla_de_vendedores;

-- Formando un FULLJOIN con UNION --

SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.CIUDAD, tabla_de_clientes.BARRIO,
tabla_de_clientes.NOMBRE, VACACIONES
FROM tabla_de_clientes
LEFT JOIN
tabla_de_vendedores
ON tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO
UNION
SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.CIUDAD, tabla_de_clientes.BARRIO,
tabla_de_clientes.NOMBRE, VACACIONES
FROM tabla_de_clientes
RIGHT JOIN
tabla_de_vendedores
ON tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO;
