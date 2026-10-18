# TABLAS
## Creación de una tabla
Para crear una nueva tabla en una base de datos, utilice la instrucción CREATE TABLE seguida del nombre de la tabla y los campos que desea que contenga.

CREATE TABLE 
    employees 
    (id INTEGER, 
    name TEXT, 
    age INTEGER, 
    is_manager BOOLEAN, 
    salary INTEGER);

A cada nombre de campo le sigue su tipo de dato. Hablaremos de los tipos de datos en un momento.

## Asignación
¡Comencemos a crear una tabla para la base de datos de CashPal! Crea la tabla people con los siguientes campos:

1. [x] id–INTEGER
2. [x] tag–TEXT
3. [x] name–TEXT
4. [x] age–INTEGER
5. [x] balance–REAL
6. [x] is_admin–BOOLEAN

# ﹗ Utilice INTEGERen su lugar INT antes de enviar su código.

Si bien ambas notaciones son funcionalmente idénticas, INTEGER es la palabra clave que cumple totalmente con el estándar. En este curso, preferimos INTEGER para mayor claridad, coherencia y mejor portabilidad entre dialectos SQL.

## Consejo
Si tienes curiosidad, el comando PRAGMA TABLE_INFO(TABLENAME); del archivo de prueba devuelve información sobre una tabla y sus campos.

**Respuesta:**

CREATE TABLE
  people 
  (id INTEGER, 
  tag TEXT, 
  name TEXT, 
  age INTEGER, 
  balance REAL, 
  is_admin BOOLEAN);

| cid |   name   |   type  | notnull | dflt_value | pk |
|:---:|:--------:|:-------:|:-------:|:----------:|:--:|
|  0  |    id    | INTEGER |    0    |            |  0 |
|  1  |    tag   |   TEXT  |    0    |            |  0 |
|  2  |   name   |   TEXT  |    0    |            |  0 |
|  3  |    age   | INTEGER |    0    |            |  0 |
|  4  |  balance |   REAL  |    0    |            |  0 |
|  5  | is_admin | BOOLEAN |    0    |            |  0 |


## Práctica Crear una tabla
En la mayoría de las bases de datos relacionales, una sola tabla no es suficiente para almacenar todos los datos que necesitamos. Normalmente creamos una tabla por cada entidad. Por ejemplo, una aplicación de redes sociales podría tener las siguientes tablas:

* users
* posts
* comments
* likes

## Asignación
Necesitamos una tabla que registre las transacciones entre nuestros usuarios de CashPal.

Crea la tabla transactions con los siguientes campos:

CREATE TABLE
  TRANSACTIONS 
  (id INTEGER, 
  recipient_id INTEGER, 
  sender_id INTEGER, 
  note TEXT, 
  amount REAL);

1. [x] id–INTEGER
2. [x] recipient_id–INTEGER
3. [x] sender_id–INTEGER
4. [x] note–TEXT
5. [x] amount–REAL

**Respuesta:**

| cid |     name     |   type  | notnull | dflt_value | pk |
|:---:|:------------:|:-------:|:-------:|:----------:|:--:|
|  0  |      id      | INTEGER |    0    |            |  0 |
|  1  | recipient_id | INTEGER |    0    |            |  0 |
|  2  |   sender_id  | INTEGER |    0    |            |  0 |
|  3  |     note     |   TEXT  |    0    |            |  0 |
|  4  |    amount    |   REAL  |    0    |            |  0 |
|  5  |   is_admin   | BOOLEAN |    0    |            |  0 |

# Modificar tablas

A menudo necesitamos modificar el esquema de nuestra base de datos sin borrarla y volver a crearla. Imagina que Twitter borrara su base de datos cada vez que necesitara añadir una función: ¡sería un desastre ! Tu cuenta y todos tus tuits se borrarían a diario.

En cambio, podemos usar la instrucción ALTER TABLE para realizar cambios directamente sin eliminar ningún dato.

ALTERAR TABLA
Con SQLite, una instrucción ALTER TABLE te permite:

