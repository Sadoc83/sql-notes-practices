# ¿Qué es una base de datos? 


Una base de datos es el lugar donde vive la información. Piensa en ella como la memoria a largo plazo de la aplicación: detalles de productos, usuarios, pedidos… todo se guarda allí.


Vamos a desglosarlo:
El backend es el cerebro: en él se procesan las solicitudes, se aplica la lógica y se conectan los diferentes sistemas.
El servidor es la máquina (física o virtual): ejecuta el código del backend y mantiene la aplicación en funcionamiento.
La base de datos es la memoria donde se almacena los datos: productos, usuarios, pedidos… etc.

En una metáfora de restaurante: la base de datos es el almacén.
Cuando el mesero (la API) lleva un pedido a la cocina (el backend), los chefs van primero al almacén a buscar los ingredientes.

Solo entonces pueden empezar a cocinar, emplatar y enviar el plato terminado de vuelta al cliente a través del mesero.
Sin ingredientes en el almacén, no hay platillo que llevar a la mesa.
En el contexto de las pruebas de API, esto es exactamente lo que ocurre entre bastidores. Cuando alguien hace clic en un paquete de despensa, el sitio envía una solicitud a la API. El backend procesa esa solicitud, extrae la información correcta de la base de datos y la envía de vuelta como respuesta.

Como QA, es necesario comprender como funcionan esas piezas de "lego" a la perfección así se puede seguir el rastro de cada tipo de cambio y lo que debería producir esa acción, porque eso es lo que se va a verificar.


### Estas son las posibilidades principales:



| **Acción de la API** 	| **Qué ocurre con los datos**                               	| **Ejemplo**                                                                                                      	|
|------------------	|--------------------------------------------------------	|--------------------------------------------------------------------------------------------------------------	|
| Crear            	| Añade un nuevo registro a la base de datos             	| Un usuario crea un nuevo paquete de productos —> aparece una nueva fila en la tabla de paquetes de productos 	|
| Leer             	| Recupera datos, pero no hace cambios                   	| Solicitas los detalles de un producto —> la base de datos devuelve la información, sin cambios               	|
| Actualizar       	| Modifica un registro existente                         	| Un usuario cambia su dirección de entrega —> la dirección anterior se reemplaza                              	|
| Eliminar         	| Elimina un registro de la base de datos                	| Se elimina un paquete de despensa de prueba —> su fila desaparece de la tabla                                	|
| Sin cambios      	| La solicitud falla o no afecta a los datos almacenados 	| Se rechaza una solicitud con datos no válidos —> la base de datos permanece sin cambios                      	|

💡 Este patrón suele llamarse CRUD — **Create** (Crear), **Read** (Leer), **Update** (Actualizar) y **Delete** (Eliminar). Estas cuatro acciones te ayudarán a predecir qué debería ocurrir en la base de datos después de cualquier solicitud a la API.

**Por qué esto es importante para QA:** La API puede devolver "201 Created" aunque la base de datos guarde valores incorrectos, datos incompletos o incluso no guarde nada — solo una comprobación en la base de datos permite detectarlo.

### Nota: Con un usuario activo y un token de autorización disponible descargaremos para comprobar que el producto con ID 44 esta disponible.

## Práctica 1. Verifica si el producto existe

Ya confirmamos que el producto con ID 44 está disponible en el almacén; ahora, vamos a asegurarnos de que también exista en la base de datos.


