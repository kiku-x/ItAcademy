## Basics
### Select
Per veure la taula amb la que treballem(nom_taula):
```ruby
SELECT *
FROM nom_taula;
```

Si volem que només es mostrin alguns camps:
```ruby
SELECT Camp_1, Camp_2
FROM nom_taula;
```
### Select Distinct
Per no veure repetits (Encara que hi hagin varis *Camp_2* amb el mateix *Camp_1*, només veurem el primer resultat de cada *Camp_1*:
```ruby
SELECT DISTINCT Camp_1
FROM nom_taula;
```
> Exemple: (La taula només ens mostrarà els country codes de les ciutats pero sense repetir-ne cap.
```ruby
SELECT DISTINCT countrycode
FROM City;
```



### Order By
> Serveix per ordenar els resultats.

Aqui ordenarem les ciutats per població ascendent(ASC) mostrant el nom i la població de cada una. Podem fer-la descendent cambiant el ASC per DESC.
```ruby
SELECT name, population
FROM City
ORDER BY population ASC;
```

També pode ordenar pel primer *(o el que sigui)* camp del SELECT posant el número de la columna.
```ruby
SELECT DISTINCT Language
FROM world.countrylanguage;
ORDER BY 1;
```

### Top/Limit
> Serveix per limitar un número de registres. (En aquest cas ho limitarem a 200 registres, és a dir, només apareixeran les primeres 200 files.)
```ruby
SELECT name, population
FROM City
ORDER BY population ASC
LIMIT 200;
```
### Comentaris
Comentaris amb # per una sola linia.
Comentaris amb -- per una sola linia.
Comentaris amb /* */ per multilinia.
```ruby
--Nivell 2
#Exercici 1
/*Enunciant de
l'exercici*/
SELECT name, population
FROM City
ORDER BY population ASC or DESC
LIMIT 200;
```

### WHERE
> Serveix per Per Filtrar.

En aquest cas em mostrarà les ciutats amb una població superior als 100.000 habitants.
```ruby
SELECT name, population
FROM City
WHERE population > 100000;
```

Podem utilitzar tots aquests operadors amb WHERE:

`=`			Equal

`>`			Greater than 

`<`			Less than 

`>=`			Greater than or equal 

`<=`			Less than or equal 

`<>`			Not equal. Note: In some versions of SQL this operator may be written as != 

`BETWEEN`		Between a certain range 

`LIKE`			Search for a pattern 

`IN`			To specify multiple possible values for a column


En el cas de BETWEEEN ho farem així. Aqui mostrarem les ciutats amb una població entre 1.000 i 10.000 habitants.
```ruby
SELECT name, population
FROM City
WHERE Population BETWEEN 1000 AND 100000;
```

LIKE
Return all customers from a city that starts with 'L' followed by one wildcard character, then 'nd' and then two wildcard characters:
SELECT * FROM Customers
WHERE city LIKE 'L_nd__';

Return all customers from a city that contains the letter 'L':
SELECT * FROM Customers
WHERE city LIKE '%L%';


IN
The IN operator allows you to specify multiple values in a WHERE clause.
The IN operator is a shorthand for multiple OR conditions.

Return all customers from 'Germany', 'France', or 'UK'
SELECT * FROM Customers
WHERE Country IN ('Germany', 'France', 'UK');


BETWEEN
The BETWEEN operator selects values within a given range. The values can be numbers, text, or dates.
The BETWEEN operator is inclusive: begin and end values are included. 

Selects all products with a price between 10 and 20:
SELECT * FROM Products
WHERE Price BETWEEN 10 AND 20;



 Here is a simple flow chart:

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
