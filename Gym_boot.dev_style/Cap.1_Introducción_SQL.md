## Capítulo 1 - Introducción
# SQL ( Structured Query Language ) 

Es el lenguaje que utilizamos para comunicarnos con las bases de datos. PostgreSQL, MySQL, SQLite y la mayoría de las demás bases de datos que almacenan datos en tablas lo utilizan .

En este curso, aprenderás SQL trabajando en la base de datos de un clon ficticio de PayPal llamado CashPal . Escribirás consultas que interactúan con usuarios, transacciones, pagos y mucho más.

### Asignación
El código de la derecha es una consulta simple que devuelve selecttodas las filas y columnas de una tabla llamada "people", ¡ pero hay un problema! La tabla en realidad se llama users, ¡no people!

Corrige el error cambiando "people" por "users" en la consulta y, a continuación, envía tu respuesta.

| SELECT   * FROM   people; | SELECT   * FROM   users; |
|---------------------------|--------------------------|

## Seleccionar una sola columna
Las bases de datos están formadas por tablas, que a su vez están formadas por columnas (también conocidas como "campos"). Es igual que una hoja de cálculo de Excel.

Cada fila de una tabla representa un único registro. Por ejemplo, aquí hay tres filas de nuestra userstabla CashPal:

| identificación |     nombre    | edad | banalance | es_administrador |
|:--------------:|:-------------:|:----:|:---------:|:----------------:|
|        1       |   Juan Smith  |  28  |    450    |         1        |
|        2       | Darren Walker |  27  |    200    |         1        |
|        3       |  Jane Morris  |  33  |   496.26  |         0        |0                |

En la lección anterior, usamos el *comodín para obtener todas las columnas. Para seleccionar solo una columna , sustituya el comodín *por el nombre de la columna específica:

SELECT
  name
FROM
  users;

### Asignación
Actualiza la consulta para seleccionar únicamente la age columna de la userstabla.

SELECT
  age
FROM
  users;

| edad |
|------|
| 28   |
| 27   |
| 33   |
| 41   |
| 22   |
| 35   |

## Seleccione varias columnas

Como probablemente ya habrás adivinado, si puedes seleccionar todas las columnas con una coma *y puedes seleccionar una sola columna por su nombre, también puedes seleccionar varias columnas por su nombre . Por ejemplo, si tuviera una monsterstabla que almacenara sus atributos, podría escribir:

select
  health,
  damage,
  defense
from
  monsters;

Todas las sentencias SQL deben terminar con un punto y coma ;.

### Asignación

**Actualiza la consulta para seleccionar:**

+ age
+ name
+ balance

*columnas en ese orden* .

SELECT
  age, name, balance
FROM
  users;

| edad |     nombre    | balance |
|:----:|:-------------:|:-------:|
|  28  |   Juan Smith  |   450   |
|  27  | Darren Walker |   200   |
|  33  |  Jane Morris  |  496,24 |
|  41  |  Priya Patel  | 1024,75 |
|  19  |  Marco Rivera |   12.5  |
|  65  |   Evelyn Cho  |   8000  |

# ¿Qué es SQL?

El lenguaje de consulta estructurado, o SQL (pronunciado **"squeel"** por los expertos), es el principal lenguaje de programación utilizado para administrar e interactuar con bases de datos relacionales . SQL puede realizar operaciones como crear , actualizar , leer y eliminar registros dentro de una base de datos.

# *As backend Developers, we just move digital garbage around..That's like the whole job. - Lane Wagner, 2025*

En términos generales, SQL es extremadamente potente y programable . Si bien las hojas de cálculo son excelentes para la manipulación manual de datos, SQL está diseñado para operaciones de datos automatizadas y escalables. 

Puede manejar grandes conjuntos de datos, consultas complejas y se integra fácilmente con lenguajes de programación de propósito general como Python, TypeScript y Go.

¿Qué herramienta usarías con mayor probabilidad para llevar un control de tus impuestos personales y tu presupuesto?
* Una hoja de cálculo de Excel o Google Sheets

¿Qué sistema utilizarías con mayor probabilidad para almacenar los expedientes académicos de los estudiantes de una escuela en línea?
* Una base de datos SQL

## ¿Qué bases de datos utilizan SQL?
SQL es simplemente un lenguaje de consulta. Normalmente se utiliza para interactuar con una tecnología de base de datos específica. Por ejemplo:

* SQLite
* PostgreSQL
* MySQL
* Base de datos de cucarachas
* Oráculo
* etc.

Aunque muchas bases de datos utilizan el *lenguaje* SQL , la mayoría tiene su propio dialecto . Es *fundamental* comprender que no todas las bases de datos son iguales. El hecho de que una base de datos compatible con SQL funcione de una manera determinada no significa que todas las bases de datos compatibles con SQL sigan exactamente los mismos patrones.

## Estamos usando SQLite

En este curso, utilizaremos SQLite específicamente. SQLite es ideal para proyectos embebidos, navegadores web y proyectos sencillos. Es ligero, pero su funcionalidad es limitada en comparación con **PostgreSQL** o **MySQL**, dos de las tecnologías SQL más comunes en entornos de producción.

¡Les indicaremos siempre que alguna funcionalidad con la que estemos trabajando sea exclusiva de SQLite!