Descarga la tabla de productos:


  1. Ingresa la URL de tu servidor (https://urban-grocers-auth.up.railway.app) en la barra de direcciones de Google Chrome y agrega /api/db/resources/product_model.csvEsto descargará el contenido de la tabla product_model, que contiene la lista de todos los productos del sistema.

  2. Presiona Enter.

  3. Abre el archivo .csv y busca el producto con ID 44.

  4. Importa el archivo en Excel, Google Sheets u otra herramienta de hojas de cálculo como un archivo separado por comas para poder verlo correctamente.

  La base de datos recien descargada se podría observar que contenga los siguientes campos:
  * Name
  * Weight
  * Units
  * Price

Ahora que se pudo corroborar que en la base de datos existe el producto 44 y coicide con los datos del almacen el problema ocurre después de que se recuperan los datos, es pobable que sea en el frontend.

## Práctica 2. Verifica un nuevo paquete de despensa

Vamos a reutilizar nuestra solicitud Crear paquete de despensa usando un token de usuario:


1. Busca tu solicitud Crear paquete de despensa y agrega en Postman o Swagger el token de usuario que quieras utilizar.

2. Ejecuta la solicitud.

3. Agrega el producto 44 :

   * Envía una solicitud POST a /api/v1/grocery-bundles/{id}/products, donde {id} es el ID de tu nuevo paquete de despensa con el cuerpo
  {
  "productsList": [
  {
  "productId": 44,
  "quantity": 1
  }
  ]
  }
 
   *  Asegúrate de agregar el mismo token que ya obtuvimos.

4. Envía la solicitud de nuevo.

5. Descarga grocery_bundle_model.csv esta vez desde base_url/api/db/resources/grocery_bundle_model.csv?token=<tu_token>

6. Busca tu nuevo paquete de despensa. Asegúrate de que incluya el producto 44 en productsList

Con esta solicitud si todo sale como se espera se deberá encontrar el paquete que recien se creo en la base de datos, lo que indica que la API funciono y los datos llegaron correctamente a la base de datos.

## Práctica 3. Verifica que el nuevo paquete de despensa se haya eliminado

1. Finalmente, envía una solicitud DELETE a /api/v1/grocery-bundles/{id}, donde {id} es el ID de tu nuevo paquete de despensa. Asegúrate de incluir el mismo token que usaste para crear el paquete.
2. Descarga de nuevo grocery_bundle_model.csv desde base_url/api/db/resources/grocery_bundle_model.csv?token=<tu_token>.
3. Verifica si el nuevo paquete de despensa desapareció de la base de datos.

Luego de ejecutar esta solicitud el paquete de despensa ya no esta en la base de datos, lo que significa que la API funciono y que el cambio se registró correctamente en el sistema.

Ahora con estas comprobaciones, nos deja entonces donde esta el problam... todo apunta que se encuentra en el frontend. Tal vez se tenga un BUG en cómo se muestran o filtran los pauqetes de despensa. Con estos hallazgos es momento de compartirlos con el equipo y de lo demas se encargarán ellos.

# Tipos de bases de datos
Las bases de datos almacenan información. Así como las personas organizan música, fotos y documentos en carpetas, álbumes o mediante etiquetas, las bases de datos también pueden organizar la información de distintas maneras.
En términos generales, las bases de datos se dividen en relacionales y no relacionales.

🔗 Las bases de datos **relacionales** almacenan datos estructurados en tablas conectadas. Se utilizan habitualmente para datos relacionados, como usuarios, pedidos y productos, y suelen consultarse mediante SQL.

♻️ Las bases de datos **no relacionales** utilizan estructuras flexibles, como documentos o pares clave-valor. Resultan útiles para datos que cambian o crecen rápidamente, como el contenido de redes sociales o la actividad de una aplicación.

En el ambiente de QA, es muy común que se trabajen bases de datos relacionales, por lo que nos centraremos en estas en lo que sigue del estudio.

## Base de datos relacionales
En una analogía apropiada para ilustrar llamaremos a una biblioteca. Bien la biblioteca necesita llevar un registro de libros, miembros y préstamos. 

Para cada libro, se puede almacenar el título, el autor, el género y el ISBN.
Para cada miembro, se guarda su nombre y datos de contacto.

Al mismo tiempo, el personal de la biblioteca debe poder responder rápidamente a preguntas como: 
* ¿Quién tomó prestado este libro? 
* ¿Qué libros tiene este miembro? 
* ¿Cuándo debe devolverse cada uno?

Si toda esta información se almacenará en una lista larga, los datos de los libros y los miembros se repetirían una y otra vez. En su lugar, la biblioteca mantiene catálogos separados por **libros**, **miembros** y **préstamos**, y se concecta los registros mediante identificadores.

*Las bases de datos relacionales funcionan de la misma manera.*
### 🔡*Una base de datos relacional almacena distintos tipos de información en tablas separadas y vincula los registros relacionados.*

En lugar de repetir los mismos datos en todas partes, **almacena cada dato una sola vez y utiliza identificadores para indicar cómo se relacionan los datos entre sí**.
En el ambiente QA, esta estructura es importante porque un valor que ves en la aplicación puede proceder de varios datos almacenados y conectados. Si un pedido muestra un usuario, producto o estado incorrecto, comprender la estructura te ayudará a identificar **qué datos almacenados debes comprobar**.
La validación de bases de datos y SQL también son habilidades que se nos solicitarán para cubrir puestos como junior en QA, especialmente para comprobar datos del backend y obtener datos de prueba.

## Cómo leer una tabla relacional
**Campos**
En el mundo de las bases de datos, las columnas se llaman campos y contienen las propiedades del objeto, como su nombre, puesto, puntos fuertes y puntos débiles:

Cada campo tiene un nombre único y un tipo de dato específico.

**Registros**
Un registro es una fila de la tabla. Cada fila contiene información sobre un objeto concreto; por ejemplo, sobre un empleado.

Por ejemplo, toda la primera fila es un registro. Nos indica que Donald Dunn es el Gerente de Operaciones, que se le da bien organizar procesos y que su punto débil es que habla alemán mientras duerme.

**Celdas**
Una celda es el punto donde se cruzan una columna (campo) y un registro (fila). Por ejemplo, la intersección de la columna Puesto de trabajo con el registro 4 es una celda que contiene el valor Java developer. Este valor indica que Dinesh Chugtai ocupa el puesto de desarrollador Java.

### 📌 Esto es parecido a consultar cualquier tabla estructurada: la fila te indica qué objeto estás viendo, mientras que la columna te indica qué propiedad estás comprobando.