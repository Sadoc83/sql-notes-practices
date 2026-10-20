# CRUD
CRUD es un acrónimo que describe las cuatro formas básicas en que las aplicaciones trabajan con los datos almacenados: CREATE, READ, UPDATE, y DELETE. 

Estas cuatro operaciones son la base de casi todas las bases de datos y se corresponden directamente con muchas funcionalidades de las aplicaciones del mundo real:

+ CREATE: registrar un nuevo usuario, publicar un comentario
+ READ: cargar el perfil de un usuario, ver una lista de productos
+ UPDATE: editar un comentario, cambiar tu contraseña
+ DELETE: eliminar una publicación, cerrar una cuenta

## Asignación
Hemos creado una tabla para ti llamada crud, es una tabla de juguete que estamos usando para practicar entrevistas en CashPal.

¡Determina qué comando SQL se puede usar para una operación READ y úsarlo para leer todos los campos de todos los registros de la tabla crud!

## Pista
Leer datos es simplemente otra forma de decir recuperar datos.


## 🧱 Análisis del Problema y Proceso de Decisión

1. Identificar la operación solicitada (READ):
El enunciado nos pide realizar una operación de lectura. En SQL, "leer" o "recuperar" datos no modifica la base de datos, solo nos muestra la información que ya existe. La palabra clave universal para leer datos es SELECT.

2. Identificar qué campos queremos leer:
Las instrucciones dicen explícitamente: "leer todos los campos". En lugar de escribir el nombre de cada columna uno por uno, SQL nos da un atajo heurístico: el uso del asterisco (*), que actúa como un comodín para traer todas las columnas disponibles.

3. Identificar la procedencia de los datos:
El ejercicio nos dice que la tabla de juguete se llama crud. Por lo tanto, usamos nuestra conocida cláusula FROM crud.

4. ¿Necesitamos filtros?
El enunciado nos pide traer "todos los registros", lo que significa que no debemos usar la cláusula WHERE. Queremos el universo completo de la tabla.

## Resupuesta:

SELECT * FROM crud;

## 📋 ¿Por qué estructuramos esto así?

• SELECT: Le avisa al motor de la base de datos que vas a realizar una operación de lectura (READ).
• *: Le ordena al sistema que extraiga todas las columnas sin excepción.
• FROM crud: Especifica la tabla exacta desde donde se consultará la información.

# Insertar declaración
¡Las tablas son prácticamente inútiles sin datos! En SQL, podemos agregar registros a una tabla mediante una instrucción INSERT INTO en SQL. Al usar esta instrucción INSERT, primero debemos especificar la tabla en la que se insertará el registro, seguida de los fields que estarán dentro de la tabla que se agregará VALUES.

Ejemplo de declaración INSERT INTO:

    INSERT INTO
    employees (id, name, title)
    VALUES
    (1, 'Allan', 'Engineer');

## Asignación
¡Comencemos a agregar manualmente algunos de los registros a nuestra tabla users!

### 🚨 *Atención a la instrucción CREATE TABLE en el código de configuración en la pestaña up.sql de la estructura users de la tabla y utilice esa información para insertar los siguientes registros en la tabla:*

## Registro 1
1. [x] id:1
2. [x] name:'David'
3. [x] age:34
4. [x] country_code:'US'
5. [x] username:'DavidDev'
6. [x] password:'insertPractice'
7. [x] is_admin:false

## Registro 2
1. [x] id:2
2. [x] name:'Samantha'
3. [x] age:29
4. [x] country_code:'BR'
5. [x] username:'Sammy93'
6. [x] password:'addingRecords!'
7. [x] is_admin:false

pestaña: up.sql

    CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    country_code TEXT NOT NULL,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    is_admin BOOLEAN
    );


## 🧱 Análisis del Problema y Proceso de Decisión

1. Estructura base de INSERT INTO:

Primero debemos decirle al motor la tabla objetivo y listar entre paréntesis todas las columnas que vamos a rellenar:

INSERT INTO users (id, name, age, country_code, username, password, is_admin)

2. Asignación de Valores (VALUES):

Inmediatamente después, usamos la palabra clave VALUES y abrimos otro paréntesis para vaciar los datos del primer registro.

	• Tipos de texto (TEXT): Datos como el nombre, el código de país, el usuario y la contraseña deben ir obligatoriamente entre comillas simples ('David').
	• Tipos numéricos y booleanos (INTEGER, BOOLEAN): Datos como el ID, la edad y el estado de administrador van como números y palabras clave puras sin comillas (1, 34, false).

