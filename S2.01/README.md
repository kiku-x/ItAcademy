Los ejercicios estan divididos en tres niveles de dificultad.

<Details>
<Summary>NIVELL 1</Summary>

Exercici 1: Mostra totes les transaccions realitzades per empreses d'Alemanya.

```
SELECT transaction.id
FROM transaction
LEFT JOIN company
ON company_id = company.id
WHERE company.country = "Germany";
```  
    
Exercici 2: Màrqueting està preparant alguns informes de tancaments de gestió, et demanen que els passis un llistat de les
empreses que han realitzat transaccions per una suma superior a la mitjana de totes les transaccions.
```
SELECT company_name
FROM company
LEFT JOIN transaction
ON company.id = company_id
WHERE amount > ( #subquery per calcular la mitjana de totes les transaccions
	SELECT AVG(transaction.amount)
	FROM transaction
    );
```

Exercici 3: El departament de comptabilitat va perdre la informació de les transaccions realitzades per una empresa,
però no recorden el seu nom, només recorden que el seu nom iniciava amb la lletra c. Com els pots ajudar? Comenta-ho acompanyant-ho de la informació de les transaccions.

Puc ajudar-los proporcionant la informacio de les empreses que comencem amb la lletra C.
```
SELECT *
FROM company
WHERE company_name LIKE "c%";
```

Tambe podria ajudar-los proporcionant les transaccions de les empreses que comencen amb la lletra C.
```
SELECT *
FROM company
LEFT JOIN transaction
ON company.id = company_id
WHERE company_name LIKE "c%";
```


Exercici 4: Van eliminar del sistema les empreses que no tenen transaccions registrades, lliura el llistat d'aquestes empreses.
```
SELECT company.company_name AS Nom
FROM company
JOIN transaction
ON company.id = company_id
WHERE transaction.id IS NULL; #mostra les empreses que al fer el join, no tinguin info de transaccio
```
</Details>
<Details>
<Summary>NIVELL 2</Summary>

Exercici 1: En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries per a fer competència a la companyia senar institute.
Per a això, et demanen la llista de totes les transaccions realitzades per empreses que estan situades en el mateix país que aquesta companyia.
```
SELECT transaction.id, company_name
FROM transaction
LEFT JOIN company
ON company_id = company.id
WHERE country = ( #subquery per saber el pais de l'empresa
	SELECT country
    FROM company
    WHERE company_name = "Non Institute"
	)
;
```

Exercici 2: El departament de comptabilitat necessita que trobis l'empresa que ha realitzat la transacció de major suma en la base de dades.
```
SELECT company.company_name, transaction.amount
FROM company
JOIN transaction
ON company.id = company_id
ORDER BY amount DESC
Limit 1;
```
</Details>


<Details>
<summary>NIVELL 3</summary>

Exercici 1: S'estan establint els objectius de l'empresa per al següent trimestre, per la qual cosa necessiten una base sòlida per a avaluar el rendiment
i mesurar l'èxit en els diferents mercats. Per a això, necessiten el llistat dels països la mitjana de transaccions dels quals sigui superior a la mitjana general.
```
SELECT country, AVG(amount)
FROM company 
JOIN transaction
ON company.id = company_id
GROUP BY country
HAVING AVG(amount) > ( #subquery per calcular la mitjana general
	SELECT AVG(amount)
	FROM transaction
	)
;
```


Exercici 2: Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa que es requereixi,
per la qual cosa et demanen la informació sobre la quantitat de transaccions que realitzen les empreses, però el departament de recursos humans és exigent
i vol un llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys.
```
SELECT company_name AS Nom,
	CASE
		WHEN COUNT(transaction.id) > 4
        THEN "Si"
        ELSE  "No"
        END AS "Te mes de 4 transaccions?"
FROM company
LEFT JOIN transaction ON company.id = transaction.company_id
GROUP BY company_name
ORDER BY 2 DESC;
```
</Details>
