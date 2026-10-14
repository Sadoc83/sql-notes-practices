SELECT
    AVG(price) AS average_price
FROM
    product_model;

#average_price
2.4565217391304346

##############################################

SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM
    product_model;

############################################################################################

SELECT
    FUNCION_DE_AGREGACION(campo) AS nombre_significativo
FROM
    tabla
WHERE
    condicion;



############################################################################################
############################################################################################

SELECT
    AVG (price) AS average_price -- Agrega aquí la expresión de agregación
FROM
    product_model
WHERE
    units = 'g';-- Agrega aquí la condición de filtrado

# Resultado 
# average_price
2.61972

SELECT
    AVG (price) AS average_price -- Agrega aquí la expresión de agregación
FROM
    product_model
WHERE
    units = 'ml';-- Agrega aquí la condición de filtrado

# Resultado 
# average_price
2.57143


ejercicio 1:
SELECT
    SUM (productsCount) AS recipe_bundle_products -- Expresión de agregación
FROM
    grocery_bundle_model -- Nombre de la tabla
WHERE    
    groceycollections = 2;  -- Condición de filtrado

# Resultado
# recipe_bundle_products
40