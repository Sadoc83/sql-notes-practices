# Cláusula AS en SQL
A veces necesitamos estructurar los datos que devolvemos en nuestras consultas de una manera específica. Una cláusula AS nos permite asignar un «alias» a un dato en nuestra consulta. El alias solo existe mientras dura la consulta.

## Palabra clave AS
Las siguientes consultas devuelven los mismos datos:

        SELECT
            employee_id AS id,
            employee_name AS name
        FROM
            employees;

        SELECT
            employee_id,
            employee_name
        FROM
            employees;

La diferencia es que los resultados de la consulta con alias tendrían los nombres de columna «id» y «name» en lugar de «employee_id» y «employee_name».

## 🚨 A lo largo del curso, solo se debería usar el alias solo cuando se solicite 🤷🏽‍♂️.

### 👨🏽‍🏫  Tarea
Un usuario nos ha pedido que busquemos todas las transacciones en su cuenta realizadas por su abuela. Pensamos que sería divertido cambiar el nombre del campo «nota» a «mensaje_de_cumpleaños», ya que notamos que todas las transacciones de la abuela son mensajes de cumpleaños.

Devuelve los campos «amount» y «nota» de la tabla de transacciones donde el «id_remitente» sea 10 (abuela).
El campo «nota» debe renombrarse como «mensaje_de_cumpleaños».

### 🤓 La cláusula AS es una herramienta genial en el Backend de QA.

Permite formatear y limpiar la salida de los datos para que el Frontend o un reporte de negocio los entienda mucho mejor sin alterar la estructura real de la tabla. Vamos a desglosar y resolver la asignación paso a paso de forma súper explícita.

## 🧱 Análisis del Problema y Proceso de Decisión

1. Identificar las columnas a recuperar y sus alias. El enunciado nos pide devolver dos campos específicos:

      * amount: Este campo se queda exactamente igual, sin alias.
      * note: Este campo es el divertido. Nos piden explícitamente renombrarlo utilizando la cláusula AS para que en el resultado final aparezca con el nombre de birthday_message.
      * Estructura inicial: SELECT amount, note AS birthday_message

2. Identificar la tabla origen:

Los datos financieros se encuentran en la entidad de movimientos de CashPal:

    FROM transactions

3. Definir la condición de filtrado (WHERE):

Queremos aislar únicamente las transacciones que envió la abuela. Las instrucciones especifican que el colador del WHERE debe buscar los registros donde la columna sender_id sea numéricamente igual a 10:

    WHERE sender_id = 10

## 🛠️ Código SQL


        SELECT
            amount,
            note AS birthday_message
        FROM
            transactions
        WHERE
            sender_id = 10;



### 📋 ¿Por qué estructuramos esto así?

* note AS birthday_message: Aplica el alias temporal. Durante la ejecución de esta consulta, la columna note se camuflará con el nuevo nombre, cumpliendo con el requerimiento del usuario.

* WHERE sender_id = 10: Filtra en el Backend para asegurar que no se mezclen transacciones de otros usuarios, trayendo a la pantalla únicamente los montos y los mensajes de cumpleaños de la abuela.

# Funciones SQL

SQL es un lenguaje de programación, y como la mayoría de los lenguajes de programación, admite funciones. Podemos utilizar funciones y alias para calcular nuevas columnas en una consulta. Esto es similar a cómo se podrían utilizar fórmulas en Excel.

### 🔥 Una columna calculada es una columna que no existe en la tabla original, sino que se crea sobre la marcha al ejecutar una consulta.

## La función IIF
En SQLite, la función IIF funciona como una expresión ternaria. Por ejemplo:

IIF(carA > carB, 'Car A is bigger', 'Car B is bigger')

Si es carA mayor que carB, esta instrucción se evalúa como la cadena 'Car A is bigger'. De lo contrario, se evalúa como 'Car B is bigger'.

Así es como podemos usar IIF() y un alias directive para agregar una nueva columna calculada a nuestro conjunto de resultados:

        SELECT
            quantity,
            IIF(quantity < 10, 'Order more', 'In Stock') AS directive
        FROM
            products;

| quantity |  directive |
|:--------:|:----------:|
|     4    | Order more |
|    25    |  In Stock  |

## 🗒 Asignación
Necesitamos revisar los datos de transacciones de CashPal y determinar si alguna de ellas necesita ser auditada.

Devuelve todos los datos de la tabla transactions y agrega una columna adicional al final con el alias audit.

