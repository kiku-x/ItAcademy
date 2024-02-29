/*NIVELL 1
Exercici 1: La teva tasca és dissenyar i crear una taula anomenada "credit_*card" que emmagatzemi detalls crucials sobre les targetes de crèdit.
La nova taula ha de ser capaç d'identificar de manera única cada targeta i establir una relació adequada amb les altres dues taules ("transaction" i "company").
Després de crear la taula serà necessari que ingressis la informació del document denominat "dades_introduir_credit".
Recorda mostrar el diagramai realitzar una breu descripció d'aquest.*/

CREATE TABLE credit_card( -- Crear una taula amb el nom credit_card.
	id varchar(255) NOT NULL, -- Crear camps de data type varchar. Introduim NOT NULL perque no hi pugui haver camp camp sense informació.
    iban varchar(255) NOT NULL,
    pan varchar(255) NOT NULL,
    pin varchar(255) NOT NULL,
    cvv varchar(255) NOT NULL,
    expiring_date varchar(255) NOT NULL,
    PRIMARY KEY (id) -- Assignem la primary key al camp ID.
    );
    
LOAD DATA -- Carreguem les dades de la taula.
INFILE '/Users/kiku/Desktop/ItAcademy/S3 SQL' -- Informem sobre quina es la ruta d'acces a l'arxiu.
INTO TABLE credit_card; -- Assignem la taula on volem afegir la informació.


/*Exercici 2: El departament de Recursos Humans ha identificat un error en el número de compte de l'usuari amb el: ID CcU-2938.
Es requereix actualitzar la informació que identifica un compte bancari a nivell internacional (identificat com "IBAN"): TR323456312213576817699999.
Recorda mostrar que el canvi es va realitzar.*/

UPDATE credit_card -- Utilitzem update per modificar la informació de la taula.
SET iban = 'TR323456312213576817699999' -- Afegim la nova informació dient-li a quin camp ha danar.
WHERE id='CcU-2938'; -- Assignem a quines files ha de canviar la informació. En aquest cas només la fila on l'id sigui CcU-2938.


/*Exercici 3: En la taula "credit_card" ingressa un nou usuari amb la següent informació:
Id 108B1D1D-5B23-A76C-55EF-C568E49A99DD
credit_card_id CcU-9999
company_id b-9999
user_id 9999
lat 829.999
longitude -117.999
amount 111.11
declined 0*/

ALTER TABLE transaction -- Utilitzem alter table per modificar l'estructura de la taula.
MODIFY COLUMN user_id varchar(255); -- Modifiquem el tipus de data del camp user_id

SET FOREIGN_KEY_CHECKS=0; -- Desvincular la foreign key per poder afegir un nou camp.

INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined) -- Escribim els camps en els quals volem introduir la informació.
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', '829.999', '-117.999', '111.11', '0'); -- Escrivim els valors que corresponen a cada camp de la linia anterior.

SET FOREIGN_KEY_CHECKS=1; -- Vincular la foreign key de nou.



/*Exercici 4: Des de recursos humans et sol·liciten eliminar la columna "pan" de la taula credit_card. Recorda mostrar el canvi realitzat.*/
ALTER TABLE credit_card -- Seleccionem la taula que volem treballar.
DROP COLUMN pan; -- Eliminem la columna anomenada pan.



/*NIVELL 2
Exercici 1: Elimina el registre amb ID 02C6201E-D90A-1859-B4EE-88D2986D3B02 de la base de dades.*/
DELETE FROM transaction -- Seleccionem la taula de la qual volem eliminar contingut.
WHERE id = "02C6201E-D90A-1859-B4EE-88D2986D3B02"; -- Introduim un filtre per assignar la fila que ha d'eliminar. En aquest cas, la fila que conté el id 02C6201E-D90A-1859-B4EE-88D2986D3B02.


