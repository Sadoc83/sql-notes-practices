# Valores nulos
En SQL, una celda con un valor NULL indica que falta ese valor . Un valor NULL es muy diferente de un valor cero .

## Restricciones
Al crear una tabla, podemos definir si un campo puede o no ser NULL, y eso es una especie de constraint.

Pronto hablaremos con más detalle sobre las restricciones; por ahora, centrémonos en  los valores NULL.

## Asignación
No impusimos ninguna restricción a nuestras tablas al crearlas, ¡y eso ha permitido que NULL se añadan datos! Echemos un vistazo a nuestra transactionstabla para ver cómo NULL son esos valores.

Escribe una consulta para SELECT todos los campos de todos los registros de la transactionstabla.

## 🔎 Observar
Observa que ambos transaction_typecampos was_successful tienen valores NULL en los 3 registros de la tabla (en nuestro sistema, los valores nulos se representan con celdas en blanco). Esto se debe a que ejecutamos la migración en el ejercicio anterior después de que se crearon los 3 registros.

## 💬 Consejo
Utilice la * sintaxis (comodín) para seleccionar todos los campos.

SELECT
  *
FROM
  transactions;

  | id | recipient_id | sender_id |            note            | amount | transaction_type | was_successful |
|:--:|:------------:|:---------:|:--------------------------:|:------:|:----------------:|:--------------:|
|  1 |      14      |     26    |    Testing transaction!    |  10.5  |                  |                |
|  2 |              |     4     |                            |        |                  |                |
|    |       5      |           | Oil change, full synthetic | 140.22 |                  |                |

## Restricciones
Una constraintregla es una que creamos en una base de datos para imponer un comportamiento específico. Por ejemplo, establecer una restricción NOT NULL en una columna garantiza que dicha columna no acepte NULLvalores nulos.

Si intentamos insertar un NULL valor en una columna con la restricción NOT NULL, la inserción fallará y se mostrará un mensaje de error. Las restricciones son extremadamente útiles cuando necesitamos asegurarnos de que ciertos tipos de datos existan en nuestra base de datos.

## Definición de una restricción NOT NULL
La restricción NOT NULL se puede agregar directamente a la instrucción CREATE TABLE.

CREATE TABLE employees (
  id INTEGER PRIMARY KEY,
  -- The PRIMARY KEY constraint uniquely identifies each row in the table
  name TEXT UNIQUE,
  -- The UNIQUE constraint ensures that no two rows can have the same value in the 'name' column
  title TEXT NOT NULL
  -- The NOT NULL constraint ensures that the 'title' column cannot have NULL values
);

## Limitación de SQLite
En otros dialectos de SQL, esto se puede hacer ADD CONSTRAINTdentro de una ALTER TABLEsentencia. SQLite no admite esta función, por lo que al crear nuestras tablas debemos asegurarnos de especificar todas las restricciones que deseamos. Aquí hay una lista de las funciones de SQL que SQLite no implementa, por si les interesa.

## Asignación
Por suerte, todas las tablas que hemos creado para CashPal hasta ahora han sido para realizar pruebas. Ahora que entendemos mejor las restricciones, vamos a reconstruir nuestra base de datos con las restricciones y tablas adecuadas.

Cree la userstabla con los siguientes campos y restricciones:

1. [x] id– INTEGER,PRIMARY KEY
2. [x] name– TEXT,NOT NULL
3. [x] age– INTEGER,NOT NULL
4. [x] country_code– TEXT,NOT NULL
5. [x] username– TEXT, UNIQUE,NOT NULL
6. [x] password– TEXT,NOT NULL
7. [x] is_admin–BOOLEAN

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    country_code TEXT NOT NULL,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    is_admin BOOLEAN
);

| cid |     name     |   type  | notnull | dflt_value | pk |
|:---:|:------------:|:-------:|:-------:|:----------:|:--:|
|  0  |      id      | INTEGER |    1    |            |  1 |
|  1  |     name     |   TEXT  |    1    |            |  0 |
|  2  |      age     | INTEGER |    1    |            |  0 |
|  3  | country_code |   TEXT  |    1    |            |  0 |
|  4  |   username   |   TEXT  |    1    |            |  0 |
|  5  |   password   |   TEXT  |    1    |            |  0 |
|  6  |   is_admin   | BOOLEAN |    0    |            |  0 |

