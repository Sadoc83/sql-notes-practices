# El Peligro de eliminar datos
Eliminar datos puede ser una operación peligrosa. Una vez eliminados, ¡recuperarlos puede ser muy difícil, si no imposible ! Hablemos de algunas maneras comunes en que los ingenieros de back-end se protegen contra la pérdida de datos valiosos de los clientes.

Al escribir manualmente DELETE, primero ejecute una consulta con SELECT la misma cláusula WHERE para previsualizar las filas afectadas.


## Estrategia 1 – Copias de seguridad
Si utilizas un servicio en la nube como Cloud SQL de GCP o RDS de AWS, siempre debes activar las copias de seguridad automáticas. Estas crean una instantánea automática de toda tu base de datos a intervalos regulares y la conservan durante un tiempo determinado.

La base de datos Boot.dev tiene una copia de seguridad diaria que conservamos durante 30 días. Si por accidente ejecuto una consulta que borra datos valiosos, puedo restaurarlos desde la copia de seguridad.

Deberías tener una estrategia de respaldo para las bases de datos de producción.

## Estrategia 2 – Eliminación lógica
Una "eliminación lógica" consiste en no borrar realmente los datos de la base de datos, sino simplemente marcarlos como eliminados. Por ejemplo, se puede asignar una fecha deleted_at  a la fila que se desea eliminar. Luego, en las consultas, se ignoran todos los registros que tengan una fecha deleted_at asignada. La idea es que esto permita que la aplicación se comporte como si estuviera eliminando datos, pero siempre se puede recuperar cualquier dato que se haya borrado.

Probablemente solo deberías eliminar archivos temporalmente si tienes una razón específica para hacerlo. Las copias de seguridad automatizadas deberían ser suficientes para la mayoría de las aplicaciones que solo buscan protegerse contra errores de los desarrolladores.

## 🏋🏽‍♂️ Para ejercitar la comprensión

### 1. Deberías *casí siempre* tener copias de seguridad automatizadas de la base de datos de producción.


## 🔍 Explicación desde la perspectiva de QA y DevOps:

* ¿Por qué "Casi siempre" (o Siempre)? La base de datos de producción es el corazón de cualquier aplicación viva; ahí es donde se guardan los datos reales de los usuarios reales. Si ocurre un fallo en el servidor, un ataque cibernético o un error de código humano catastrófico (como un DELETE sin WHERE), las copias de seguridad (backups) automatizadas son el único escudo para recuperar el sistema y evitar la pérdida de información del negocio.

* El factor de la automatización: Hacer backups a mano depende de que a un humano no se le olvide. Al automatizarlas (por ejemplo, cada noche a las 2:00 AM), el sistema se protege de forma autónoma.

### 2. Un borrado suave es donde *marcas una fila como eliminada en lugar de eliminarla realmente*

Es una estrategia fundamental que todo QA Engineer y desarrollador de Backend debe dominar para proteger la persistencia de los datos.
La respuesta correcta es la 1: Marcar una fila como eliminada en lugar de eliminar realmente los datos.

## 🔍 Explicación técnica paso a paso (El enfoque de QA)

* ¿Cómo funciona un borrado suave (Soft Delete)?:   

En lugar de ejecutar un comando destructivo como DELETE FROM, el desarrollador agrega una columna booleana a la tabla (usualmente llamada is_deleted o active). Cuando un usuario borra algo (por ejemplo, una publicación), el Backend simplemente actualiza esa columna a true (1). Los datos siguen existiendo físicamente en el disco, pero las consultas normales del frontend los ignoran.

* ¿Por qué se prefiere en producción?:

1. Trazabilidad e Historial: Si el usuario borró algo por error, el equipo de soporte o QA puede restaurar el registro instantáneamente cambiando la bandera a false.

2. Integridad Referencial: Evita que se rompan las relaciones con otras tablas (claves foráneas) al desaparecer un registro por completo.

+ Un toque de humor: *(pedírselo "por favor" a la base de datos)* sería genial en un mundo ideal, ¡pero lamentablemente los motores de SQL no tienen sentimientos! 😂

# Consulta de actualización en SQL
Cada vez que actualizas tu foto de perfil o cambias tu contraseña en línea, ¡estás modificando los datos de un campo en una tabla de una base de datos! Imagina que cada vez que te equivocaras al publicar un tuit en Twitter, tuvieras que borrarlo por completo y publicar uno nuevo en lugar de simplemente editarlo...