Si el campo was_successful de una fila es true, el campo audit debería decir 'No action required'.
Si el campo was_successful de una fila es false, el campo audit debería decir 'Perform an audit'.

# 💬 Consejo ... buena onda!
Algunos operadores de comparación en SQL:

    =: Igual a
    <: Menos de
    >: Mayor que

### ⚙️ Para un QA Engineer, las columnas calculadas al vuelo son oro puro 
Las columnas permiten automatizar banderas (flags) visuales para alertar sobre fallos o transacciones sospechosas sin alterar la base de datos de producción.

## Empecemos por el principio

## 🧱 Análisis del Problema y Proceso de Decisión

1. Recuperar todos los datos existentes:

El enunciado nos pide: "Devolver todos los datos de la tabla transactions". Para esto, usaremos el famoso comodín del asterisco de forma inicial:

    SELECT *, (dejamos una coma al final porque vamos a agregar la nueva columna calculada justo después).

2. Diseñar la lógica condicional con IIF():

    La función IIF requiere tres partes: IIF(condición, valor_si_verdadero, valor_si_falso).

      * Condición: Revisar si el campo was_successful es igual a verdadero (was_successful = true).
      * Valor si es verdadero: El enunciado dice que debe devolver 'No action required'.
      * Valor si es falso: El enunciado dice que debe devolver 'Perform an audit'.
      * Estructura de la función: IIF(was_successful = true, 'No action required', 'Perform an audit')

3. Asignar el alias requerido:

Nos piden explícitamente que esta columna extra que se calcula en el Backend tenga el alias audit: 

    AS audit

4. Identificar la procedencia de los datos:

Apuntamos el tiro directamente a la tabla financiera de juguete:

    FROM transactions;

## 🛠️ Código SQL


        SELECT
            *,
            IIF(was_successful = true, 'No action required', 'Perform an audit') AS audit
        FROM
            transactions;


### 📋 ¿Por qué estructuramos esto así?

*  *, IIF(...): 
   - El asterisco jala todas las columnas originales que ya tiene la tabla en el orden de su esquema, y la coma nos permite adjuntar la columna calculada audit al final del reporte, tal y como lo pide la asignación.

* was_successful = true: 
  - Al evaluar esta bandera booleana, el motor de SQLite actuará como un filtro automatizado. Si una transacción falló (false), la función saltará inmediatamente a la tercera variable, marcando en pantalla la alerta 'Perform an audit' para que el equipo de QA investigue el bug en el Backend.

# Beetween - Entre
Podemos comprobar si los valores son between entre dos números usando la cláusula WHERE de forma intuitiva. La clásula WHERE no siempre tiene que usarse para especificar identificadores o valores concretos. También podemos usarla para ayudarnos a acotar nuestro conjunto de resultados. Ejemplo:

        SELECT
            employee_name,
            salary
        FROM
            employees
        WHERE
            salary BETWEEN 30000 AND 60000;

Esta consulta devuelve todos los empleados campos name y salary para cualquier fila donde el valor sea salary BETWEEN 30.000 y 60.000, ambos inclusive. También podemos consultar resultados que contengan **NOT BETWEEN** para dos valores específicos.

        SELECT
            product_name,
            quantity
        FROM
            products
        WHERE
            quantity NOT BETWEEN 20 AND 100;

Esta consulta devuelve todos los nombres de productos y cantidades donde la cantidad no está entre 20y 100(es decir, excluye 20y 100). Podemos usar condicionales para que los resultados de nuestra consulta sean tan específicos como necesitemos.

## 🗒 Asignación
¡Necesitamos ver cuántos jóvenes adultos están usando CashPal!

Consulta nuestra tabla users para devolver los campos name y age de todos los usuarios BETWEEN con las edades de 18 y 30.

tabla users: up.sql

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  age INTEGER NOT NULL,
  country_code TEXT NOT NULL,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  is_admin BOOLEAN
);

INSERT INTO
  users (id, name, age, country_code, username, password, is_admin)
VALUES
  (1, 'David', 34, 'US', 'DavidDev', 'insertPractice', false);

INSERT INTO
  users (id, name, age, country_code, username, password, is_admin)
VALUES
  (2, 'Samantha', 29, 'BR', 'Sammy93', 'addingRecords!', false);

INSERT INTO
  users (id, name, age, country_code, username, password, is_admin)
VALUES
  (3, 'John', 39, 'CA', 'Jjdev21', 'welovebootdev', false);