1. Cambiar el nombre de una tabla o columna.

ALTER TABLE employees
RENAME TO contractors;

ALTER TABLE contractors
RENAME COLUMN salary TO invoice;

2. Agregar o eliminar una columna

ALTER TABLE contractors
ADD COLUMN job_title TEXT;

ALTER TABLE contractors
DROP COLUMN is_manager;

A diferencia de algunas bases de datos SQL, SQLite no admite realizar múltiples operaciones (como agregar varias columnas) en una sola instrucción ALTER TABLE. Cada cambio debe realizarse en un comando ALTER TABLE independiente.

## Asignación
¡Necesitamos hacer algunos cambios en la tabla people! En este momento, tenemos estas seis columnas (mostradas como filas, para que podamos mostrar los tipos de datos):

| CID |   NAME   |   TYPE  | NOTNULL | DFLT VALUE | PK |
|:---:|:--------:|:-------:|:-------:|:----------:|:--:|
|  0  |    id    | INTEGER |    0    |            |  0 |
|  1  |    tag   |   TEXT  |    0    |            |  0 |
|  2  |   name   |   TEXT  |    0    |            |  0 |
|  3  |    age   | INTEGER |    0    |            |  0 |
|  4  |  balance |   REAL  |    0    |            |  0 |
|  5  | is_admin | BOOLEAN |    0    |            |  0 |

1. [x] Cambie el nombre de la tabla a users.
2. [x] En users, cambie el nombre de la columna tag a username.
3. [x] En users, agregue la columna password (TEXT).

**Respuesta**

ALTER TABLE people
RENAME TO users;

ALTER TABLE users
RENAME COLUMN tag TO username;

ALTER TABLE users
ADD COLUMN password TEXT;

| cid |   name   |   type  | notnull | dflt_value | pk |
|:---:|:--------:|:-------:|:-------:|:----------:|:--:|
|  0  |    id    | INTEGER |    0    |            |  0 |
|  1  | username |   TEXT  |    0    |            |  0 |
|  2  |   name   |   TEXT  |    0    |            |  0 |
|  3  |    age   | INTEGER |    0    |            |  0 |
|  4  |  balance |   REAL  |    0    |            |  0 |
|  5  | is_admin | BOOLEAN |    0    |            |  0 |
|  6  | password |   TEXT  |    0    |            |  0 |

# Introducción a las migraciones

Una migración de base de datos es un cambio en la estructura de una base de datos relacional. Se Puede imaginar como una confirmación en Git, pero para el esquema de una base de datos. Cada migración registra cómo evoluciona la estructura de una base de datos con el tiempo.

*Por ejemplo, cuando anteriormente usamos una instrucción ALTER TABLE para agregar una nueva columna, estábamos realizando una migración*.

Las migraciones son esenciales para adaptar la base de datos a los requisitos cambiantes, corregir errores e implementar nuevas funcionalidades. En un entorno de equipo, las migraciones garantizan que todos apliquen los mismos cambios en el mismo orden.

Las buenas migraciones implican cambios pequeños, incrementales e idealmente reversibles en una base de datos. Como es de imaginar, al trabajar con bases de datos grandes, *¡realizar cambios puede ser intimidante!* Se debe tener cuidado al escribir las migraciones para no dañar ningún sistema que dependa del esquema de la base de datos anterior.

## Ejemplo de una mala migración
Digamos que el sistema backend de CashPal ejecuta esta consulta SQL regularmente:

SELECT
  *
FROM
  people;

Si cambiamos el nombre de la tabla people a users en una migración, pero olvidamos actualizar el código, esta consulta fallará porque la tabla people ya no existe.

## 💡 Un enfoque más seguro
* Es implementar los cambios de esquema y aplicación en **"fases compatibles con versiones anteriores"** *- agregando y limpiando -*. 
* Manténiendo el esquema antiguo disponible hasta que ningún código en ejecución dependa de él.

¿Cuál de las siguientes afirmaciones sobre las migraciones es FALSA?

1. [x] Puedes ser rápido y despreocupado al escribir las migraciones: una mala migración es fácil de solucionar.

