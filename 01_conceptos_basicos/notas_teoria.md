¿Qué es una base de datos?
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


Estas son las posibilidades principales:



| **Acción de la API** 	| **Qué ocurre con los datos**                               	| **Ejemplo**                                                                                                      	|
|------------------	|--------------------------------------------------------	|--------------------------------------------------------------------------------------------------------------	|
| Crear            	| Añade un nuevo registro a la base de datos             	| Un usuario crea un nuevo paquete de productos —> aparece una nueva fila en la tabla de paquetes de productos 	|
| Leer             	| Recupera datos, pero no hace cambios                   	| Solicitas los detalles de un producto —> la base de datos devuelve la información, sin cambios               	|
| Actualizar       	| Modifica un registro existente                         	| Un usuario cambia su dirección de entrega —> la dirección anterior se reemplaza                              	|
| Eliminar         	| Elimina un registro de la base de datos                	| Se elimina un paquete de despensa de prueba —> su fila desaparece de la tabla                                	|
| Sin cambios      	| La solicitud falla o no afecta a los datos almacenados 	| Se rechaza una solicitud con datos no válidos —> la base de datos permanece sin cambios                      	|

💡 Este patrón suele llamarse CRUD — **Create** (Crear), **Read** (Leer), **Update** (Actualizar) y **Delete** (Eliminar). Estas cuatro acciones te ayudarán a predecir qué debería ocurrir en la base de datos después de cualquier solicitud a la API.

**Por qué esto es importante para QA:** La API puede devolver "201 Created" aunque la base de datos guarde valores incorrectos, datos incompletos o incluso no guarde nada — solo una comprobación en la base de datos permite detectarlo.