INSERT INTO
  users (id, name, age, country_code, username, password, is_admin)
VALUES
  (4, 'Ram', 42, 'IN', 'Ram11c', 'thisSQLcourserocks', false);

INSERT INTO
  users (id, name, age, country_code, username, password, is_admin)
VALUES
  (5, 'Hunter', 30, 'US', 'Hdev92', 'backendDev', false);

INSERT INTO
  users (id, name, age, country_code, username, password, is_admin)
VALUES
  (6, 'Allan', 27, 'US', 'Alires', 'iLoveB00tdev', true);

INSERT INTO
  users (name, age, country_code, username, password, is_admin)
VALUES
  ('Lance', 20, 'US', 'LanChr', 'b00tdevisbest', false);

INSERT INTO
  users (name, age, country_code, username, password, is_admin)
VALUES
  ('Tiffany', 28, 'US', 'Tifferoon', 'autoincrement', true);

INSERT INTO
  users (name, age, country_code, username, password, is_admin)
VALUES
  ('Lane', 27, 'US', 'wagslane', 'update_me', false);

INSERT INTO
  users (name, age, country_code, username, password, is_admin)
VALUES
  ('Marcus', 17, 'US', 'MarcusM', 'boundaryLow', false);

INSERT INTO
  users (name, age, country_code, username, password, is_admin)
VALUES
  ('Nadia', 18, 'US', 'NadiaN', 'inclusiveEdge', false);

INSERT INTO
  users (name, age, country_code, username, password, is_admin)
VALUES
  ('Oscar', 31, 'US', 'OscarO', 'boundaryHigh', false);

## 🕵🏽‍♂️ Volvemos a encontrarnos con el operador BETWEEN, el cual es sumamente útil e intuitivo. 

**🗒 Como nota importante de QA que debes recordar de algúnos de los ejercicios de TripleTen donde fue que lo lei por primera ocación: BETWEEN es inclusivo, lo que significa que en este caso sí va a tomar en cuenta a las personas que tengan exactamente 18 y exactamente 30 años.**


## 🧱 Análisis del Problema y Proceso de Decisión

1. Identificar las columnas a recuperar:

El enunciado nos pide explícitamente: "return the name and age fields" (devolver los campos name y age). Por lo tanto, no usaremos el asterisco comodín; listamos solo esas dos columnas separadas por una coma:    

        SELECT name, age

2. Identificar la tabla origen:

Los datos provienen de la entidad de usuarios que nos muestra el archivo up.sql:

        FROM users

3. Definir la condición de rango (WHERE y BETWEEN):

La asignación nos pide filtrar a los usuarios que estén entre los 18 y los 30 años de edad. Usando la columna age, la sintaxis limpia se escribe sin signos de igualdad (ya que BETWEEN hace la comparación por sí solo):

        WHERE age BETWEEN 18 AND 30

## 🛠️ Tu Código SQL Listo

        SELECT
            name,
            age
        FROM
            users
        WHERE
            age BETWEEN 18 AND 30;


### 📋 ¿Por qué funciona a la perfección para QA?

* SELECT name, age: Limita la salida para traer solo los datos relevantes que pidió el equipo de estrategia comercial, haciendo la consulta más rápida.
* WHERE age BETWEEN 18 AND 30: Actúa como un filtro de rango en el Backend. Al ejecutarse, ignorará a David (34), John (39) o Marcus (17), pero incluirá perfectamente los límites exactos como Nadia (18) y Hunter (30), además de Samantha (29), Allan (27), Lance (20), Tiffany (28) y Lane (27).

# Distintc
A veces queremos recuperar registros de una tabla sin obtener duplicados.

Por ejemplo, es posible que queramos saber en qué empresas han trabajado nuestros empleados anteriormente, pero no queremos ver la misma empresa varias veces en el informe.

SELECT DISTINC
SQL nos ofrece la palabra clave DISTINCT que elimina los registros duplicados de la consulta resultante.

        SELECT DISTINCT
            previous_company
        FROM
            employees;

Esto devuelve solo una fila por cada valor previous_company único.

## 🗒 Asignación
Los ejecutivos de CashPal quieren saber en qué países tenemos clientes. Almacenamos con los datos country_code como una columna en la tabla users.

Ejecuta una consulta DISTINCT para obtener todos los valores country_code únicos de la tabla users.

### ⚙️ Para un QA Engineer, esta palabra clave es el detector de duplicados definitivo en el Backend.

