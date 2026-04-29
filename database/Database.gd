extends Node

var db := SQLite.new()

func abrir_db():
	db.path = "user://partida.db"
	db.open_db()
	return true

func cerrar_db():
	db.close_db()
	return true

func crear_tabla_si_no_existe():
	var sql = """
        CREATE TABLE IF NOT EXISTS tiempos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            jugador TEXT NOT NULL,
			nivel INTEGER NOT NULL,
            duracion INTEGER NOT NULL
        );
	"""
	db.query(sql)
	
	sql = """
        CREATE TABLE IF NOT EXISTS partida (
			idPartida INTEGER PRIMARY KEY AUTOINCREMENT,
			pos_x REAL NOT NULL,
			pos_y REAL NOT NULL);
	"""
	db.query(sql)
	
	sql = """
        CREATE TABLE IF NOT EXISTS ajustes (
			idAjustes INTEGER PRIMARY KEY AUTOINCREMENT,
			pos_x REAL NOT NULL,
			pos_y REAL NOT NULL);
	"""
	db.query(sql)

func reiniciar_datos():
	abrir_db()
	var sql = "delete from tiempos;"
	db.query(sql)
	sql = "delete from partida;"
	db.query(sql)
	cerrar_db()

func insertar_datos_ejemplo():
	var ejemplos = [
		{"jugador":"Ana", "nivel":1, "duracion":300},
		{"jugador":"Ana", "nivel":2, "duracion":240},
	]
	for fila in ejemplos:
		var sql = "INSERT INTO tiempos (jugador, nivel, duracion) VALUES ('%s', %d, %d);" % [fila["jugador"], fila["nivel"], fila["duracion"]]
		db.query(sql)

func obtener_record_de_tiempo():
	var query = """
        SELECT jugador, MIN(duracion) AS mejor_tiempo
        FROM tiempos
        ORDER BY mejor_tiempo DESC;
	"""
	db.query(query)
	return db.query_result
	
func obtener_todo():
	var query = "select * from tiempos;"
	db.query(query)
	return db.query_result

func obtener_datos_ultima_partida():
	var sql = "SELECT pos_x, pos_y FROM partida ORDER BY idPartida DESC LIMIT 1;"
	db.query(sql)
	return db.query_result

func hay_partida_guardada():
	var sql = "SELECT COUNT(*) as total FROM partida;"
	db.query(sql)
	var resultado = db.query_result
	print(resultado)
	if resultado.size() > 0:
		return resultado[0]["total"] > 0

	return false