... bueno, ese es un mal ejemplo.

## Declaración de actualización
La instrucción UPDATE SQL nos permite actualizar los campos de un registro. Incluso podemos actualizar varios registros, dependiendo de cómo escribamos la instrucción.

Una instrucción UPDATE especifica la tabla que se debe actualizar, seguida de los campos y sus nuevos valores mediante la palabra clave SET. Por último, una cláusula WHERE indica el o los registros que se van a actualizar.

    UPDATE 
        employees
            SET
                job_title = 'Backend Engineer',
                salary = 150000
    WHERE
        id = 251;

## Asignación
Necesitamos actualizar el registro de Lane en nuestra tabla de usuarios. Él fundó CashPal, ¡pero ni siquiera está reconocido como administrador!

UPDATE El registro  de Lane dentro de la tabla users para que el campo is_admin se establezca en true!


## 🧱 Análisis del Problema y Proceso de Decisión

1. Identificar la tabla objetivo:

El enunciado indica claramente que debemos modificar un registro dentro de la tabla de usuarios:

UPDATE users

1. Definir el cambio con la cláusula SET:

La asignación nos pide explícitamente cambiar el campo is_admin para volverlo administrador. El valor correcto en SQLite para esta bandera booleana es verdadero:

SET is_admin = true

1. Formular el filtro del WHERE (Crucial para QA):
 
¡Atención aquí! Un UPDATE sin un WHERE actualizaría a todos los usuarios de la base de datos a administradores (lo cual sería un fallo de seguridad crítico). Necesitamos aislar únicamente a Lane. Supngamos que tenemos un historial de los usuarios que insertamos en los retos anteriores de la lección (en el archivo 001_up.sql de los pasos de autoincremento), los datos de Lane eran:

	• name: 'Lance' (o 'Lane', dependiendo del mapeo exacto de la base de datos de la plataforma, pero comúnmente en la tabla su username se registró como 'LanChr').
	• Sin embargo, para mayor seguridad y precisión técnica, podemos filtrar directamente por su columna name o su identificador si lo conocemos. Dado que las instrucciones dicen "UPDATE Lane's record", el motor evaluará el campo identificativo de texto. La forma estándar es buscar donde el nombre sea igual a su registro.
Nota de QA: En esta lección específica de Boot.dev, el registro se guardó originalmente con el nombre 'Lance' o el username 'LanChr'. Si el enunciado dice exactamente "Lane's record", el filtro busca el campo identificador de su nombre en la tabla. Evaluemos por su name = 'Lane'.

## 🛠️ Código SQL 

UPDATE 
    users
SET 
    is_admin = true
WHERE 
    name = 'Lane';


## 📋 ¿Por qué funciona de forma segura?

+ UPDATE users: Le indica al motor de base de datos qué tabla va a sufrir modificaciones en sus filas.

+ SET is_admin = true: Especifica la columna exacta que va a cambiar y le asigna el nuevo valor booleano.

+ WHERE name = 'Lane': Funciona como un candado de seguridad en el Backend. Al ejecutarse, el motor ignorará a los demás usuarios y afectará única y exclusivamente a Lane, otorgándole sus privilegios de administrador de forma limpia.

# Mapeo objeto-relacional (ORM)
Un mapeo objeto-relacional, o ORM por sus siglas en inglés, es una herramienta que permite realizar operaciones CRUD en una base de datos utilizando un lenguaje de programación tradicional. Generalmente, se presenta en forma de una biblioteca o framework que se utiliza en el código del backend.

El principal beneficio que proporciona un ORM es que asigna los registros de la base de datos a objetos en memoria. Por ejemplo, en Go podríamos tener una estructura que usamos en nuestro código:

        type User struct {
            ID int
            Name string
            IsAdmin bool
        }

Esta definición de estructura representa convenientemente una tabla de base de datos llamada users, y una instancia de la estructura representa una fila en la tabla.

## Ejemplo: Uso de un ORM
Utilizando un ORM podríamos escribir código simple como este:

        user := User{
            ID: 10,
            Name: "Lane",
            IsAdmin: false,
        }

        // generates a SQL statement and runs it,
        // creating a new record in the users table
        db.Create(&user)