Te permite limpiar reportes masivos al instante y saber, por ejemplo, cuántas opciones únicas existen en un universo de millones de registros sin tener que lidiar con filas repetidas.

Vamos a estructurar la consulta paso a paso de forma súper explícita.

## 🧱 Análisis del Problema y Proceso de Decisión

1. Aplicar el filtro de unicidad (SELECT DISTINCT):
El enunciado nos pide recuperar registros "without getting back any duplicates" (sin recibir duplicados) y obtener "all the unique country_codes" (todos los códigos de país únicos). Para lograr esto, añadimos la palabra clave DISTINCT inmediatamente después del SELECT:
            
            SELECT DISTINCT

2. Identificar la columna a recuperar:
La asignación nos especifica que la información que buscan los ejecutivos de CashPal está almacenada en la columna:
            
            country_code

3. Identificar la tabla origen:
Apuntamos el tiro directamente a la entidad de usuarios que ya conocemos:

            FROM users;

## 🛠️ Código SQL 

        SELECT DISTINCT
            country_code
        FROM
            users;


### 📋 ¿Por qué estructuramos esto así?

* SELECT DISTINCT country_code: Le ordena al motor de la base de datos que escanee toda la columna en el Backend. Si encuentra diez usuarios de Estados Unidos ('US'), tres de Brasil ('BR') y cinco de India ('IN'), el colador de DISTINCT destruirá las repeticiones al vuelo y te mostrará en la pantalla una sola fila por cada país.
* El resultado final será una lista limpia y compacta con valores únicos ('US', 'BR', 'IN', etc.), dándole a los ejecutivos la respuesta exacta que necesitan para su estrategia de expansión.

# Operadores lógicos – AND
A menudo necesitamos usar varias condiciones para obtener la información exacta que buscamos. Podemos empezar a estructurar consultas mucho más complejas combinando varias condiciones para acotar los resultados de nuestra búsqueda.

¡El operador lógico AND puede utilizarse para reducir aún más nuestros conjuntos de resultados!

## operador AND

        SELECT
            product_name,
            quantity,
            shipment_status
        FROM
            products
        WHERE
            shipment_status = 'pending'
            AND quantity BETWEEN 0 AND 10;

Esto solo recupera registros donde tanto el estado es shipment_status "pendiente" y el estado quantity está entre 0 y 10.

## Operadores de comparación
Todos los siguientes operadores son compatibles con SQL. El = es principal a tener en cuenta el operador `--`, ya que no es == como en muchos otros lenguajes. SQLite permite usar `--` ==, pero no es recomendable, puesto que otros dialectos de SQL no lo reconocerán == como sintaxis válida.

  * ( = )
  * ( < )
  * ( > )
  * ( <= )
  * ( >= )
  * ( <>o!= )

## 🗒 Asignación
¡Las restricciones legales en Canadá han cambiado! La forma en que debemos gestionar las transacciones de CashPal de menores canadienses está ahora más regulada. ¡Necesitamos localizar a todos esos usuarios para determinar a cuántos afecta este cambio!

1. [x] Escribe una consulta que recupere todas las columnas de los usuarios de la userstabla que sean de Canadá ( CA) y menores de edad 18.

### 👨🏽‍🏫 El operador AND es la clave para la precisión quirúrgica en el Backend. 

Como bien menciona el ejercicio, siempre será crucial recordar que en SQL la igualdad se evalúa con un solo signo = **(no con == como en Python)**, *lo cual es una regla de oro de sintaxis que siempre debes cuidar para mantener la portabilidad del código.*

Estructuremos la consulta paso a paso de forma súper explícita.

## 🧱 Análisis del Problema y Proceso de Decisión

1. Identificar las columnas a recuperar:
El enunciado nos pide explícitamente: "recupere todas las columnas". Por lo tanto, reactivamos nuestro comodín heurístico 😌 del asterisco:
        
        SELECT *

2. Identificar la tabla origen:
Los datos siguen almacenados en nuestra tabla maestra de usuarios:
        
        FROM users
        
3. Definir la primera condición (País):
El ejercicio nos indica que los usuarios deben ser de Canadá. Revisando el formato de los códigos que hemos usado antes, el valor para Canadá es 'CA' envuelto en comillas simples por ser un texto (TEXT):
        country_code = 'CA'

4. Definir la segunda condición (Edad):
Nos piden localizar a los usuarios que sean menores de edad, es decir, estrictamente menores a 18 años. Usamos el operador de comparación <:
        
        age < 18

