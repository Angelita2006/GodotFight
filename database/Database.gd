extends Node

var db := SQLite.new()

func abrir_db():
	db.path = "user://tiempos.db"
	db.open_db()
	return true

func cerrar_db():
	db.close_db()
	return true

func crear_tablas_si_no_existen():
	# Abrimos la base de datos antes de crear las tablas
	abrir_db()
	
	var sql = """
		CREATE TABLE IF NOT EXISTS tiempos (
			id INTEGER PRIMARY KEY AUTOINCREMENT,
			jugador TEXT NOT NULL,
			nivel INTEGER NOT NULL,
			duracion REAL NOT NULL,
			puntos INTEGER NOT NULL
		);
	"""
	db.query(sql)
	
	# Cerramos la base de datos al terminar
	cerrar_db()

func insertar_datos_ejemplo():
	abrir_db()
	var ejemplos_tiempos = [
		{"jugador":"Ana", "nivel":1, "duracion":300},
		{"jugador":"Ana", "nivel":2, "duracion":240},
	]
	# Usamos query_with_bindings para evitar errores de sintaxis con textos
	for fila in ejemplos_tiempos:
		var sql = "INSERT INTO tiempos (jugador, nivel, duracion) VALUES (?, ?, ?);"
		db.query_with_bindings(sql, [fila["jugador"], fila["nivel"], fila["duracion"]])
	cerrar_db()

func reiniciar_datos():
	abrir_db()
	db.query("DELETE FROM tiempos;")
	cerrar_db()

func guardar_tiempo(nivel: int, duracion: float, puntos: int):
	print("DEBUG: guardando tiempo para el nivel: ", nivel)
	
	# 1. Asegurar tablas
	crear_tablas_si_no_existen()
	
	# 2. Abrir para operar
	abrir_db()

	var sql = "INSERT INTO tiempos (jugador, nivel, duracion, puntos) VALUES (?, ?, ?, ?);"
	var parametros = [
		str(Global.jugador_nombre), 
		str(nivel), 
		str(duracion),
		str(puntos)
	]
	
	db.query_with_bindings(sql, parametros)
	
	# Comprobación limpia
	#db.query("SELECT * FROM tiempos")
	#print("Tiempos guardados: ", db.query_result)
	
	cerrar_db()

func obtener_todo():
	crear_tablas_si_no_existen()
	abrir_db()
	db.query("SELECT * FROM tiempos ORDER BY duracion ASC;")
	var resultado = db.query_result
	cerrar_db()
	return resultado