3. Múltiples inserciones:

En SQL, cada instrucción INSERT INTO se cierra con un punto y coma (;). Para agregar al segundo usuario (Samantha), escribimos una estructura idéntica justo abajo, asegurándonos de que su ID sea 2 para respetar la regla de la PRIMARY KEY única que vimos en retos anteriores.

## 🛠️ Código SQL 


    INSERT INTO
    users (id, name, age, country_code, username, password, is_admin)
    VALUES
    (1, 'David', 34, 'US', 'DavidDev', 'insertPractice', false);

    INSERT INTO
    users (id, name, age, country_code, username, password, is_admin)
    VALUES
    (2, 'Samantha', 29, 'BR', 'Sammy93', 'addingRecords!', false);


## 🔍 Procurar el éxito de la consulta, como un buen Ingeniero en Aseguramiento de la Calidad que se respete.

• Orden de las columnas: El orden en los paréntesis de VALUES coincide exactamente con los campos listados arriba (id con 1, name con 'David', etc.).

• Separación por comas: Cada valor dentro de los paréntesis está correctamente separado por una coma.

• Consistencia de Tipos: Las banderas booleanas (false) están escritas en minúsculas y sin comillas, permitiendo que el motor de la base de datos las interprete correctamente en el Backend.

# Incremento automático
Muchos dialectos de SQL admiten una característica de AUTO INCREMENT. Al insertar registros en una tabla con AUTO INCREMENT habilitada, la base de datos asignará automáticamente el siguiente valor. 

En SQLite, un idcampo entero que tenga la restricción PRIMARY KEY se autoincrementará por defecto.

## Identificaciones
Dependiendo de cómo esté configurada su base de datos, puede que esté utilizando ididentificadores tradicionales o identificadores únicos universales (UUID ). SQL no admite el autoincremento de identificadores uuid, por lo que si su base de datos los utiliza, su servidor tendrá que gestionar los identificadores uuid cambiantes para cada registro.

## Uso de AUTO INCREMENT en SQLite
Utilizamos id SQL tradicional en nuestra base de datos, por lo que podemos aprovechar la función de autoincremento. Las distintas variantes de SQL implementan esta función de forma diferente, pero en SQLite cualquier columna que tenga la restricción INTEGER PRIMARY KEY se autoincrementará. Por lo tanto, podemos omitir el campo id en la instrucción INSERT y permitir que la base de datos lo agregue automáticamente.

## Asignación
Vamos a añadir más registros a nuestra tabla users, pero permitiendo que la base de datos incremente automáticamente el campo id. Añada los siguientes registros a la base de datos:

## Registro 1
1. [x] name:'Lance'
2. [x] age:20
3. [x] country_code:'US'
4. [x] username:'LanChr'
5. [x] password:'bootdevisbest'
6. [x] is_admin:false

## Registro 2
1. [x] name:'Tiffany'
2. [x] age:28
3. [x] country_code:'US'
4. [x] username:'Tifferoon'
5. [x] password:'autoincrement'
6. [x] is_admin:true


# 🧱 Análisis del Problema y Proceso de Decisión

1. La regla de Oro de SQLite:

Como la columna id en el esquema original fue declarada como INTEGER PRIMARY KEY, SQLite activa de forma invisible su motor de autoincremento. Esto significa que debemos quitar por completo la palabra id de la lista de columnas y no enviar ningún número para ella en los VALUES.

2. Estructurar la lista de campos:
Al omitir el id, nuestra lista de columnas objetivo se reduce de 7 a 6 campos:
(name, age, country_code, username, password, is_admin)

3. Asignación de Valores (VALUES):
Al igual que en el ejercicio anterior, creamos los bloques de valores respetando estrictamente el nuevo orden de 6 campos. Las cadenas de texto (TEXT) van con comillas simples y los números (INTEGER) y booleanos (BOOLEAN) van limpios.

	• Registro 1 (Lance): 'Lance', 20, 'US', 'LanChr', 'bootdevisbest', false
	• Registro 2 (Tiffany): 'Tiffany', 28, 'US', 'Tifferoon', 'autoincrement', true

## 🛠️ Código SQL 


INSERT INTO
  users (name, age, country_code, username, password, is_admin)