2. [] Las migraciones bien escritas son reversibles.

3. [] Las migraciones son cambios incrementales que se realizan en una base de datos.

4. [] Una buena migración tiene en cuenta cualquier sistema que dependa del esquema existente.

# Explicación
Las migraciones pueden alterar o eliminar datos reales y afectar a las aplicaciones en ejecución. Una migración defectuosa puede provocar fallos en las consultas, tiempos de inactividad o ser difícil de revertir, especialmente después de haberse ejecutado en producción.

Las demás afirmaciones describen buenas prácticas de migración:

+ Son incrementales: pequeños cambios de esquema ordenados.
+ Idealmente, deberían ser reversibles.
+ Deben tener en cuenta el código y los sistemas existentes que aún dependen del esquema antiguo.

Por ejemplo, cambiar el nombre *people* inmediatamente a *users* puede romper cualquier código de la aplicación que aún se esté ejecutando SELECT * FROM people;. Un despliegue más seguro mantiene la compatibilidad mientras se actualiza la aplicación.

# Migración ascendente (UP Migration)
Para gestionar las migraciones, utilizamos un sistema sencillo basado en direcciones ascendentes (up) y descendentes (down) .

+ La migración up aplica cambios para que su esquema avance.
+ La migración down revierte esos cambios al estado anterior.

Esto permite a los desarrolladores cambiar de forma segura entre versiones del esquema durante el desarrollo y las implementaciones en producción.

Vamos a escribir el código SQL para una migración *up* que añada nuevas funcionalidades a nuestra base de datos.

## Asignación
Vamos a añadir más columnas a la tabla transactions. Necesitamos saber si cada transacción entre dos usuarios se completó correctamente. Nuestra base de datos también debe registrar el tipo de transacción.

La tabla transactions tiene este aspecto en este momento:

| cid |     name     |   type  | notnull | dflt_value | pk |
|:---:|:------------:|:-------:|:-------:|:----------:|:--:|
|  0  |      id      | INTEGER |    0    |            |  0 |
|  1  | recipient_id | INTEGER |    0    |            |  0 |
|  2  |   sender_id  | INTEGER |    0    |            |  0 |
|  3  |     note     |   TEXT  |    0    |            |  0 |
|  4  |    amount    |   REAL  |    0    |            |  0 |

Complete las siguientes instrucciones SQL en este orden :

1. [x] Agregue la columna BOOLEAN was_successful a la tabla transactions.
2. [x] Agregue la columna TEXT transaction_type a la tabla transactions.

### *﹗BOOL es técnicamente válido, pero la asignación espera BOOLEAN – así que use BOOLEAN en lugar de BOOL para pasar.*

**Respuesta:** 

AlTER TABLE transactions
ADD COLUMN was_successful BOOLEAN; 

ALTER TABLE transactions
ADD COLUMN transaction_type TEXT;

| cid |       name       |   type  | notnull | dflt_value | pk |
|:---:|:----------------:|:-------:|:-------:|:----------:|:--:|
|  0  |        id        | INTEGER |    0    |            |  0 |
|  1  |   recipient_id   | INTEGER |    0    |            |  0 |
|  2  |     sender_id    | INTEGER |    0    |            |  0 |
|  3  |       note       |   TEXT  |    0    |            |  0 |
|  4  |      amount      |   REAL  |    0    |            |  0 |
|  5  |  was_successful  | BOOLEAN |    0    |            |  0 |
|  6  | transaction_type |   TEXT  |    0    |            |  0 |

# Migración descendente (Down Migration)
¡La migración que aplicamos terminó causando problemas en producción! Es posible que la aplicación no estuviera preparada para las nuevas columnas.

En situaciones como esta, necesitamos revertir los cambios de forma segura mediante una migración descendente (Down).

## Por qué importan las migraciones descendentes
Las migraciones descendentes nos permiten:

+ Deshacer los cambios introducidos por una migración ascendente
+ Recuperación rápida de errores o problemas de compatibilidad en producción.
+ Mantén la coherencia de nuestro esquema en todos los entornos (local, de pruebas, de producción).