## Claves primarias
Una clave define y protege las relaciones entre tablas. Una clave primaria es una columna especial que identifica de forma única los registros dentro de una tabla. Cada tabla puede tener una, y solo una, clave primaria.

## La clave primaria suele ser un ID.
Es muy común tener una columna con un nombre iden cada tabla de una base de datos, y esa ides la clave primaria de esa tabla. No hay dos filas en esa tabla que puedan compartir un nombre id.

Se puede especificar explícitamente una PRIMARY KEYrestricción en una columna para garantizar la unicidad, rechazando cualquier inserción en la que se intente crear un ID duplicado.

## Asignación
Ejecuta el código. Observa que hay un error: se ha infringido una PRIMARY KEYrestricción en la idcolumna. Corrige los datos que se están insertando.

Al trabajar con identificadores enteros, la mejor práctica es incrementar el idvalor 1en cada inserción sucesiva. Siga esta convención al corregir el error.

INSERT INTO
  users (id, name, age, username, password, is_admin)
VALUES
  (1, 'Rudolf', 33, 'rudolf1234', 'thisisnotsecure', false);

INSERT INTO
  users (id, name, age, username, password, is_admin)
VALUES
  (1, 'Jerry', 25, 'jerrysmith', 'mypasswordis1234', true);

| name |   age  | username |  password  |     is_admin     |   |
|:----:|:------:|:--------:|:----------:|:----------------:|:-:|
|   1  | Rudolf |    33    | rudolf1234 |  thisisnotsecure | 0 |
|   2  |  Jerry |    25    | jerrysmith | mypasswordis1234 | 1 |

Este ejercicio es clave para entender cómo la base de datos rechaza datos corruptos. Como QA Engineer, ver este tipo de errores te confirma que las restricciones que creamos en el paso anterior (la PRIMARY KEY) están haciendo su trabajo perfectamente: proteger el sistema contra registros duplicados.

El motor de la base de datos arroja un error porque el código intenta insertar a Jerry con el id = 1, pero ese identificador ya fue reclamado por Rudolf en la línea anterior.

Siguiendo la mejor práctica que indica la plataforma (incrementar el valor del ID en 1 para cada nueva fila).

INSERT INTO
  users (id, name, age, username, password, is_admin)
VALUES
  (1, 'Rudolf', 33, 'rudolf1234', 'thisisnotsecure', false);

INSERT INTO
  users (id, name, age, username, password, is_admin)
VALUES
  (2, 'Jerry', 25, 'jerrysmith', 'mypasswordis1234', true);

## Claves foráneas
Las claves foráneas son lo que hace que las bases de datos relacionales sean relacionales. Las claves foráneas definen las relaciones entre tablas. En pocas palabras, una clave foránea es FOREIGN KEY un campo en una tabla que hace referencia a un campo PRIMARY KEY(o una columna UNIQUE) de otra tabla.

## Creación de una clave foránea en SQLite
¡La creación de una tabla FOREIGN KEY en SQLite ocurre al crear la tabla! Después de definir los campos y restricciones de la tabla, agregamos una tabla con nombre donde CONSTRAINT definimos la columna FOREIGN KEY y su REFERENCES.

Aquí tienes un ejemplo:

CREATE TABLE departments (id INTEGER PRIMARY KEY, department_name TEXT NOT NULL);

CREATE TABLE employees (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  department_id INTEGER,
  CONSTRAINT fk_departments FOREIGN KEY (department_id) REFERENCES departments (id)
);

En este ejemplo, un  employee tiene un department_id. El department_id debe ser el mismo que el campo id de un registro de la tabla departments. fk_departments es el nombre especificado de la restricción .

CONSTRAINT fk_departments: crear una restricción llamada fk_departments
FOREIGN KEY (department_id): convierte esta restricción en una clave foránea asignada al department_idcampo
REFERENCES departments(id): vincular el campo externo idde la tabla departments

## Asignación
Nuestra users tabla almacena el país de origen de nuestros usuarios en un campo country_code. Necesitamos información adicional sobre los países, como su nombre, pero no queremos sobrecargar nuestra tabla users con todos esos datos.

