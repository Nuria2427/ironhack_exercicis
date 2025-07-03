-- Pregunta 01: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre Título, Nombre y Apellido y Fecha de Nacimiento para cada uno de los clientes. 
-- necesitarás hacer nada en Excel para esta.
SELECT Title, FirstName, LastName, DateOfBirth FROM CUSTOMER;

-- Pregunta 02: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre 
-- el número de clientes en cada grupo de clientes (Bronce, Plata y Oro). Puedo ver visualmente que 
-- hay 4 Bronce, 3 Plata y 3 Oro pero si hubiera un millón de clientes ¿cómo lo haría en Excel?

SELECT CustomerGroup, COUNT(*) as num_clientes
FROM CUSTOMER 
GROUP BY CustomerGroup;

-- Pregunta 03: El gerente de CRM me ha pedido que proporcione una lista completa de todos los datos 
-- para esos clientes en la tabla de clientes pero necesito añadir el código de moneda de cada jugador 
-- para que pueda enviar la oferta correcta en la moneda correcta. Nota que el código de moneda no existe
-- en la tabla de clientes sino en la tabla de cuentas. Por favor, escribe el SQL que facilitaría esto. 
-- ¿Cómo lo haría en Excel si tuviera un conjunto de datos mucho más grande?
SELECT c.*, a.CurrencyCode FROM customer c
JOIN  account a ON c.CustId =a.CustId;

-- Pregunta 04: Ahora necesito proporcionar a un gerente de producto un informe resumen que muestre, por producto 
-- y por día, cuánto dinero se ha apostado en un producto particular. TEN EN CUENTA que las transacciones están 
-- almacenadas en la tabla de apuestas y hay un código de producto en esa tabla que se requiere buscar (classid & categoryid) 
-- para determinar a qué familia de productos pertenece esto. Por favor, escribe el SQL que proporcionaría el informe. 
-- Si imaginas que esto fue un conjunto de datos mucho más grande en Excel, ¿cómo proporcionarías este informe en Excel?
SELECT p.Product, b.BetDate, SUM(b.Bet_Amt) AS Total_Apostado
FROM Betting b
JOIN Product p ON b.product = p.product
GROUP BY p.Product, b.BetDate;

-- Pregunta 05: Acabas de proporcionar el informe de la pregunta 4 al gerente de producto, ahora él me ha enviado un correo electrónico 
-- y quiere que se cambie. ¿Puedes por favor modificar el informe resumen para que solo resuma las transacciones que ocurrieron el 1 
-- de noviembre o después y solo quiere ver transacciones de Sportsbook. Nuevamente, por favor escribe el SQL abajo que hará esto. 
-- Si yo estuviera entregando esto vía Excel, ¿cómo lo haría?
SELECT p.Product, b.BetDate, SUM(b.Bet_Amt) AS Total_Apostado
FROM Betting b
JOIN Product p ON b.product = p.product
WHERE b.BetDate >= '2023-11-01' AND p.Product = 'Sportsbook'
GROUP BY p.Product, b.BetDate;

-- Pregunta 06: Como suele suceder, el gerente de producto ha mostrado su nuevo informe a su director y ahora él también quiere una versión 
-- diferente de este informe. Esta vez, quiere todos los productos pero divididos por el código de moneda y el grupo de clientes del cliente, 
-- en lugar de por día y producto. También le gustaría solo transacciones que ocurrieron después del 1 de diciembre. Por favor, escribe el código SQL que hará esto.
SELECT p.Product, a.CurrencyCode, c.CustomerGroup, SUM(b.Bet_Amt) AS Total_Apostado
FROM Betting b
JOIN Product p ON b.product = p.product
JOIN Account a ON b.AccountNo = a.AccountNo
JOIN Customer c ON a.CustId = c.CustId
WHERE b.BetDate >= '2023-12-01'
GROUP BY p.Product, a.CurrencyCode, c.CustomerGroup;