Una migración descendente bien documentada debería revertir por completo los cambios realizados en la migración ascendente. En nuestro caso, eso significa eliminar las dos columnas que acabamos de añadir.

Por ejemplo, para eliminar una columna puede utilizar el comando DROP COLUMN:

ALTER TABLE users
DROP COLUMN email;

## Asignación
Complete la siguiente downmigración:

1. [x] Elimine la was_successfulcolumna de la tabla transactions.
2. [x] Elimine la transaction_typecolumna de la tabla transactions.

Esto restablecerá el esquema a su estado original.

**Respuesta:**

ALTER TABLE transactions 
DROP COLUMN was_successful;

ALTER TABLE transactions
DROP COLUMN transaction_type;

| cid |     name     |   type  | notnull | dflt_value | pk |
|:---:|:------------:|:-------:|:-------:|:----------:|:--:|
|  0  |      id      | INTEGER |    0    |            |  0 |
|  1  | recipient_id | INTEGER |    0    |            |  0 |
|  2  |   sender_id  | INTEGER |    0    |            |  0 |
|  3  |     note     |   TEXT  |    0    |            |  0 |
|  4  |    amount    |   REAL  |    0    |            |  0 |

# Revisión de migración
Analicemos una migración más realista que refleje una evolución común.

### Ejemplo
La tabla projects se está renombrando initiatives para reflejar mejor cómo los equipos planifican y realizan el seguimiento del trabajo a largo plazo.

También queremos registrar la fecha de lanzamiento oficial de cada iniciativa.

+ Migración UP (ascendente):

ALTER TABLE projects
RENAME TO initiatives;

ALTER TABLE initiatives
ADD COLUMN launched_at TIMESTAMP;

+ Migración DOWN (descendente):

ALTER TABLE initiatives
DROP COLUMN launched_at;

ALTER TABLE initiatives
RENAME TO projects;

Este par de migraciones es reversible y seguro. Si algo falla, podemos deshacerlo.

## Herramientas de migración del mundo real
En proyectos reales, no realizamos migraciones SQL directas. Utilizamos herramientas que ayudan a:

+ Realiza un seguimiento de las migraciones que se han aplicado.
+ Organiza las migraciones en archivos.
+ Aplicar y retirar de forma segura.

## Herramientas populares

|      Tool      |  Language  |          Notes         |
|:--------------:|:----------:|:----------------------:|
|      Goose     |     Go     |     Native Go tool     |
|     Flyway     | Java, etc. |    Simple file-based   |
|    Liquibase   |    Java    |    More config-heavy   |
|     Alembic    |   Python   |     For SQLAlchemy     |
| Prisma Migrate | TypeScript |  Works with Prisma ORM |
|   Drizzle Kit  | TypeScript | Works with Drizzle ORM |

## Ejemplo de flujo de trabajo con una herramienta
Esto variará según la herramienta que utilice.

1. Escribir archivos de migración.
  * 001_add_columns_to_transactions.up.sql
  * 001_add_columns_to_transactions.down.sql
2. Aplícalos mediante una CLI (interfaz de línea de comandos):
    migrate up

3. Tu herramienta registra qué migraciones se ejecutaron y evita las migraciones duplicadas.

## Control de versiones para su esquema
Los archivos de migración se confirman como código. Viajan con tu proyecto, por lo que tus compañeros de equipo y los CIs (sistemas de integración continua) siempre aplican los mismos cambios de esquema en el orden correcto.

¿Por qué las migraciones "buenas" se escriben de forma reversible?

1. [] No lo son

2. [x] De modo que, si algo sale mal, se puedan revertir los cambios.

3. [] Porque siempre debes deshacer los cambios antes de aplicar otros nuevos.

* Una migración modifica el esquema de la base de datos, por ejemplo, cambiando el nombre de una tabla o añadiendo una columna. Una migración reversible incluye un mecanismo para deshacer esos cambios, de modo que si la actualización causa problemas, se puede restaurar el esquema anterior. Por ejemplo, una migración ascendente podría añadir una columna, mientras que su migración descendente la eliminaría.

