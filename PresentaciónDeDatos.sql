SELECT ENVASE, TAMANO FROM tabla_de_productos;

-- Se observan muchas combinaciones repetidas, por eso usamos DISTINCT --

SELECT DISTINCT ENVASE, TAMANO FROM tabla_de_productos; # Observamos sin repetidos

SELECT DISTINCT ENVASE, TAMANO, SABOR FROM tabla_de_productos WHERE SABOR = 'naranja'; # Aplicando filtro

-- El comando LIMIT limita la cantidad de registros que se van a mostrar --

SELECT * FROM tabla_de_productos LIMIT 5;

SELECT * FROM tabla_de_productos LIMIT 5,4; # Desde el registro 5, muestra 4 registros 

SELECT * FROM facturas WHERE FECHA_VENTA = '2017-01-01' LIMIT 10; # Muestra 10 facturas del día seleccionado

-- Comando ORDER BY --

SELECT * FROM tabla_de_productos ORDER BY PRECIO_DE_LISTA ; # Ordena de forma ascendente por defecto
SELECT * FROM tabla_de_productos ORDER BY PRECIO_DE_LISTA DESC; # La forma descendente
 
SELECT * FROM tabla_de_productos ORDER BY NOMBRE_DEL_PRODUCTO;

SELECT * FROM tabla_de_productos ORDER BY ENVASE ASC, NOMBRE_DEL_PRODUCTO DESC; # Dos campos

-- Comando GROUP BY, siempre se usa con alguna operacion SUM, MAX, MIN, COUNT, AVG --

SELECT ESTADO, LIMITE_DE_CREDITO FROM tabla_de_clientes;

SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS LIMITE_TOTAL FROM tabla_de_clientes GROUP BY ESTADO; 
# Suma todos los límites de créditos por estado y los muestra

SELECT ENVASE, MAX(PRECIO_DE_LISTA) FROM tabla_de_productos GROUP BY ENVASE;
SELECT ENVASE, COUNT(*) FROM tabla_de_productos GROUP BY ENVASE;

SELECT BARRIO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes GROUP BY BARRIO;

SELECT CIUDAD, BARRIO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes
WHERE CIUDAD = 'CIUDAD DE MEXICO' GROUP BY BARRIO;

SELECT CIUDAD, BARRIO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes
GROUP BY BARRIO, ESTADO, CIUDAD;

SELECT ESTADO, BARRIO, MAX(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes
WHERE EDAD >= 20
GROUP BY ESTADO, BARRIO, EDAD
ORDER BY EDAD;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Comando HAVING --
# Va despues del GROUP BY

SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS LIMITE_TOTAL 
FROM tabla_de_clientes GROUP BY ESTADO 
HAVING LIMITE_TOTAL > 300000; 

SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO,
MIN(PRECIO_DE_LISTA) AS PRECIO_MINIMO
FROM tabla_de_productos GROUP BY ENVASE
HAVING SUM(PRECIO_DE_LISTA) > 80;

SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO,
MIN(PRECIO_DE_LISTA) AS PRECIO_MINIMO, SUM(PRECIO_DE_LISTA) AS SUMA_PRECIO
FROM tabla_de_productos GROUP BY ENVASE
HAVING SUM(PRECIO_DE_LISTA) > 80 AND MAX(PRECIO_DE_LISTA) >= 5;

SELECT DNI, COUNT(*) FROM facturas WHERE YEAR(FECHA_VENTA) = 2016
GROUP BY DNI HAVING COUNT(*) > 2000; #¿Quiénes fueron los clientes que realizaron más de 2000 compras en 2016?

-- Comando CASE --

SELECT * FROM tabla_de_productos;

SELECT NOMBRE_DEL_PRODUCTO, PRECIO_DE_LISTA,
CASE
	WHEN PRECIO_DE_LISTA >= 12 THEN 'Costoso'
    WHEN PRECIO_DE_LISTA >= 5 AND PRECIO_DE_LISTA < 12 THEN 'Absequible'
    ELSE 'Barato'
END AS PRECIO
FROM tabla_de_productos;


SELECT NOMBRE,
CASE 
    WHEN YEAR(fecha_de_nacimiento) < 1990 THEN 'Viejos'
    WHEN YEAR(fecha_de_nacimiento) >= 1990 
    AND YEAR(fecha_de_nacimiento) <= 1995 THEN 'Jóvenes' 
    ELSE 'Niños' 
END AS CLASIFICACION_EDAD
FROM tabla_de_clientes;

SELECT ENVASE, SABOR,
CASE
   WHEN PRECIO_DE_LISTA >= 12 THEN 'Costoso'
   WHEN PRECIO_DE_LISTA >= 5 AND PRECIO_DE_LISTA < 12 THEN 'Asequible'
   ELSE 'Barato'
END AS PRECIO, MIN(PRECIO_DE_LISTA) AS PRECIO_MINIMO
FROM tabla_de_productos
WHERE TAMANO = '700 ml'
GROUP BY ENVASE, SABOR,
CASE
   WHEN PRECIO_DE_LISTA >= 12 THEN 'Costoso'
   WHEN PRECIO_DE_LISTA >= 5 AND PRECIO_DE_LISTA < 12 THEN 'Asequible'
   ELSE 'Barato'
END
ORDER BY ENVASE;