VALUES
  ('Lance', 20, 'US', 'LanChr', 'bootdevisbest', false);

INSERT INTO
  users (name, age, country_code, username, password, is_admin)
Usa el código con precaución.

INSERT INTO
  users (name, age, country_code, username, password, is_admin)
VALUES
  ('Tiffany', 28, 'US', 'Tifferoon', 'autoincrement', true);


## 🔍 Auditoria como todo un excelentisimo profesional de QA

• Ausencia de id: Al no incluir el campo id, el Backend calculará de forma automática que a Lance le corresponde el id = 3 y a Tiffany el id = 4 (continuando la secuencia de David y Samantha del ejercicio anterior).

• Consistencia Boolean: El campo is_admin de Tiffany se ingresó como true puro sin comillas, cumpliendo con los requerimientos lógicos del sistema.

# Entrada manual
¡Introducir manualmente cada registro INSERT en una base de datos sería una tarea extremadamente laboriosa! Trabajar con SQL puro, como lo hacemos ahora, no es muy común al diseñar sistemas de backend.

Al trabajar con SQL dentro de un sistema de software, como una aplicación web de backend, normalmente tendrás acceso a un lenguaje de programación como **Go** o **Python**. Por ejemplo, un servidor backend escrito en Go puede usar la concatenación de cadenas para crear sentencias SQL dinámicamente, ¡y así es como suele hacerse!

    sqlQuery := fmt.Sprintf(`
    INSERT INTO users(name, age, country_code)
    VALUES ('%s', %v, '%s');
    `, user.Name, user.Age, user.CountryCode)

## Inyección SQL
El ejemplo anterior es una simplificación excesiva de lo que realmente sucede al acceder a una base de datos mediante código Go. En esencia, es correcto. La interpolación de cadenas es la forma en que los sistemas de producción acceden a las bases de datos. Dicho esto, debe hacerse con cuidado para evitar vulnerabilidades de seguridad.

## 💡 Pregunta:
¿Cada vez que alguien crea una cuenta en boot.dev, Allan o Lane tienen que agregarla manualmente a la base de datos escribiendo a mano una consulta SQL?

## 👉 Respuesta: Falso

Explicación desde la perspectiva de QA/Backend:
Si Boot.dev tiene más de 1.4 millones de estudiantes registrados, sería humanamente imposible que Allan o Lane estuvieran despiertos las 24 horas del día escribiendo consultas a mano cada vez que alguien hace clic en "Registrarse". En el mundo real, los fundadores o ingenieros no escriben los datos de los usuarios finales a mano; de eso se encarga la automatización del sistema.

## Recordatorio, de como funcionan las tripas SQL.
Dentro de los sistemas backend, las consultas SQL suelen ser Generado por código.

• Generado por código. Cuando interactúas con una aplicación (por ejemplo, al escribir tu usuario y contraseña en una página web), el código del servidor (ya sea escrito en Python, Go o JavaScript) toma las variables que tú escribiste en la pantalla, *arma la consulta automáticamente tras bambalinas* (usando herramientas llamadas ORMs o drivers de bases de datos) y la ejecuta en milisegundos.

• ¿Cuándo se escriben a mano? Las consultas se escriben a mano principalmente cuando, como profesional de QA o Data Analyst, se estan haciendo pruebas manuales en tu entorno de desarrollo, limpiando datos, ejecutando scripts de mantenimiento o resolviendo acertijos en plataformas de aprendizaje como Boot.dev o TripleTen 😇

# Contar
Podemos usar una la instrucción SELECT para obtener el número de registros en una tabla. Esto puede ser muy útil cuando necesitamos saber cuántos registros hay, pero no nos interesa especialmente su contenido.

*ejemplo en SQLite:*

    SELECT
        COUNT(*)
    FROM
        employees;

En este caso *, se refiere al nombre de una columna. No nos interesa el recuento de una columna específica; queremos saber el número total de registros, por lo que podemos usar el comodín (*).

## Asignación
Nuestro equipo de estrategia comercial en CashPal quiere saber cuántos usuarios tenemos de la aplicación. ¡No podemos usar ese número id para calcular el total porque las cuentas de usuario se pueden eliminar!

### Utilice una la instrucción COUNT(*) para recuperar el número de registros en la tabla users.

## ⚠️ *Se recomienda, utilizar siempre - * con COUNT - a menos que las instrucciones indiquen específicamente que se cuente una columna en particular.*

    SELECT
            COUNT(*)
        FROM
            users;