¿Las migraciones de bases de datos suelen ir acompañadas de actualizaciones del código de la aplicación?

1. [x] Sí

2. [] No

* Las migraciones suelen ir acompañadas de actualizaciones del código de la aplicación, ya que este puede necesitar utilizar el nuevo esquema. Por ejemplo, si se cambia el nombre de una tabla, las consultas de la aplicación deben actualizarse para que hagan referencia a su nuevo nombre. Los cambios en la base de datos y la aplicación deben coordinarse para garantizar su compatibilidad.

# Tipos de datos SQL
SQL, como lenguaje, admite muchos tipos de datos diferentes. Sin embargo, los tipos que admita su sistema de gestión de bases de datos (DBMS) dependerán de la base de datos que elija.

En cuanto a SQLite, solo admite los tipos más básicos , ¡y SQLite es lo que estamos usando en este curso!

## Tipos de datos de SQLite
Vamos a repasar los tipos de datos que admite SQLite y cómo se almacenan.

1. NULL– Valor nulo.
2. INTEGER– Entero con signo almacenado en 0, 1, 2, 3, 4, 6 u 8 bytes.
3. REAL– Valor de punto flotante almacenado como un número de punto flotante IEEE de 64 bits.
4. TEXT– Cadena de texto almacenada utilizando la codificación de la base de datos, generalmente UTF-8.
5. BLOB– Abreviatura de Binary Large Object (Objeto Binario Grande) y se utiliza normalmente para imágenes, audio u otros contenidos multimedia.
6. BOOLEAN– Los valores booleanos se escriben en las consultas SQLite como trueo o false, pero se registran como 1 o 0.

#﹗En este curso se está utilizando el tipo REAL de datos para algunos campos que representan cantidades monetarias. Esto es por simplicidad.

En la práctica, para evitar problemas con las operaciones matemáticas de punto flotante, lo más recomendable es usar números decimales INTEGER para las cantidades monetarias. El valor representa entonces, la denominación más pequeña. Por ejemplo, $42.67 se almacenaría como 4267centavos.

# Valores booleanos
Es importante destacar que SQLite no tiene una clase de almacenamiento BOOLEAN separada. En cambio, los valores booleanos se almacenan como enteros:

* 0=false
* 1=true

*En realidad no es tan raro: ¡al fin y al cabo, los valores booleanos no son más que bits binarios!*

SQLite te permitirá escribir tus consultas usando expresiones boolean y palabras clave true/false, pero internamente convertirá los valores booleanos a enteros.

¿Cómo se almacena y se presenta un valor booleano "verdadero" en SQLite?

1. [] La cadena 'verdadero'
2. [] La cadena 'falso'
3. [x] 1
4. [] 0

Todas las bases de datos SQL admiten los mismos tipos de datos.

1. [] Verdadero
2. [x] Falso

¿Qué tipo de dato usarías para almacenar la dirección de correo electrónico de un usuario?

1. [x] TEXTO
2. [] REAL
3. [] INTEGER (ENTERO)
4. [] BLOB

# 💡 Detalles importantes:

1. ¿Cómo se almacena y se presenta un valor booleano 'verdadero' en SQLite?
   + Respuesta: 1
   + Explicación: SQLite no tiene una clase BOOLEAN de almacenamiento dedicada. Si bien se pueden escribir true y false en las consultas, SQLite los convierte internamente en enteros: 1 representa true y 0 representa false. Cuando SQLite muestra o almacena el valor, utiliza esa representación entera.

2. Todas las bases de datos SQL admiten los mismos tipos de datos.
   + Respuesta: False
   + Explicación: Si bien SQL es un lenguaje estandarizado, el motor de base de datos (DBMS) determina qué tipos de datos se admiten y cómo se implementan. Por ejemplo, PostgreSQL admite tipos complejos como UUID, JSONB, y BOOLEAN nativos, mientras que SQLite mantiene las cosas minimalistas con solo cinco clases de almacenamiento principales (NULL, INTEGER, REAL, TEXT, y BLOB).