/*Exercici 2: La secció de màrqueting desitja tenir accés a informació específica per a realitzar anàlisi i estratègies efectives.
S'ha sol·licitat crear una vista que proporcioni detalls clau sobre les companyies i les seves transaccions.
Serà necessària que creïs una vista anomenada VistaMarketing que contingui la següent informació:
Nom de la companyia. Telèfon de contacte. País de residència. Mitjana de compra realitzat per cada companyia.
Presenta la vista creada, ordenant les dades de major a menor mitjana de compra.*/

CREATE VIEW VistaMarketing AS -- Creem una nova vista anomenada VistaMarketing
SELECT company_name AS Nom, phone AS Telefon, country AS Pais, AVG(amount) AS "Mitjana de compra" -- Seleccionem els camps que volem que apareguin.
FROM company -- Seleccionem la taula d'on provenen els camps.
LEFT JOIN transaction -- Fem un join per obtenir els camps que manquen de les altres taules.
ON company.id = transaction.company_id
GROUP BY company.id; -- Agrupem la mitjana de la compra segons el id del pais. Aixi ens farà la mitjana de compra de cada pais.

-- Amb aquesta query podem veure la vista ja creada:
SELECT *
FROM transactions.vistamarketing;


/*Exercici 3: Filtra la vista VistaMarketing per a mostrar només les companyies que tenen el seu país de residència en "Germany".*/
SELECT *
FROM transactions.vistamarketing
WHERE Pais = "Germany";


/*NIVELL 3
Exercici 1: La setmana vinent tindràs una nova reunió amb els gerents de màrqueting.
Un company del teu equip va realitzar modificacions en la base de dades, però no recorda com les va realitzar.
Et demana que l'ajudis a deixar els comandos executats per a obtenir les següents modificacions (s'espera que realitzin 6 canvis):*/

-- Primer tenim que coneixer el datatype de cada camp de totes les taules
SELECT
TABLE_NAME, COLUMN_NAME, DATA_TYPE -- Escollim els camps que volem veure.
FROM INFORMATION_SCHEMA.COLUMNS -- Escollim el esquema que volem visualitzar. (Conjunt de taules)
WHERE TABLE_SCHEMA = 'transactions'; -- Seleccionem el esquema que conté les taules.

-- Afegirem una nova columna de temps actual a la taula credit_card.
ALTER TABLE credit_card
ADD fecha_actual TIMESTAMP DEFAULT now();

-- No puc continuar amb l'exercici perque el MySQL crashea al iniciar el reverse engineering amb Mac Silicon.





/*Exercici 2:L'empresa també et sol·licita crear una vista anomenada "InformeTecnico" que contingui la següent informació:

ID de la transacció
Nom de l'usuari/ària
Cognom de l'usuari/ària
IBAN de la targeta de crèdit usada.
Nom de la companyia de la transacció realitzada.
Assegura't d'incloure informació rellevant de totes dues taules i utilitza àlies per a canviar de nom columnes segons sigui necessari.
Mostra els resultats de la vista, ordena els resultats de manera descendent en funció de la variable ID de transaction.*/

CREATE VIEW InformeTecnico AS -- Crearem una nova vista anomendada 
SELECT transaction.id AS Id, user.name AS Nom, user.surname AS Cognom, credit_card.iban AS IBAN, company.company_name AS Empresa -- Seleccionem els camps que volem que apareguin.
FROM transaction -- Seleccionem la taula d'on provenen els camps.
LEFT JOIN user -- Fem un join per obtenir els camps que manquen de la taula user.
ON transaction.user_id = user.id
LEFT JOIN company -- Fem un join per obtenir els camps que manquen de la taula company.
ON transaction.company_id = company.id
LEFT JOIN credit_card -- Fem un join per obtenir els camps que manquen de la taula credit_card.
ON transaction.credit_card_id = credit_card.id;

SELECT * -- Visualitzem tota la taula.
FROM transactions.informetecnico -- Seleccionem quina taula, en aquest cas es una vista.
ORDER BY informetecnico.id DESC; -- Ordenem segons els ID de manera descendent.