### Asignación
Una forma en que SQLite es un poco diferente es que almacena valores booleanos como enteros: los enteros 0y 1.

* 0=false
* 1=true

Nuestra userstabla tiene una is_admincolumna booleana que indica si un usuario es administrador o no. Escribe una consulta para ver cómo se representa este campo booleano en los resultados.

Seleccione todas las banderas ids, names y is_adminde la userstabla.

SELECT
  id, name, is_admin
FROM
  users

| identificación |      nombre     | es_administrador |
|:--------------:|:---------------:|:----------------:|
|        1       |   Lane Holland  |         0        |
|        2       |    Allan Rae    |         1        |
|        3       |  Sally Wagoner  |         1        |
|        4       |    Mina Patel   |         0        |
|        5       |   Rubén Ortiz   |         0        |
|        6       |     Iris Kim    |         1        |
|        7       |   Damon Price   |         0        |
|        8       | Parque de junio |         1        |

# Comparación de bases de datos SQL
Hablemos de algunos de los sistemas de bases de datos SQL más consolidados y de lo que los diferencia entre sí. Las bases de datos SQL más populares incluyen:

* PostgreSQL
* MySQL
* Microsoft SQL Server
* SQLite
* Y muchos otros

*Fuente: db-engines.com*

Si bien todas estas bases de datos utilizan SQL, cada una define reglas, prácticas y estrategias específicas que las diferencian de sus competidores.

## SQLite vs. PostgreSQL
*Personalmente, SQLite y PostgreSQL son mis favoritas de la lista anterior. PostgreSQL es una base de datos muy potente, de código abierto y lista para producción. SQLite es una base de datos ligera, integrable y de código abierto. Cuando necesito usar SQL, suelo elegir entre las dos dependiendo del caso de uso. - Lane Wagner*

SQLite es un sistema de gestión de bases de datos (DBMS) sin servidor que tiene la capacidad de ejecutarse dentro de las aplicaciones, mientras que PostgreSQL utiliza un modelo cliente-servidor y requiere que se instale un servidor que esté escuchando en una red, de forma similar a un servidor HTTP.

Vea una comparación completa aquí.
https://db-engines.com/en/system/PostgreSQL%3BSQLite

### Asignación
Veamos cómo SQLite no aplica la verificación de tipos. Observe que dentro de la CREATE TABLEinstrucción, namese define como un TEXTcampo.

1. [x] Ejecuta el código y echa un vistazo a los resultados (¡no lo envíes todavía!).
2. [x] Cambia la cadena de texto 'Montgomery Burns'al número entero 1y vuelve a ejecutar el código.

Para aprobar la tarea, envíe el código en el estado alterado , donde el registro con un idtiene 2un namede 1.

# 💡
Fíjate en cómo, aunque lo definimos name como un TEXT campo, ¡SQLite nos permitió usar un entero! Al igual que Python y JavaScript, SQLite tiene un sistema de tipos flexible... Puedes almacenar cualquier tipo de dato en cualquier campo, independientemente de cómo lo hayas definido. Pero que puedas hacer algo no significa que debas hacerlo.

CREATE TABLE users (id INTEGER, name TEXT, age INTEGER);

INSERT into
  users (id, name, age)
values
  (1, 'John Doe', 21);

INSERT into
  users (id, name, age)
values
  (2, 'Montgomery Burns', 33); 
  ### ^^^ *Aquí es donde se modifica de Montgomery a 1*

SELECT
  *
FROM
  users;

  | identificación | nombre           | edad |
|----------------|------------------|------|
| 1              | Juan Doe         | 21   |
| 2              | 1 | 33   |

# NoSQL frente a SQL
Cuando hablamos de bases de datos SQL, también tenemos que mencionar el tema tabú: NoSQL .

En pocas palabras, una base de datos NoSQL es una base de datos que no utiliza SQL (Structured Query Language). Cada sistema de base de datos NoSQL suele tener su propia forma de escribir y ejecutar consultas. Por ejemplo, MongoDB utiliza MQL (MongoDB Query Language), y Elasticsearch simplemente tiene una API JSON.

Si bien la mayoría de las bases de datos relacionales son bastante similares, las bases de datos NoSQL tienden a ser únicas y se utilizan para fines más específicos. Algunas de las principales diferencias entre las bases de datos SQL y NoSQL son:

1. Las bases de datos NoSQL suelen ser no relacionales; las bases de datos SQL suelen ser relacionales.
2. Las bases de datos SQL suelen tener un esquema definido; las bases de datos NoSQL suelen tener un esquema dinámico.
3. Las bases de datos SQL se basan en tablas; las bases de datos NoSQL tienen una variedad de métodos de almacenamiento diferentes, como documentos, clave-valor, grafos, columnas anchas y más.

## Tipos de bases de datos NoSQL

* Document Database
* Key-Value Store
* Wide-Column
* Graph

## Algunas de las bases de datos NoSQL más populares son:

* MongoDB
* Cassandra
* CouchDB
* DynamoDB
* ElasticSearch

## 🔑 **Recordar**:
* Cada base de datos **NoSQL** tiende a utilizar diferentes lenguajes de consulta.
* Las base de datos SQL tienden a utilizar más funcionalidades similares que las bases de datos NoSQL. 
