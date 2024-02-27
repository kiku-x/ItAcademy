Los ejercicios estan divididos en tres niveles de dificultad.

<Details>
<Summary>NIVELL 1</Summary>
Exercici 2: Realitza la següent consulta: Has d'obtenir el nom, email i país de cada companyia, ordena les dades en funció del nom de les companyies.

```
SELECT company_name AS Nom, email, country AS Pais
FROM company
ORDER BY company_name;
```


Exercici 3: Des de la secció de màrqueting et sol·liciten que els passis un llistat dels països que estan fent compres.
SELECT DISTINCT country AS Pais
```
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id;
```


Exercici 4: Des de màrqueting també volen saber des de quants països es realitzen les compres.
```
SELECT COUNT(DISTINCT country) AS Paisos
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id;
```


Exercici 5 El teu cap identifica un error amb la companyia que té id 'b-2354'. Per tant, et sol·licita que li indiquis el país i nom de companyia d'aquest id.
```
SELECT country AS Pais, company_name AS Nom
FROM company
WHERE id = "b-2354";
```


Exercici 6 A més, el teu cap et sol·licita que indiquis quina és la companyia amb major despesa mitjana?
```
SELECT company_name AS Nom
FROM company
JOIN transaction
ON company.id = transaction.company_id
GROUP BY company_name
ORDER BY AVG(transaction.amount) DESC
LIMIT 1;
```
</Details>

<Details>
<Summary>NIVELL 2</Summary>
Exercici 1: El teu cap et sol·licita verificar si en la base de dades existeixen companyies amb identificadors (id) duplicats.*/

```
SELECT id, COUNT(*) AS Copies
FROM company
GROUP BY id
HAVING Copies > 1;
```

Exercici 2 En quin dia es van realitzar les cinc vendes més costoses? Mostra la data de la transacció i la sumatòria de la quantitat de diners.
```
SELECT DATE(timestamp) AS Data, SUM(amount) AS Sumatoria
FROM transaction
GROUP BY Data
HAVING COUNT(*) >= 5
ORDER BY Sumatoria DESC
LIMIT 1;
```


Exercici 3: En quin dia es van realitzar les cinc vendes de menor valor? Mostra la data de la transacció i la sumatòria de la quantitat de diners.
```
SELECT DATE(timestamp) AS Data, SUM(amount) AS Sumatoria
FROM transaction
GROUP BY Data
HAVING COUNT(*) >= 5
ORDER BY Sumatoria ASC
LIMIT 1;
```


Exercici 4: Quina és la mitjana de despesa per país? Presenta els resultats ordenats de major a menor mitjà.
```
SELECT company.country AS Pais, AVG(transaction.amount) AS Despesa_Mitjana
From company
LEFT JOIN transaction
ON company.id = transaction.company_id
GROUP BY Pais
ORDER BY Despesa_Mitjana DESC;
```
</Details>



<Details>
<Summary>NIVELL 3</Summary>
Exercici 1: Presenta el nom, telèfon i país de les companyies, juntament amb la quantitat total gastada, d'aquelles que van realitzar
transaccions amb una despesa compresa entre 100 i 200 euros. Ordena els resultats de major a menor quantitat gastada.

```
SELECT company_name AS Nom, phone AS Telefon, country AS Pais, SUM(transaction.amount) AS Total_Gastat
FROM Company
LEFT JOIN transaction
ON company.id = transaction.company_id
WHERE transaction.amount BETWEEN 100 AND 200
GROUP BY company.id
ORDER BY Total_Gastat DESC;
```

  
Exercici 2: Indica el nom de les companyies que van fer compres el 16 de març del 2022, 28 de febrer del 2022 i 13 de febrer del 2022.
```
SELECT DISTINCT company_name AS Nom
FROM Company
LEFT JOIN transaction
ON company.id = transaction.company_id
WHERE DATE(timestamp) IN ("2022-03-16", "2022-02-28", "2022-02-13");
```

</Details>