## Ejemplo: Uso de SQL directo
Al usar SQL directamente, normalmente necesitamos escribir más código y gestionar las cosas de forma un poco más manual:

        user := User{
            ID: 10,
            Name: "Lane",
            IsAdmin: false,
        }

        db.Exec("INSERT INTO users (id, name, is_admin) VALUES (?, ?, ?);",
            user.ID, user.Name, user.IsAdmin)

## ¿Deberías usar un ORM?
¡Eso depende! Un ORM normalmente sacrifica el control por la simplicidad.

Al usar SQL puro, puedes aprovechar al máximo el potencial del lenguaje SQL. Con un ORM, estás limitado por la funcionalidad que este ofrece. Si tienes problemas con una consulta específica, depurarla puede ser más difícil, ya que debes analizar el código y la documentación del framework para comprender cómo se generan las consultas subyacentes.

*Recomiendo realizar proyectos de ambas maneras para que puedas aprender sobre las ventajas y desventajas. Al final, cuando trabajes en un equipo de desarrolladores, será una decisión de equipo. - Lane Wagner*

## 🏋🏽‍♂️ Para Ejercitar la comprensión

1. Al usar un ORM, llamas a los métodos y funciones disponibles a través de la API del ORM

## 🔍 Explicación técnica paso a paso (El enfoque de QA/Backend)

* ¿Qué es un ORM? Significa Object-Relational Mapping (Mapeo Objeto-Relacional). Es una herramienta que actúa como un traductor entre el código de programación orientado a objetos (como Python) y la base de datos relacional (como SQL).

* En lugar de escribir cadenas de texto con código SQL puro a mano (como SELECT * FROM users WHERE id = 1;), usas código nativo de tu lenguaje llamando a funciones específicas del ORM. 
  + Por ejemplo, en Python escribirías algo tan limpio como: users.objects.get(id=1). El ORM se encarga de traducir esa función a código SQL real en milisegundos tras bambalinas.

* Ventaja para el desarrollador: Le permite programar más rápido, reduce errores de sintaxis humana y protege la aplicación contra ataques comunes como la inyección SQL.

2. Una ventaja de un ORM es que hace que tu código sea menos extenso.

## 🔍 Explicación y descarte de opciones (Pensamiento de QA):

* Los ORM reducen drásticamente la cantidad de líneas de código (boilerplate code) que tienes que escribir. En lugar de abrir manualmente una conexión a la base de datos, escribir un string de SQL muy largo, ejecutarlo, iterar sobre las filas del cursor y mapear cada columna a un objeto de tu lenguaje, el ORM te permite hacer todo eso en una sola línea llamando a un método predefinido.

* Es más dificil depurar a bajo nivel. Al contrario, los ORM agregan capas de abstracción, lo que hace que depurar a bajo nivel (saber exactamente qué consulta binaria llegó al motor) sea más difícil, no más fácil.

* No ofrece más control sobre la base de datos. Al automatizar la traducción del código, pierdes cierto control directo sobre las optimizaciones finas de la base de datos.

* No garantiza Busqueda rápidas. El software intermedio consume recursos. El código SQL generado automáticamente por un ORM a veces puede ser menos eficiente y más lento que una consulta escrita a mano perfectamente optimizada por un DBA.

3. ¿Deberías usar un ORM?
Depende del proyecto / equipo.

## 🔍 Explicación técnica (Criterio de Ingeniería y QA)

En el mundo real del desarrollo de software, no existen las soluciones absolutas ("siempre" o "nunca"). Todo es un balance de compensaciones (trade-offs):

* ¿Cuándo SÍ usarlo? (Depende del proyecto): Si estás construyendo una aplicación web típica (como un e-commerce o una red social) donde necesitas desarrollar rápido operaciones CRUD estándar, un ORM es ideal. Ahorra tiempo y simplifica la vida del equipo.
  
* ¿Cuándo NO usarlo? (Depende de las necesidades): Si estás trabajando con Big Data, análisis financiero de alta velocidad o sistemas que requieren optimización extrema de milisegundos, el ORM añadirá una sobrecarga (overhead) innecesaria. *En esos casos, escribir SQL puro a mano es mucho mejor.*

