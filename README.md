# 📊 SQL Data Integrity Gym - Fundamentos de Bases de Datos

## 📝 Propósito del Repositorio
Este repositorio funciona como mi **estación de práctica y bitácora técnica** dedicada al dominio de las bases de datos relacionales y la manipulación de datos a través de **SQL**. 

Como futuro **QA Engineer**, entiendo que el aseguramiento de la calidad no se limita a la interfaz visual (Frontend). Este espacio documenta mi capacidad para realizar **pruebas de caja blanca y validaciones de Backend**, asegurando que la información que se almacena en el servidor sea íntegra, exacta y segura.

---

## 🎯 Habilidades de QA Demostradas en este Repositorio
* **Auditoría de Datos:** Capacidad para interrogar bases de datos y verificar que los registros coincidan con los requerimientos de negocio.
* **Manejo de Heurística:** Formulación de preguntas clave como: *¿Están los datos guardados en el formato correcto? ¿Existen duplicados o valores nulos que puedan romper el sistema?*
* **Aislamiento de Variables:** Uso de filtros avanzados para identificar la causa raíz de un fallo en el Backend.

## 🛠️ Herramientas y Ecosistema
* **Lenguaje:** SQL (Structured Query Language)
* **Gestores de Base de Datos (Conceptos):** PostgreSQL / MySQL / SQLite
* **Control de Versiones:** Git & GitHub Desktop
* **Editor de Entorno:** Visual Studio Code

---

## 📂 Estructura General del Gimnasio Técnico

A medida que avanzo en mis módulos de [TripleTen Latam](https://tripleten.com) y mis retos autónomos, organizo mis prácticas de forma modular:

*   **`01_conceptos_basicos/`**: Introducción a tablas, tipos de datos, llaves primarias (*Primary Keys*) y foráneas (*Foreign Keys*).
*   **`02_filtrado_y_ordenamiento/`**: Uso avanzado de comandos `WHERE`, `LIKE`, `IN`, `BETWEEN`, y ordenamiento con `ORDER BY`.
*   **`03_funciones_agregacion/`**: Análisis numérico de datos utilizando `COUNT`, `SUM`, `AVG`, `MIN`, `MAX` y agrupación con `GROUP BY` / `HAVING`.
*   **`04_relaciones_complejas/`**: Cruce de información entre múltiples tablas aplicando operadores relacionales (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`).

---

## 🗃️ Muestra de Consulta Típica (Ejemplo de Validación)

Como evidencia técnica, aquí hay un ejemplo de cómo estructuro una consulta para auditar si un cliente ficticio tiene sus compras en orden:

```sql
-- Objetivo de QA: Validar que los usuarios activos tengan transacciones registradas en el mes
SELECT 
    usuarios.id_usuario,
    usuarios.nombre,
    COUNT(transacciones.id_transaccion) AS total_compras
FROM usuarios
INNER JOIN transacciones 
    ON usuarios.id_usuario = transacciones.id_usuario
WHERE usuarios.estado = 'activo'
GROUP BY usuarios.id_usuario, usuarios.nombre
HAVING COUNT(transacciones.id_transaccion) > 0;
```

---

## 🚀 Hoja de Ruta Personal (Hacia dónde crece este Repo)
1. **Fase Básica:** Dominio de consultas de lectura (`SELECT`) y filtros esenciales.
2. **Fase Intermedia:** Creación de reportes agrupados y uniones complejas (*Joins*).
3. **Fase Avanzada:** Introducción a modificaciones de bases de datos (`INSERT`, `UPDATE`, `DELETE`) bajo entornos controlados de prueba.

