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

### Where
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


En el cas de `BETWEEEN` ho farem així. Aqui mostrarem les ciutats amb una població entre 1.000 i 10.000 habitants.
```ruby
SELECT name, population
FROM City
WHERE Population BETWEEN 1000 AND 100000;
```

Per `LIKE` ho farem així. Buscarem noms de ciutats que comencin amb la lletra L.
```ruby
SELECT name, population
FROM City
WHERE name LIKE 'L%';
```
El carácter `%L`ens indica que despres de la L hi pot haber un o varis carácters. Aquest carácter `%`s'anomena **Wildcard** i n'hi ha de varis tipus.

`%`	Representa un zero o un o més carácters. *Ex:* `'L%'`

`_`	Representa un sol carácter. *Ex:* `'L_nd__'`

`[]`	Representa qualsevol carácter dins dels brackets. *(Not supported in PostgreSQL and MySQL databases)*

`^`	Represents qualsevol carácter que no estigui dins dels brackets. *(Not supported in PostgreSQL and MySQL databases)*

`-`	Representa qualsevol carácter dins del rango especificat. *(Not supported in PostgreSQL and MySQL databases)*


### IN
L'operador `IN` es un abreviador de `OR`. Permet especificar diferents valors dins de les clausules `WHERE` 
En aquest cas mostrarem totes les ciutats de Alemanya, França i Gran Bretanya:
```ruby
SELECT *
FROM city
WHERE Country IN ('Germany', 'France', 'UK');
```

## Joins
Una clàusula JOIN s'utilitza per combinar files de dues o més taules, basant-se en alguna columna que les pugui relacionar entre elles.
Hi ha varis tipus de JOINS:

`JOIN`: Retorna registres que tenen valors coincidents a les dues taules.
![alt text](https://www.w3schools.com/sql/img_inner_join.png)

`LEFT JOIN`: retorna tots els registres de la taula de l'esquerra i els registres coincidents de la taula de la dreta.
![alt text](https://www.w3schools.com/sql/img_left_join.png)

`RIGHT JOIN`: retorna tots els registres de la taula de la dreta i els registres coincidents de la taula de l'esquerra.
![alt text](https://www.w3schools.com/sql/img_right_join.png)

`FULL JOIN`: retorna tots els registres quan hi ha una coincidència a la taula dreta o esquerra.
![alt text](https://www.w3schools.com/sql/img_full_outer_join.png)

Per exemple, ara ajuntarem les taules de la informacio de les ciutats i dels paisos. D'aquesta manera podem visualitzar la informació de la ciutat i el seu pais corresponent en una sola taula.
```ruby
SELECT name, population
FROM City
JOIN Country
ON city.country_id = country.id
```
