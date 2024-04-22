/*NIVELL 1
Exercici 1: Mostra totes les transaccions realitzades per empreses d'Alemanya.*/
SELECT *
FROM transaction
WHERE transaction.company_id IN (SELECT company.id
                                 FROM company
                                 WHERE company.country = 'Germany');
                                 

/*Exercici 2: Màrqueting està preparant alguns informes de tancaments de gestió, et demanen que els passis un llistat de les
empreses que han realitzat transaccions per una suma superior a la mitjana de totes les transaccions.*/
SELECT DISTINCT *
FROM company
JOIN transaction
ON company.id = transaction.company_id
WHERE amount > ( -- Fem un filtre perque només mostri els amounts que siguin mes grans que el numero calculat dins al subquery.
	SELECT AVG(transaction.amount) -- Creem una subquery per calcular la mitjana de totes les transaccions.
	FROM transaction
    );

SELECT DISTINCT *
FROM company
WHERE company.id IN (
	SELECT company.id
	FROM transaction
	WHERE transaction.amount > (
		SELECT AVG(transaction.amount)
		FROM transaction ));



/*Exercici 3: El departament de comptabilitat va perdre la informació de les transaccions realitzades per una empresa,
però no recorden el seu nom, només recorden que el seu nom iniciava amb la lletra c. Com els pots ajudar? Comenta-ho acompanyant-ho de la informació de les transaccions.*/

-- Puc ajudar-los proporcionant la informacio de les empreses que comencem amb la lletra C.
SELECT *
FROM (
    SELECT *
    FROM company
) AS subquery
WHERE subquery.company_name LIKE "c%"; -- Creem un filtre amb una wildcard con diem que mostri totes les empreses que el nom comenci per C.

-- Tambe podria ajudar-los proporcionant les transaccions de les empreses que comencen amb la lletra C.
SELECT *
FROM transaction
WHERE transaction.company_id IN (SELECT company.id
FROM company
WHERE company_name LIKE "c%");



-- Exercici 4: Van eliminar del sistema les empreses que no tenen transaccions registrades, lliura el llistat d'aquestes empreses.

SELECT DISTINCT(company.company_name)
FROM company
WHERE company.id IN (
	SELECT transaction.company_id
	FROM transaction
	WHERE transaction.company_id IS NULL);

/*NIVELL 2
Exercici 1: En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries per a fer competència a la companyia senar institute.
Per a això, et demanen la llista de totes les transaccions realitzades per empreses que estan situades en el mateix país que aquesta companyia.*/
SELECT *
FROM transaction
WHERE transaction.company_id IN (
    SELECT company.id
    FROM company
    WHERE company.country = (
        SELECT company.country
        FROM company
        WHERE company_name = 'Non institute'
    )
);

-- Exercici 2: El departament de comptabilitat necessita que trobis l'empresa que ha realitzat la transacció de major suma en la base de dades.
SELECT company_name
FROM company
WHERE company.id IN (
	SELECT company_id
	FROM transaction
	ORDER BY amount DESC
    )
LIMIT 1;

/*NIVELL 3
Exercici 1: S'estan establint els objectius de l'empresa per al següent trimestre, per la qual cosa necessiten una base sòlida per a avaluar el rendiment
i mesurar l'èxit en els diferents mercats. Per a això, necessiten el llistat dels països la mitjana de transaccions dels quals sigui superior a la mitjana general.*/
SELECT country, AVG(amount) -- Fem un select del pais de l'empresa i una mitjana de l'amount de les transaccions. Més endavant les agruparem segons el pais de l'empresa.
FROM company 
JOIN transaction
ON company.id = company_id
GROUP BY country -- Agrupem les despeses segons el pais de l'empresa.
HAVING AVG(amount) > ( -- Mostrarem nomes els resultats on la mitjana de cada empresa superi la mitjana general.
	SELECT AVG(amount) -- Crear subquery per calcular la mitjana de totes les despeses.
	FROM transaction
	);


/*Exercici 2: Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa que es requereixi,
per la qual cosa et demanen la informació sobre la quantitat de transaccions que realitzen les empreses, però el departament de recursos humans és exigent
i vol un llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys.*/

SELECT company_name AS Nom,
	CASE -- Utilitzem case que ens servira per fer condicionals.
		WHEN COUNT(transaction.id) > 4 -- Si es poden contar més de 4 transaccions...
        THEN "Si" -- Si es afirmatiu escriurà Si
        ELSE  "No" -- Si es negatiu  escriurà No.
        END AS "Te mes de 4 transaccions?" -- Aquest sera el nom de la columna on escriurem si o no.
FROM company
LEFT JOIN transaction ON company.id = transaction.company_id -- Fusionem les dues taules.
GROUP BY company_name -- Agrupem pel nom de la companyia. Aixi podra contar les transaccions de cada empresa.
ORDER BY 2 DESC; -- Ordenem de manera descendent el segon camp de la taula que sera el camp condicional que hem creat amb el CASE. Aixi veurem els SI en primer lloc.