# Cláusula WHERE
Para seguir aprendiendo sobre las operaciones CRUD en SQL, ahora es necesario aprender a especificar mejor las instrucciones que enviamos a la base de datos. SQL acepta una instrucción WHERE dentro de una consulta que nos permite ser muy específicos con nuestras instrucciones.

Si no pudiéramos especificar el registro que queremos hacer consultas READ, o UPDATE o realizar DELETE a una base de datos sería muy frustrante y muy ineficiente.

## Uso de una cláusula WHERE
Supongamos que tenemos más de 9000 registros en nuestra tabla users. A menudo queremos consultar datos de usuarios específicos dentro de esa tabla sin recuperar todos los demás registros. Podemos usar una instrucción SELECT seguida de una cláusula WHERE para especificar qué registros recuperar. La instrucción SELECT permanece igual; simplemente agregamos la cláusula WHERE al final de la consulta SELECT. Por ejemplo:

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  age INTEGER NOT NULL,
  country_code TEXT NOT NULL,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  is_admin BOOLEAN
);

Esto seleccionará solo el campo name de cualquier usuario dentro de la tabla users cuyo WHERE power_levelcampo sea mayor o igual que 9000.

## Asignación
¡Necesitamos saber los nombres de username de todos los usuarios de nuestra tabla users que tienen privilegios de administrador! Recupéralos.

## 💡 Consulta el up archivo de migración ( 001_up.sql) para ver qué campos existen.

001_up.sql

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
    ('Aiko', 31, 'JP', 'AikoOps', 'sakuraCloud7', false);

    INSERT INTO
    users (name, age, country_code, username, password, is_admin)
    VALUES
    ('Marta', 36, 'ES', 'MartaDBA', 'oliveSQLtree', true);

    INSERT INTO
    users (name, age, country_code, username, password, is_admin)
    VALUES
    ('Kwame', 24, 'GH', 'KDev24', 'accraAPI', false);

    INSERT INTO
    users (name, age, country_code, username, password, is_admin)
    VALUES
    ('Noah', 41, 'AU', 'NoahRoot', 'koalaKernel', true);
        name
    FROM
        users
    WHERE
        power_level >= 9000;


## 🧱 Análisis del Problema y Proceso de Decisión

1. Identificar la columna a recuperar:

El enunciado pide explícitamente: "Necesitamos saber los nombres de username". Por lo tanto, en lugar de usar un asterisco o traer el campo name, nuestra instrucción inicial debe ser específica para esa columna:

SELECT username

1. Identificar la tabla origen:

Los datos siguen estando almacenados en la entidad de usuarios:

FROM users

3. Definir la condición de filtrado (WHERE):

La asignación nos dice que el criterio es encontrar a los usuarios "que tienen privilegios de administrador". Revisando el archivo 001_up.sql, vemos que el campo encargado de controlar esto es un booleano llamado is_admin. Para filtrar solo a los administradores, debemos evaluar que este campo sea igual a verdadero (true):

WHERE is_admin = true

## 🛠️ Código SQL

SELECT
    username
FROM
    users
WHERE
    is_admin = true;

## 📋 ¿Por qué estructurar esto así?

• SELECT username: Extrae únicamente la columna del apodo o identificador de usuario, cumpliendo con el requerimiento exacto.

• WHERE is_admin = true: Actúa como *un colador* en el Backend. Al ejecutarlo, el motor ignorará a usuarios como David o Samantha (que son false) y te devolverá únicamente los usernames de **Allan**, **Tiffany**, **Marta** y **Noah**, quienes sí tienen el valor en true.

# Cómo encontrar valores nulos
Puedes usar una cláusula WHERE para filtrar valores según sean o no, NULL.

### IS NULL
    SELECT
        name
    FROM
        users
    WHERE
        first_name IS NULL;

### IS NOT NULL
    SELECT
        name
    FROM
        users
    WHERE
        first_name IS NOT NULL;

## Asignación
La forma en que almacenamos las transacciones en CashPal es interesante. El usuario identificado por user_id es el "propietario" de cada transacción. Como user_id ya identifica al propietario, solo el usuario del otro lado necesita otro ID:

+ Si el propietario recibe dinero, sender_id identifica al remitente y recipient_id es NULL.

+ Si el propietario envía dinero, recipient_id identifica al destinatario y sender_id es NULL.

