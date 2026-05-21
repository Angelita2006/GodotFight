CREATE TABLE IF NOT EXISTS tiempos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    jugador TEXT NOT NULL,
	nivel INTEGER NOT NULL,
    duracion INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS partida (
	idPartida INTEGER PRIMARY KEY AUTOINCREMENT,
	llave_verde_conseguida BOOLEAN NOT NULL CHECK (llave_verde_conseguida IN (0, 1)),
	llave_purpura_conseguida BOOLEAN NOT NULL CHECK (llave_purpura_conseguida IN (0, 1)),
	llave_plateada_conseguida BOOLEAN NOT NULL CHECK (llave_plateada_conseguida IN (0, 1)),
	llave_dorada_conseguida BOOLEAN NOT NULL CHECK (llave_dorada_conseguida IN (0, 1)),
	llave_final_conseguida BOOLEAN NOT NULL CHECK (llave_final_conseguida IN (0, 1)),
	escena_actual TEXT NOT NULL,
	pos_x REAL NOT NULL,
	pos_y REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS ajustes (
	idAjustes INTEGER PRIMARY KEY AUTOINCREMENT,
	volumen REAL NOT NULL,
	idioma TEXT NOT NULL,
	jugador_aspecto TEXT NOT NULL,
	jugador_nombre TEXT NOT NULL
);