5. Acoplar ambas condiciones con el operador AND:
Dado que el cambio legal afecta únicamente a quienes cumplen con ambas características a la vez (ser canadienses Y ser menores de edad), los unimos en el WHERE:
        
        WHERE country_code = 'CA' AND age < 18

## 🛠️ Código SQL


        SELECT
            *
        FROM
            users
        WHERE
            country_code = 'CA'
            AND age < 18;


### 📋 ¿Por qué funciona perfectamente para este caso de QA?

* SELECT *: Trae toda la entidad completa para que el equipo legal pueda auditar los perfiles a fondo.
* AND: Actúa como **un doble candado de seguridad** en el Backend. Si un usuario es de Canadá pero tiene 25 años, el AND lo descarta. Si un usuario tiene 15 años pero es de Estados Unidos ('US'), también lo descarta. El motor solo te mostrará a los usuarios que cumplan ambas reglas al mismo tiempo, dándote el conteo exacto para la auditoría de cumplimiento.

# OR
Como probablemente ya habrás adivinado, si el operador AND lógico es compatible, es probable que el operador OR también lo sea.

        SELECT
            product_name,
            quantity,
            shipment_status
        FROM
            products
        WHERE
            shipment_status = 'out of stock'
            OR quantity BETWEEN 10 and 100;

Esta consulta recupera registros donde se cumple la condición shipment_status o la condición quantity.

## Orden de operaciones
Puedes agrupar las operaciones lógicas con paréntesis para especificar el orden de las operaciones.

        (
        esto
        AND aquello
        )
        OR lo_otro

## Asignación
¡Las leyes han vuelto a cambiar! Ahora necesitamos ver cuántos usuarios afectados cumplen con estos criterios:

Usuarios que sean de Estados Unidos o Canadá y sean menores de 18 años.

1. [x] Escribe una consulta que cuente todos los usuarios que cumplan las condiciones anteriores.
2. [x] También se puede contar como junior_count.

# 👨🏽‍🏫 Aquí entramos a un terreno de alta precisión en el Backend.
El orden de las operaciones con paréntesis es la diferencia entre un reporte perfecto y un bug crítico de lógica en producción.

Como el enunciado nos pide explícitamente contar a los usuarios y renombrar el resultado, combinaremos una función de agregación con la cláusula AS que aprendimos (se supone 🥲) hace unas lecciones.

Estructuremos pues, la consulta paso a paso de forma súper explícita.

## 🧱 Análisis del Problema y Proceso de Decisión

1. Identificar la función de agregación y su alias:
El enunciado nos pide: "cuente todos los usuarios" (contar todas las filas) y que "se puede contar como junior_count" (asignar ese alias).
        
        SELECT COUNT(*) AS junior_count

2. Identificar la tabla origen:
Los datos siguen en nuestra tabla de control:
        
        FROM users

3. Descifrar la lógica del filtro (WHERE).
Analicemos el requerimiento con ojo de QA: 
     "Usuarios que sean de Estados Unidos o Canadá y sean menores de 18 años".
* La condición de países: El usuario puede ser de EE.UU. ('US') O de Canadá ('CA'). Esta condición debe ir agrupada en un bloque cerrado con paréntesis para que el motor evalúe los países primero: (country_code = 'US' OR country_code = 'CA').
* La condición de edad: Obligatoriamente tienen que ser menores de 18 años: age < 18.
* El acoplamiento: Ambas partes se unen con un AND. Si no pones los paréntesis en los países, el AND se *comería* solo a Canadá, y la consulta te traería a todos los adultos de EE.UU. por error.

## 🛠️ Código SQL

        SELECT
            COUNT(*) AS junior_count
        FROM
            users
        WHERE
            (country_code = 'US' OR country_code = 'CA')
            AND age < 18;


### 📋 ¿Por qué funciona de forma exacta y segura?

* COUNT(*) AS junior_count: En lugar de *escupir*💦 una lista de nombres, el motor procesa el Backend y devuelve un único número limpio bajo la columna junior_count, perfecto para que el equipo legal vea el impacto exacto.
* Los paréntesis ( ... OR ... ): Obligan a SQLite a verificar primero la región del usuario. Una vez que confirma que el usuario es norteamericano (ya sea 'US' o 'CA') Obviamente Mexicano no 🤷🏽‍♂️, aunque estemos en el extremo norte de america, pasa al candado del AND para verificar que sea menor de 18 años. *Esto asegura la integridad total del reporte legal.*





