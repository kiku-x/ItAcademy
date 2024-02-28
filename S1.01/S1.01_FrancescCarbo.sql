/*NIVELL 1
Exercici 2: Realitza la següent consulta:
Has d'obtenir el nom, email i país de cada companyia, ordena les dades en funció del nom de les companyies.*/
SELECT company_name AS Nom, email, country AS Pais -- Seleccionem els camps que volguem mostrar.
FROM company -- Seleccionem la taula en la que es troben els camps.
ORDER BY company_name; -- Ordenem en ordre alfabetic del nom de l'empresa.

/*Exercici 3: Des de la secció de màrqueting et sol·liciten que els passis un llistat dels països que estan fent compres.*/
SELECT DISTINCT country AS Pais
FROM company
LEFT JOIN transaction -- Fusionem la taula company amb la taula transaction.
ON company.id = transaction.company_id; -- Seleccionem els camps que relacionen les dues taules.

/*Exercici 4: Des de màrqueting també volen saber des de quants països es realitzen les compres.*/
SELECT COUNT(DISTINCT country) AS Paisos -- En aquest cas farem servir un COUNT per contar el numero de paisos individuals(distinct) que estan fent compres.
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id;

/*Exercici 5 El teu superior identifica un error amb la companyia que té l'id 'b-2354'.
Per tant, et sol·licita que li indiquis el país i nom de companyia d'aquest id.*/
SELECT country AS Pais, company_name AS Nom
FROM company
WHERE id = "b-2354"; -- Amb aquest filtre, li diem que ens mostri totes les empreses que tenen el id "b-2354.

/*Exercici 6 A més, el teu cap et sol·licita que indiquis quina és la companyia amb major despesa mitjana?*/
SELECT company_name AS Nom
FROM company
JOIN transaction
ON company.id = transaction.company_id
GROUP BY company_name -- Agruparem els resultats pel nom de l'empresa.
ORDER BY AVG(transaction.amount) DESC -- Ordenarem Descendentment (DESC) segons el calcul de la mitjana(AVG) de despesa(amount).
LIMIT 1; -- Amb aquest limit mostrem només el primer resultat.


/*NIVELL 2
Exercici 1: El teu cap et sol·licita verificar si en la base de dades existeixen companyies amb identificadors (id) duplicats.*/
SELECT id, COUNT(*) AS Copies -- Aqui diem que volem visualitzar els id's i una contabilitat de cada fila que mes tard agruparem per id.
FROM company
GROUP BY id -- Agrupem tots els counts per id. Aixi veurem quantes files te cada id.
HAVING Copies > 1; -- Aqui fem que nomes es mostrin els id que tenen mes d'una fila, es a dir, que estan duplicats.

/*Exercici 2 En quin dia es van realitzar les cinc vendes més costoses? Mostra la data de la transacció i la sumatòria de la quantitat de diners.*/
SELECT DATE(timestamp) AS Data, SUM(amount) AS Sumatoria -- Fem un select de la data(timestamp) i de la suma dels amounts.
FROM transaction
GROUP BY Data -- Agrupem les sumes dels amounts per data. Aixi veurem el valor total de cada dia.
ORDER BY Sumatoria DESC -- Ordenem pel total de despesa diaria de manera descendent. Aixi veurem quin dia s'ha gastat més en primer lloc.
LIMIT 5; -- Fem que nomes es mostrin els cinc primers resultats.

#Exercici 3: En quin dia es van realitzar les cinc vendes de menor valor? Mostra la data de la transacció i la sumatòria de la quantitat de diners.
SELECT DATE(timestamp) AS Data, SUM(amount) AS Sumatoria
FROM transaction
GROUP BY Data
ORDER BY Sumatoria ASC -- Es el mateix que la query anterior per en comptes de DESC es  ASC. Aixi es mostraran els valors més baixos primer.
LIMIT 5;

/*Exercici 4: Quina és la mitjana de despesa per país? Presenta els resultats ordenats de major a menor mitjà.*/
SELECT company.country AS Pais, AVG(transaction.amount) AS Despesa_Mitjana -- Fem un select del nom del pais i la mitjana(AVG) de la despesa(amount).
From company
LEFT JOIN transaction -- Fusionem la taula company amb la taula transaction.
ON company.id = transaction.company_id
GROUP BY Pais -- Agruper per nom de pais, aixi ens proporcionara la mitjana de despesa de cada pais.
ORDER BY Despesa_Mitjana DESC; -- Ordenem per despesa. La despesa mes gran sera la primera.


/*NIVELL 3
Exercici 1: Presenta el nom, telèfon i país de les companyies, juntament amb la quantitat total gastada, d'aquelles que van realitzar
transaccions amb una despesa compresa entre 100 i 200 euros. Ordena els resultats de major a menor quantitat gastada.*/
SELECT company_name AS Nom, phone AS Telefon, country AS Pais, SUM(transaction.amount) AS Total_Gastat
FROM Company
LEFT JOIN transaction -- Fusionem la taula company amb la taula transaction.
ON company.id = transaction.company_id
WHERE transaction.amount BETWEEN 100 AND 200 -- Afegim un filtre que només mostri els resultats on l'amount es troba entre 100 i 200.
GROUP BY company.id -- Agrupem per id de l'empresa. Aixi veurem la suma de les transaccions de cada empresa.
ORDER BY Total_Gastat DESC; -- Ordenem per despesa. La despesa mes gran sera la primera.

/*Exercici 2: Indica el nom de les companyies que van fer compres el 16 de març del 2022, 28 de febrer del 2022 i 13 de febrer del 2022.*/
SELECT DISTINCT company_name AS Nom
FROM Company
LEFT JOIN transaction -- Fusionem la taula company amb la taula transaction.
ON company.id = transaction.company_id
WHERE DATE(timestamp) IN ("2022-03-16", "2022-02-28", "2022-02-13"); --Utilitzem el filtre DATE sobre el camp timestamp i seleccionem les dates.











