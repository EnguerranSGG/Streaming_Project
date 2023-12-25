# Streaming_ES

Vous trouverez ci-dessous un lien pour installer postgresql. cliquez sur la version (Windows, OS...) en fonction de vos besoins et cliquez sur "Download the installer".

https://www.postgresql.org/download/

Laissez-vous guider par l'installeur et, une fois terminé, RDV dans l'applciation "PGAdmin4".

## Auteurs

- [@EnguerranSGG](https://github.com/EnguerranSGG)

## Les requêtes tests

### Requête pour obtenir les titres et dates de sortie des films du plus récent au plus ancien :

```bash 
SELECT mv_name, mv_release_date
FROM public.movies
ORDER BY mv_release_date DESC; 
```

### Requêtes pour obtenir les noms, prénoms et âges des acteurs/actrices de plus de 30 ans dans l'ordre alphabétique :

```bash 
SELECT 
act_first_name, 
act_name, 
EXTRACT(YEAR FROM AGE(CURRENT_DATE, act_birth_date)) AS current_age
	FROM public.actors
	WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, act_birth_date)) > 30
	ORDER BY act_name ASC; 
```
### Requête pour obtenir la liste des acteurs/actrices principaux pour un film donné

```bash 
SELECT 
    actors.act_name,
    actors.act_first_name
FROM 
    public.actors
JOIN 
    public.movies_actors ON actors.act_id = movies_actors.act_id
JOIN 
    public.movies ON movies_actors.mv_id = movies.mv_id
WHERE 
    movies.mv_name = 'Jurassic Park'
    AND movies_actors.ma_is_lead_role = true;
```

### Requête pour avoir la liste des films pour un acteur/actrice donné

```bash
SELECT
    movies.mv_name,
    movies_actors.ma_role
FROM
    actors
JOIN
    movies_actors ON actors.act_id = movies_actors.act_id
JOIN
    movies ON movies_actors.mv_id = movies.mv_id
WHERE
    actors.act_name = 'Depp' AND actors.act_first_name = 'Johnny';
```

### Requête pour ajouter un film

```bash
INSERT INTO movies (mv_name, mv_duration, fk_mv_director, mv_director, mv_release_date)
VALUES ('Pluton Attack', '03:46:00', 2, 'Tim Burton', '2023-01-01');
```    

### Requête pour ajouter un acteur 

```bash
INSERT INTO actors (act_name, act_first_name, act_birth_date) VALUES
('Jack', 'Nicholson', '1937-04-22');
```

### Requête pour modifier un film existant

```bash
UPDATE movies
SET
    mv_name = 'Mars Attack',
    mv_duration = '01:46:00',
    mv_director = 'Tim Burton',
    mv_release_date = '1996-12-13',
    mv_updated_at = CURRENT_TIMESTAMP
WHERE
    mv_id = 14;
``` 

### Requête pour supprimer un acteur/actrice

```bash
DELETE FROM actors
WHERE act_id = 18;
```

### Requête pour afficher les 3 derniers acteurs/actrices ajouté(e)s

```bash
SELECT *
FROM actors
ORDER BY act_id DESC
LIMIT 3;
```