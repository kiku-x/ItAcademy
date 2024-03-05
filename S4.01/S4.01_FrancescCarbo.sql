/*NIVELL 1
Descàrrega els arxius CSV, estudia'ls i dissenya una base de dades amb un esquema d'estrella que contingui,
almenys 4 taules de les quals puguis realitzar les següents consultes:*/

CREATE SCHEMA `sprint4` ; -- Creem un nou esquema i el definim com a predeterminat.

CREATE TABLE transactions( -- Crear una taula amb el nom transactions.
	id varchar(255), -- Crear camps de data type varchar. Introduim NOT NULL perque no hi pugui haver camp camp sense informació.
    card_id varchar(255),
    business_id varchar(255),
    timestamp datetime,
    amount decimal(20,2), -- Assignem decimal al preu. que podra tenir fins a 10 numeros(introduim 20 ja que son 10 postius is 10 negatius) i 2 decimals.
    declined bit, -- Asignem bit perque nomes pot ser, 0, 1 o NULL.
    products_id varchar(255),
    user_id int,
    lat varchar(255),
    longitude varchar(255),
    PRIMARY KEY (id) -- Assignem la primary key al camp ID.
    );
    
LOAD DATA LOCAL -- Carreguem les dades de la taula.
INFILE '/Users/kiku/Desktop/ItAcademy/S4 SQL/Resources/transactions.csv' -- Informem sobre quina es la ruta d'acces a l'arxiu.
INTO TABLE transactions; -- Assignem la taula on volem afegir la informació.

-- Podriem fer aquest procés per totes les taules pero es més rapid importar-les directament amb el import wizard.


CREATE VIEW Users AS -- Creem una nova vista anomenada Users on farem una Union de les tres taules. Aixi tindrem tots els users en una sola taula.
SELECT *
FROM users_usa 
UNION ALL
SELECT *
FROM users_uk
UNION ALL
SELECT *
FROM users_ca;


SELECT *
FROM users; -- Comprobem que la vista amb tots els users ha estat creada correctament.


-- Modifiquem el tipus de data type perque ens deixi assignar PK i FK.
ALTER TABLE transactions -- Utilitzem alter table per modificar l'estructura de la taula.
MODIFY COLUMN id varchar(255); -- Modifiquem el tipus de data del camp user_id
ALTER TABLE companies
MODIFY COLUMN company_id varchar(255);
ALTER TABLE credit_cards
MODIFY COLUMN id varchar(255);
ALTER TABLE transactions
MODIFY COLUMN product_ids varchar(255);

ALTER TABLE transactions
MODIFY COLUMN card_id varchar(255);
ALTER TABLE transactions
MODIFY COLUMN business_id varchar(255);
ALTER TABLE transactions
MODIFY COLUMN product_ids varchar(255);
ALTER TABLE products
MODIFY COLUMN id varchar(255);
ALTER TABLE users_ca
MODIFY COLUMN id varchar(255);
ALTER TABLE users_usa
MODIFY COLUMN id varchar(255);
ALTER TABLE users_uk
MODIFY COLUMN id varchar(255);

-- Crearem totes les Primary keys
ALTER TABLE transactions
ADD PRIMARY KEY (id);
ALTER TABLE companies
ADD PRIMARY KEY (company_id);
ALTER TABLE credit_cards
ADD PRIMARY KEY (id);
ALTER TABLE products
ADD PRIMARY KEY (id);
ALTER TABLE users_ca
ADD PRIMARY KEY (id);
ALTER TABLE users_usa
ADD PRIMARY KEY (id);
ALTER TABLE users_uk
ADD PRIMARY KEY (id);


SET FOREIGN_KEY_CHECKS=0;

-- Crearem totes les Foreign keys
ALTER TABLE transactions
ADD CONSTRAINT fk_credit_card
FOREIGN KEY (card_id) REFERENCES credit_cards(id);

ALTER TABLE transactions
ADD CONSTRAINT fk_companies
FOREIGN KEY (business_id) REFERENCES companies(company_id);

ALTER TABLE transactions
ADD CONSTRAINT fk_products
FOREIGN KEY (product_ids) REFERENCES products(id);

ALTER TABLE transactions
ADD CONSTRAINT fk_users_ca
FOREIGN KEY (user_id) REFERENCES users_ca(id);

ALTER TABLE transactions
ADD CONSTRAINT fk_users_usa
FOREIGN KEY (user_id) REFERENCES users_usa(id);

ALTER TABLE transactions
ADD CONSTRAINT fk_users_uk
FOREIGN KEY (user_id) REFERENCES users_uk(id);