Seleccione de la tabla transactions todas las columnas correspondientes a las transacciones en las que el propietario recibe dinero.


## 🧱 Análisis del Problema y Proceso de Decisión

1. Identificar las columnas a recuperar:

El enunciado pide explícitamente: "select all columns" (seleccionar todas las columnas). Como ya sabemos, el atajo estándar y eficiente en SQL para traer todas las columnas es el comodín del asterisco:

SELECT *

1. Identificar la tabla origen:

Los datos financieros de CashPal se encuentran en la tabla de movimientos:
FROM transactions

3. Descifrar la regla del negocio (WHERE):

Aquí es donde el ejercicio tiene el truco de QA. Nos pide los registros "where the owner is receiving money" (donde el propietario está recibiendo dinero). Revisemos las dos reglas que te da la asignación:

	• Si el propietario envía dinero: sender_id es NULL (porque él es el emisor).
	• Si el propietario recibe dinero: sender_id identifica al emisor y recipient_id es NULL.

4. Formular la condición con IS NULL:

Dado que cuando el propietario recibe dinero la columna recipient_id se queda vacía, la condición exacta que debemos interrogar en el colador del WHERE es evaluar si esa columna es nula:

WHERE recipient_id IS NULL

## 🛠️ Código SQL

    SELECT
        *
    FROM
        transactions
    WHERE
        recipient_id IS NULL;

## 📋 ¿Por qué estructuramos esto así?

+ SELECT *: Cumple con el requerimiento de traer todo el registro completo para su auditoría visual.

+ WHERE recipient_id IS NULL: Filtra y aísla en el Backend únicamente los renglones donde el campo del receptor no tiene datos asignados, lo que por regla de negocio equivale a todas las transacciones de dinero entrante (ingresos) del usuario propietario.

# BORRAR
Cuando un usuario elimina su cuenta de Twitter o borra un comentario en un vídeo de YouTube, esos datos deben eliminarse de su base de datos correspondiente.

## Declaración ELIMINAR
Una instrucción DELETE elimina todos los registros de una tabla que coinciden con la cláusula WHERE. Por ejemplo:

    DELETE FROM employees
    WHERE
    id = 251;

Esta intrucción DELETE elimina todos los registros de la tabla employees que tengan un ID de 251!

## Asignación
Samantha, una de nuestras usuarias de CashPal, ha decidido eliminar su cuenta y dejar de usar nuestra aplicación... lo cual nos entristece 🤷🏽‍♂️🥲. En cualquier caso, ¡debemos eliminar su registro de la base de datos!

*Eliminar el registro de Samantha de la tabla de usuarios.*


## 🧱 Análisis del Problema y Proceso de Decisión

1. Identificar la tabla objetivo:

    El enunciado nos pide remover el registro de la tabla de usuarios. En SQLite, la sintaxis correcta inicia indicando la tabla de donde se van a borrar las filas:

DELETE FROM users

2. Formular el filtro crucial (WHERE):

    No queremos borrar a nadie más, únicamente a Samantha. Para aislarla con total precisión en el Backend, debemos usar una columna con un identificador único. Revisando los registros que insertamos en los retos anteriores para Samantha, sabemos dos cosas sobre ella:

        • Su columna name es igual a 'Samantha'.
        • Su columna username (que además tiene restricción UNIQUE) es igual a 'Sammy93'.
        • Su campo id (que es la PRIMARY KEY) es igual a 2.

3. Elegir la mejor columna para el filtro:

    En las bases de datos de producción, la mejor práctica de control de calidad es filtrar siempre por la PRIMARY KEY (id) o por un campo UNIQUE (username), ya que si usamos simplemente name = 'Samantha', nos arriesgamos a borrar a otras usuarias que se llamen igual. Al usar el ID o el username, nos aseguramos de dar en el blanco exacto.

## 🛠️ Código SQL

+ Opción A (Filtrando por ID - Recomendada):

DELETE FROM users
WHERE id = 2;

+ Opción B (Filtrando por Username):

DELETE FROM users
WHERE username = 'Sammy93';


## 📋 ¿Por qué funciona de forma segura?

+ DELETE FROM users: Le da la instrucción al motor de remover filas en esa entidad específica.

+ WHERE id = 2: Acota el impacto de la eliminación a un único registro. Al ejecutarse, los datos de Samantha desaparecerán del Backend de CashPal de forma definitiva, cumpliendo con la solicitud de la baja.