-- Pregunta 07: Nuestro equipo VIP ha pedido ver un informe de todos los jugadores independientemente de si han hecho algo en el marco de tiempo completo o no.
-- En nuestro ejemplo, es posible que no todos los jugadores hayan estado activos. Por favor, escribe una consulta SQL que muestre a todos los jugadores Título, 
-- Nombre y Apellido y un resumen de su cantidad de apuesta para el período completo de noviembre
SELECT c.CustId, c.Title, c.FirstName, c.LastName, COALESCE(SUM(b.Bet_Amt), 0) AS Total_Apostado_Noviembre FROM CUSTOMER c
LEFT JOIN ACCOUNT a ON c.CustId = a.CustId
LEFT JOIN Betting b ON a.AccountNo = b.AccountNo
AND b.BetDate BETWEEN '2023-11-01' AND '2023-11-30'
GROUP BY CustId, c.Title, c.FirstName, c.LastName;
-- Usa COALESCE para mostrar 0 en caso de que no haya apuestas en noviembre.

-- Pregunta 08: Nuestros equipos de marketing y CRM quieren medir el número de jugadores que juegan más de un producto. ¿Puedes por favor escribir 2 consultas, 
-- una que muestre el número de productos por jugador y otra que muestre jugadores que juegan tanto en Sportsbook como en Vegas?
SELECT COUNT(DISTINCT Product), CustId FROM betting
GROUP BY CustId;

SELECT CustId FROM betting
WHERE Product IN ('Sportsbook', 'Vegas')
GROUP BY CustId
HAVING COUNT(DISTINCT Product) = 2; 

-- Pregunta 09: Ahora nuestro equipo de CRM quiere ver a los jugadores que solo juegan un producto, por favor escribe código SQL que muestre a los jugadores que solo
-- juegan en sportsbook, usa bet_amt > 0 como la clave. Muestra cada jugador y la suma de sus apuestas para ambos productos. (**no se**)
SELECT CustId, SUM(Bet_Amt) FROM betting
WHERE Product = 'Sportsbook' AND Bet_Amt > 0
GROUP BY CustId
HAVING COUNT(DISTINCT Product) = 1 AND MAX(Product) = 'Sportsbook';

-- Pregunta 10: La última pregunta requiere que calculemos y determinemos el producto favorito de un jugador. Esto se puede determinar por la mayor cantidad de dinero apostado. 
-- Por favor, escribe una consulta que muestre el producto favorito de cada jugador
-- hemos de hacer dos subqueries: una calculando el total apostado por jugador y producto; y otra con el máximo apostado por jugador
SELECT 
    a.CustId, 
    a.Product AS producto_favorito, 
    a.total_apostado
FROM (
    SELECT CustId, Product, SUM(Bet_Amt) AS total_apostado
    FROM betting
    GROUP BY CustId, Product
) a
JOIN (
    SELECT CustId, MAX(SUM_Bet) AS max_apostado
    FROM (
        SELECT CustId, Product, SUM(Bet_Amt) AS SUM_Bet
        FROM betting
        GROUP BY CustId, Product
    ) b
    GROUP BY CustId
) m ON a.CustId = m.CustId AND a.total_apostado = m.max_apostado;

-- Pregunta 11: Escribe una consulta que devuelva a los 5 mejores estudiantes basándose en el GPA
SELECT * from student
ORDER BY GPA DESC
LIMIT 5;

-- Pregunta 12: Escribe una consulta que devuelva el número de estudiantes en cada escuela. (¡una escuela debería estar en la salida incluso si no tiene estudiantes!)
SELECT s.school_id, s.school_name, COUNT(S.student_id) from school s
LEFT JOIN student S on s.school_id = S.school_id
GROUP BY s.school_id, s.School_name;

SELECT 
    s.school_id, 
    s.school_name, 
    COUNT(st.student_id) AS numero_de_estudiantes
FROM school s
LEFT JOIN student st ON s.school_id = st.school_id
GROUP BY s.school_id, s.school_name;

-- Pregunta 13: Escribe una consulta que devuelva los nombres de los 3 estudiantes con el GPA más alto de cada universidad.

SELECT student_name, school_name, GPA
FROM (
    SELECT 
        S.student_name, 
        s.school_name, 
        S.GPA,
        ROW_NUMBER() OVER (PARTITION BY s.school_id ORDER BY S.GPA DESC) as rn
    FROM student S
    JOIN school s ON S.school_id = s.school_id
) sub
WHERE rn <= 3;

-- Selecciona los estudiantes con los 3 GPA más altos de cada universidad (school).
-- Usa ROW_NUMBER() para asignar un ranking a los estudiantes dentro de cada school_id.
-- Luego filtra para mostrar solo los primeros 3 por cada escuela.