El equipo de "ubicaciones" de CashPal ha creado una tabla countries, y podemos vincular un usuario con su país estableciendo una clave externa en dicha tabla users. Crear una clave externa sin la palabra clave CONSTRAINT implica que el nombre de la restricción se asigna automáticamente.

Revisa el código. ¡Hay otro problema con las instrucción INSERT! Corrige los datos para que no se infrinjan las restricciones de clave externa. Deberás consultar la configuración en la up.sql pestaña del editor de código.

INSERT INTO
  users (id, name, country_code)
VALUES
  (1, 'Jerry', 'US');

INSERT INTO
  users (id, name, country_code)
VALUES
  (2, 'Amit', 'IND');

  UP.SQL

  PRAGMA foreign_keys = ON;

CREATE table countries (code TEXT PRIMARY KEY, name TEXT);

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  age INTEGER,
  country_code TEXT NOT NULL,
  username TEXT,
  password TEXT,
  is_admin BOOLEAN,
  FOREIGN KEY (country_code) REFERENCES countries (code)
);

INSERT INTO
  countries (code, name)
VALUES
  ('US', 'United States of America');

INSERT INTO
  countries (code, name)
VALUES
  ('IN', 'India');

  INSERT INTO
  users (id, name, country_code)
VALUES
  (1, 'Jerry', 'US');

INSERT INTO
  users (id, name, country_code)
VALUES
  (2, 'Amit', 'IN');

  | id |  name | age | country_code | username | password | is_admin |
|:--:|:-----:|:---:|:------------:|:--------:|:--------:|:--------:|
|  1 | Jerry |     |      US      |          |          |          |
|  2 |  Amit |     |      IN      |          |          |          |

## Esquema
Ya hemos usado la palabra esquema varias veces; hablemos de lo que significa. El esquema de una base de datos describe cómo se organizan los datos dentro de ella.

Los tipos de datos, los nombres de las tablas, los nombres de los campos, las restricciones y las relaciones entre todas esas entidades forman parte del esquema de una base de datos.

## No existe un esquema perfecto.
Al diseñar un esquema de base de datos, normalmente no existe una solución "correcta". Hacemos todo lo posible por elegir un conjunto razonable de tablas, campos, restricciones, etc., que permitan alcanzar los objetivos del proyecto.

Como ocurre con muchas cosas en programación, los diferentes diseños de esquemas conllevan diferentes ventajas e inconvenientes.

## Cómo decidir un esquema sensato
Usemos CashPal como ejemplo. Una decisión importante que debemos tomar es en qué tabla se almacenará el saldo del usuario. Como puedes imaginar, garantizar la precisión de nuestros datos al manejar dinero es fundamental . Queremos poder:

+ Mantener un registro del saldo actual de un usuario.
+ Consulte el saldo histórico en cualquier momento del pasado.
+ Consulte el registro de las transacciones que modificaron el saldo a lo largo del tiempo.

Hay muchas maneras de abordar este problema. Para nuestro primer intento, probemos el esquema más simple que satisfaga las necesidades de nuestro proyecto.

## Asignación
El equipo de arquitectura de CashPal ha optado por una única tabla transactions. Esta tablatransactions almacena las transacciones individuales y nos permite consultar el saldo actual de cada una. Si queremos ver el saldo actual, ¡basta con mirar la transacción más reciente!

## Cree la transactionstabla con los siguientes campos y restricciones:

1. [x] id– INTEGER,PRIMARY KEY
2. [x] sender_id–INTEGER
3. [x] recipient_id–INTEGER
4. [x] memo– TEXT,NOT NULL
5. [x] amount– REAL,NOT NULL
6. [x] balance– REAL,NOT NULL

CREATE TABLE transactions (
    id INTEGER PRIMARY KEY,
    sender_id INTEGER,
    recipient_id INTEGER,
    memo TEXT NOT NULL,
    amount REAL NOT NULL,
    balance REAL NOT NULL
);

