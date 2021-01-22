--- Crear base de datos llamada peliculas
    CREATE DATABASE peliculas;

--- Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes, determinando la  relación   entre ambas tablas.
    CREATE TABLE tabpeliculas(
        id INT,
        pelicula VARCHAR(100),
        ano_estreno INT,
        director VARCHAR(100)
    );

    --transformar id de tabla peliculas en llave primaria   
    ALTER TABLE tabpeliculas ADD PRIMARY KEY (id);

    CREATE TABLE reparto(
        tabpeliculas_id INT,
        actor_actriz VARCHAR(60),
        FOREIGN KEY (tabpeliculas_id) REFERENCES tabpeliculas(id)
    );

    -- Cargar ambos archivos a su tabla correspondiente
        \copy tabpeliculas FROM '/home/david/Escritorio/desafiolatam/desafios/db/top_100/peliculas.csv' csv header;
        \copy reparto FROM '/home/david/Escritorio/desafiolatam/desafios/db/top_100/reparto.csv' csv;
        


    --listar los titulos de las peliculas donde actue harrison ford
        SELECT pelicula 
        FROM tabpeliculas FULL JOIN reparto 
        ON tabpeliculas.id=reparto.tabpeliculas_id 
        WHERE reparto.actor_actriz='Harrison Ford';




    -- listar los 10 directores mas populares, indicando su nombre y cuantas peliculas aparecen en el top 100
        SELECT director,count(director) as cantidad_peliculas 
        FROM tabpeliculas 
        GROUP BY director 
        ORDER BY cantidad_peliculas DESC 
        LIMIT 10;




    --indicar cuantos actores distintos hay
        SELECT count(distinct actor_actriz) as actores_distintos 
        FROM reparto;




    -- indicar las peliculas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por titulo de manera     ascendente
        SELECT pelicula 
        FROM tabpeliculas 
        WHERE ano_estreno BETWEEN '1990' AND '1999' 
        ORDER BY pelicula ASC;


        

    -- listar el reparto de las peliculas lanzadas el año 2001
        SELECT actor_actriz 
        FROM reparto FULL JOIN tabpeliculas 
        ON reparto.tabpeliculas_id=tabpeliculas.id 
        WHERE tabpeliculas.ano_estreno='2001';





    -- Listar los actores de la película más nueva
    SELECT tabpeliculas.ano_estreno, reparto.actor_actriz FROM tabpeliculas FULL JOIN reparto 
    ON reparto.tabpeliculas_id = tabpeliculas.id
    WHERE tabpeliculas.ano_estreno = (
        SELECT max(tabpeliculas.ano_estreno) FROM tabpeliculas
    );
