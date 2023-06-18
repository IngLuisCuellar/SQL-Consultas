USE jugos_ventas;

SELECT DNI, NOMBRE, DIRECCION_1, DIRECCION_2, BARRIO, CIUDAD, ESTADO, CP,  
FECHA_DE_NACIMIENTO, EDAD, SEXO, LIMITE_DE_CREDITO, VOLUMEN_DE_COMPRA, 
PRIMERA_COMPRA FROM tabla_de_clientes; 

-- Sería lo mismo hacer si se pretende seleccionar todos los campos -- 

SELECT * FROM tabla_de_clientes;

SELECT DNI, NOMBRE FROM tabla_de_clientes;

-- Usando un alias --

SELECT DNI AS IDENTIFICACION, NOMBRE AS CLIENTE FROM tabla_de_clientes;

-- Uso de filtros --

SELECT * FROM tabla_de_productos WHERE SABOR = 'Uva';
SELECT * FROM tabla_de_productos WHERE SABOR = 'Mango';
SELECT * FROM tabla_de_productos WHERE ENVASE = 'BOTELLA PET';
SELECT * FROM tabla_de_productos WHERE PRECIO_DE_LISTA < 16;
SELECT * FROM tabla_de_productos WHERE PRECIO_DE_LISTA >= 16;
SELECT * FROM tabla_de_productos WHERE PRECIO_DE_LISTA BETWEEN 16 AND 16.02; # BUSCAR FLOATS

-- Consultas condicionales --

SELECT * FROM tabla_de_productos WHERE SABOR = 'Mango' AND TAMANO = '1 litro' ;
SELECT * FROM tabla_de_productos WHERE SABOR = 'Mango' OR TAMANO = '1 litro' ;
SELECT * FROM tabla_de_productos WHERE NOT (SABOR = 'Mango') OR TAMANO = '1 litro' ;
SELECT * FROM tabla_de_productos WHERE SABOR = 'Mango' AND NOT (TAMANO = '1 litro') ;
SELECT * FROM tabla_de_productos WHERE SABOR IN ('Mango', 'UVA'); # Es igual que poner saber = 'mango' or sabor = 'uva'

-- Consultas con like --

SELECT * FROM tabla_de_productos WHERE SABOR LIKE '%manzana' AND ENVASE LIKE '%PET';
SELECT * FROM tabla_de_clientes WHERE NOMBRE LIKE '%ez'; #Entrega todos los clientes que terminen con 'ez'