| cid |     name     |   type  | notnull | dflt_value | pk |
|:---:|:------------:|:-------:|:-------:|:----------:|:--:|
|  0  |      id      | INTEGER |    1    |            |  1 |
|  1  |   sender_id  | INTEGER |    0    |            |  0 |
|  2  | recipient_id | INTEGER |    0    |            |  0 |
|  3  |     memo     |   TEXT  |    1    |            |  0 |
|  4  |    amount    |   REAL  |    1    |            |  0 |
|  5  |    balance   |   REAL  |    1    |            |  0 |

## Bases de datos relacionales
Hemos estado usando bastante el término "relacional" . ¡Es hora de que expliquemos qué significa realmente!

Una base de datos relacional es un tipo de base de datos que almacena datos de manera que puedan relacionarse fácilmente con otros datos. Por ejemplo, una base de datos userpuede tener muchos registros tweets. Existe una relación entre un registro usery sus registros tweet.

En una base de datos relacional:

1.  Los datos se representan normalmente en "tablas".
2. Cada tabla tiene "columnas" o "campos" que contienen atributos relacionados con el registro.
3. Cada fila o entrada en la tabla se llama registro .
4. Normalmente, cada registro tiene un identificador único Idllamado clave primaria .

## Ejemplo de base de datos relacional
Base de datos relacional

https://n9.cl/pf2z8

Esta base de datos tiene 3 tablas, Students, Courses, y StudentCourses. La StudentCoursestabla gestiona la relación entre las tablas Students y Courses.

Ejemplo 1: Curly
+ Curly tiene un Id de 2.
+ Podemos encontrar los cursos de Curly buscando en la StudentCoursestabla los registros que coincidan con el suyo StudentId.

Ejemplo 2: Mónadas de Haskell
+ "Haskell Monads" tiene un Id de 3.
+ Podemos encontrar a todos los estudiantes matriculados en el curso de Mónadas de Haskell consultando la CourseIdcolumna correspondiente en la StudentCoursestabla.
¿En cuántos cursos está matriculado Curly?
R= 1
¿Cuántos estudiantes hay en el curso de Mónadas de Haskell?
R=3

## Bases de datos relacionales frente a bases de datos no relacionales
La gran diferencia entre las bases de datos relacionales y no relacionales es que las bases de datos no relacionales tienden a anidar sus datos. En lugar de mantener siempre los registros en tablas separadas, a menudo almacenan registros dentro de otros registros .

Para simplificarlo al máximo, puedes imaginar las bases de datos no relacionales como enormes bloques de datos JSON. Si un usuario puede tener varios cursos, simplemente podrías agregar todos los cursos a su registro.

{
  "users": [
    {
      "id": 0,
      "name": "Elon",
      "courses": [
        {
          "name": "Biology",
          "id": 0
        }
      ]
    },
    {
      "id": 1,
      "name": "Curly",
      "courses": [
        {
          "name": "Biology",
          "id": 0
        }
      ]
    }
  ]
}

Esto suele generar datos duplicados en la base de datos. Obviamente, esto no es lo ideal, pero tiene algunas ventajas que analizaremos más adelante en el curso.

Base de datos relacional
https://n9.cl/pf2z8

Base de datos no relacional
https://n9.cl/rpbk6v

Las bases de datos NO RELACIONALES a menudo duplican datos, mientras que las bases de datos RELACIONALES normalmente no lo hacen.

Las bases de datos no relacionales a menudo conectan entidades similares mediante el uso de Datos anidados.

## 💡 Conclusión
Las bases de datos relacionales organizan los datos en tablas separadas, vinculando los registros relacionados mediante claves. Por ejemplo, los usuarios y los cursos se almacenarían en tablas separadas, de modo que no sería necesario copiar los detalles de un curso en el registro de cada usuario.

Las bases de datos no relacionales suelen almacenar información relacionada dentro de un registro como datos anidados; por ejemplo, un registro de usuario que contiene una lista de sus cursos. Esto facilita la recuperación conjunta de los datos, pero puede duplicar los detalles de los mismos cursos para varios usuarios.

+ La primera respuesta coincide con el patrón típico: las bases de datos no relacionales pueden duplicar datos, mientras que las bases de datos relacionales generalmente reducen la duplicación. 
+ La segunda respuesta describe cómo las bases de datos no relacionales suelen mantener juntas las entidades relacionadas.