3. ¿Qué tipo de dato usarías para almacenar la dirección de correo electrónico de un usuario?
   + Respuesta: TEXT
   + Explicación: Una dirección de correo electrónico es una secuencia de caracteres que contiene letras, números y símbolos (como @/ .). En SQLite, los datos de caracteres se almacenan utilizando el tipo de dato TEXT que codifica las cadenas en UTF-8 (u otras codificaciones de texto). Los números (INTEGER/REAL) no pueden contener símbolos ni letras, y los BLOB están destinados a datos binarios como imágenes o archivos sin procesar.

# Práctica – Tabla de publicaciones
Estás trabajando en la nueva función de redes sociales de CashPal, llamada "CashPal Chatter", que busca revolucionar las conversaciones financieras en línea. Los usuarios pueden publicar una foto de su última compra, junto con texto e información adicional. Se te ha asignado la tarea de crear la nueva tabla "publicaciones".

## Asignación
Escriba una instrucción SQL para crear una nueva tabla llamada posts, que debe contener las siguientes columnas:

1. [x] id
2. [x] image_url
3. [x] description
4. [x] author_id
5. [x] is_sponsored

Utilice los tipos de datos que tengan más sentido según el nombre de la columna. Para las columnas de ID, supongamos que podemos usar simplemente INTEGER.

**Respuesta**

CREATE TABLE
  posts
  (id INTEGER,
  image_url TEXT,
  description TEXT,
  author_id INTEGER,
  is_sponsored BOOLEAN);

  |     name     |   type  |
|:------------:|:-------:|
|      id      | INTEGER |
|   image_url  |   TEXT  |
|  description |   TEXT  |
|   author_id  | INTEGER |
| is_sponsored | BOOLEAN |

# Práctica – Migración de la tabla de publicaciones
¡CashPal Chatter es todo un éxito! Tras varias semanas de uso, los ingenieros de CashPal han decidido que es necesario realizar algunos cambios en nuestra poststabla. Se te ha pedido que escribas una migración para modificarla.

## Asignación
Escribe una migración ascendente para la poststabla que logre lo siguiente:

1. [x] La columna author_id debe ser renombrada a poster_id.
2. [x] Agregue una nueva columna llamada is_edited con un tipo BOOLEAN.
3. [x] DROP (borra) la columna is_sponsored.

**Respuesta:**

ALTER TABLE posts
  RENAME COLUMN author_id TO poster_id;

ALTER TABLE posts
  ADD COLUMN is_edited BOOLEAN;

ALTER TABLE posts
  DROP is_sponsored;

  | cid |     name    |   type  | notnull | dflt_value | pk |
|:---:|:-----------:|:-------:|:-------:|:----------:|:--:|
|  0  |      id     | INTEGER |    0    |            |  0 |
|  1  |  image_url  |   TEXT  |    0    |            |  0 |
|  2  | description |   TEXT  |    0    |            |  0 |
|  3  |  poster_id  | INTEGER |    0    |            |  0 |
|  4  |  is_edited  | BOOLEAN |    0    |            |  0 |

## Nota adicional:

Está migración está compuesta por tres cambios independientes, en el orden que se pidio:

1. Renombrar una columna

ALTER TABLE posts
  RENAME COLUMN author_id TO poster_id;

ALTER TABLE modifica una tabla existente; RENAME COLUMN cambia el nombre sin borrar los datos de esa columna.

2. Agregar una columna

ALTER TABLE posts
  ADD COLUMN is_edited BOOLEAN;

Añade is_edited a posts. El tipo BOOLEAN indica que guardará un valor verdadero o falso.

3. Eliminar una columna

ALTER TABLE posts
  DROP is_sponsored;

Quita is_sponsored de la tabla, junto con los datos guardados en esa columna.

Cada instrucción modifica la estructura de posts; al ejecutarlas, la tabla termina con poster_id y is_edited, y sin is_sponsored.