/*Exercici 1: Realitza una subconsulta que mostri tots els usuaris amb més de 30 transaccions utilitzant almenys 2 taules.*/
SELECT users.name, COUNT(transactions.id) AS Transaccions -- Select dels camps que volem que es mostrin.
FROM sprint4.users -- Taula d'on obtenim les dades.
JOIN sprint4.transactions -- Join amb la taula transactions.
ON users.id = transactions.user_id
GROUP BY users.name
HAVING COUNT(transactions.id) > 30; -- Filtre per contar els id de transaccio i despres agrupar-los per users.id



/*Exercici 2: Mostra la mitjana de la suma de transaccions per IBAN de les targetes de crèdit en la companyia Donec Ltd. utilitzant almenys 2 taules.*/
SELECT credit_cards.iban, AVG(transactions.amount) AS Mitjana
FROM transactions
JOIN companies
	ON business_id = companies.company_id
JOIN credit_cards
	ON card_id = credit_cards.id
WHERE company_name = "Donec Ltd"
GROUP BY credit_cards.iban;




/*NIVELL 2
Crea una nova taula que reflecteixi l'estat de les targetes de crèdit basat en si les últimes tres transaccions van ser declinades i genera la següent consulta:*/
SELECT credit_cards.id AS Card_ID,
CASE -- Utilitzem case per fer una columna condicional provisional
	WHEN COUNT(transactions.declined) > 3 -- Quan el contador de transaccions declinades=1 sigui superior a 3
	THEN "Active" -- Es mostrarà Active
	ELSE "Not active" -- Si no es compleig la condicional, es msotrarà Not Active.
END AS "Card Status" -- Aquest sera el nom de la columna
FROM credit_cards 
LEFT JOIN transactions ON credit_cards.id = transactions.card_id -- Fem un join per obtenir informació de la taula transactions.
WHERE transactions.declined IN ( -- Creem una subquery per seleccionar només les transaccions declinades, així el count serà només d'aquestes transaccions.
	SELECT transactions.declined
    FROM transactions
	WHERE transactions.declined = "1")
GROUP BY credit_cards.id; -- Agrupem el count de les transaccions pel id de les cards.



/*Exercici 1: Quantes targetes estan actives?*/
SELECT *
FROM (
	SELECT credit_cards.id AS Card_ID,
	CASE
		WHEN COUNT(transactions.declined) > 3
		THEN "Active"
		ELSE "Not active"
	END AS "Card Status"
	FROM credit_cards
	LEFT JOIN transactions ON credit_cards.id = transactions.card_id
	WHERE transactions.declined IN (
		SELECT transactions.declined
		FROM transactions
		WHERE transactions.declined = "1")
	GROUP BY credit_cards.id
    ) card_status
WHERE "Card Status" = "Active"; -- Posem la query de l’exercici anterior dins del FROM i creem un filtre where on definim l’status de la credit_card en Active.



/*NIVELL 3
Crea una taula amb la qual puguem unir les dades del nou arxiu products.csv amb la base de dades creada, tenint en compte que des de transaction tens product_ids.
Genera la següent consulta:*/
CREATE TABLE products( -- Crear una taula amb el nom transactions.
	id varchar(255), -- Crear camps de data type varchar. Introduim NOT NULL perque no hi pugui haver camp camp sense informació.
    product_name varchar(255),
    price varchar(255),
    colour varchar(255),
    weight varchar(255), -- Assignem decimal al preu. que podra tenir fins a 10 numeros(introduim 20 ja que son 10 postius is 10 negatius) i 2 decimals.
    warehouse_id varchar(255),
    PRIMARY KEY (id) -- Assignem la primary key al camp ID.
    );
    
ALTER TABLE transactions
ADD FOREIGN KEY (product_ids) REFERENCES products(id); -- Afegim el foreign key a la taula transactions


LOAD DATA -- Carreguem les dades de la taula.
INFILE '/Users/kiku/Desktop/ItAcademy/S4 SQL/Resources/products.csv' -- Informem sobre quina es la ruta d'acces a l'arxiu.
INTO TABLE products; -- Assignem la taula on volem afegir la informació.

SELECT * -- Comprobem que la taual s'hagi creat correctament.
FROM products;


/*Exercici 1: Necessitem conèixer el nombre de vegades que s'ha venut cada producte.*/
SELECT product_name, COUNT(transactions.product_ids) -- Creem un contador dels ids de producte de la taula transaccions.
FROM products
JOIN transactions
ON products.id = transactions.product_ids
GROUP BY products.product_name; -- Agrupem el count per els noms de productes.