* Depende del equipo: Si el equipo de desarrollo tiene un dominio muy alto de SQL, tal vez prefieran usar un Query Builder o SQL puro para mantener el control absoluto del rendimiento del Backend.

### 💪🏽 Práctica de consultas: recuento de usuarios
CashPal tiene un panel de control en su sitio web que muestra estadísticas sobre la ubicación de los usuarios. Uno de los miembros de tu equipo de control de calidad está preocupado porque el número de usuarios ubicados en Estados Unidos parece bastante bajo.

## Asignación
Escribe una consulta SQL que devuelva el recuento de todos los registros de la userstabla que tengan su country_codevalor igual aUS .

* Recuerda, se quiere saber el número total de registros , así que podemos usar el comodín ( *) en COUNT(*). Si bien normalmente podrías usar la idcolumna, es decir COUNT(id), para esta tarea, mantén el comodín.

## 🧱 Análisis del Problema y Proceso de Decisión

1. Identificar la función de agregación:

El enunciado te pide explícitamente el recuento de filas y te da una restricción estricta: "mantén el comodín ( * ) en COUNT(*)".

SELECT COUNT(*)

2. Identificar la tabla origen:

Los datos siguen estando en nuestra conocida tabla de usuarios:

FROM users

3. Definir la condición de filtrado (WHERE):

Queremos aislar únicamente a los usuarios ubicados en Estados Unidos. El enunciado nos indica que la columna encargada de esto es country_code y su valor debe ser exactamente 'US'. Al ser un dato de tipo texto (TEXT), debemos envolverlo obligatoriamente en comillas simples:

WHERE country_code = 'US'

## 🛠️ Código SQL 

        SELECT
            COUNT(*)
        FROM
            users
        WHERE
            country_code = 'US';


## 📋 ¿Por qué estructur esto así?

* COUNT(*): Cuenta todas las filas del resultado filtrado, garantizando que no se ignore ningún registro válido.

* WHERE country_code = 'US': Actúa como el colador en el Backend. El motor descartará a los usuarios de Brasil ('BR'), India ('IN'), etc., y nos devolverá un único número que representa el total exacto de usuarios estadounidenses. *Con esto, el compañero de QA podrá verificar si los datos del panel son correctos.* 
  😅(a que latoso compañero)

### 💪🏽 Práctica de consulta – Códigos de país
Utilizando nuestra consulta anterior, hemos notado que algunos de los registros se guardaron incorrectamente con un valor country_code de USA en lugar de US.

## Asignación
Escriba una instrucción SQL para actualizar el valor country_code de 'USA' a 'US' para todos los registros de usuario aplicables. ¡Asegúrese de que solo se modifiquen los registros marcados inicialmente con 'USA'!


## 🧱 Análisis del Problema y Proceso de Decisión

1. Identificar la operación y la tabla objetivo:

El enunciado nos pide actualizar registros de usuarios. Por lo tanto, la instrucción inicial apunta a la tabla de usuarios:

UPDATE users

2. Definir el cambio con la cláusula SET:

Queremos establecer el nuevo valor estandarizado de dos letras ('US') en la columna correspondiente. Al ser texto, usamos comillas simples:

SET country_code = 'US'

3. Formular la condición en el WHERE (El filtro de seguridad):

¡Mucho ojo aquí! Si olvidamos la cláusula WHERE, actualizaríamos el código de país de absolutamente todos los usuarios de la base de datos a 'US' (arruinando los registros de Brasil, India, etc.). El enunciado restringe explícitamente el impacto: 

"¡Asegúrese de que solo se modifiquen los registros marcados inicialmente con 'USA'!".

Nuestra condición filtrará únicamente las filas afectadas por el error de captura:

WHERE country_code = 'USA'

## 🛠️Código SQL

        UPDATE 
            users
        SET 
            country_code = 'US'
        WHERE 
            country_code = 'USA';

## 📋 ¿Por qué funciona de forma segura y eficiente?

* UPDATE users: Prepara al motor de la base de datos para modificar filas en esa entidad específica.

* SET country_code = 'US': Indica cuál es el valor final correcto que queremos inyectar en la columna.

* WHERE country_code = 'USA': Aísla el impacto de la consulta. El motor buscará únicamente los registros corruptos que tengan las tres letras ('USA'), los corregirá a dos letras ('US') y dejará intactos a todos los demás usuarios internacionales del sistema.
