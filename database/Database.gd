extends Node

var db := SQLite.new()

func abrir_db():
	db.path = "user://partida.db"
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
			duracion INTEGER NOT NULL
		);
	"""
	db.query(sql)
	
	sql = """
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
	"""
	db.query(sql)
	
	sql = """
		CREATE TABLE IF NOT EXISTS ajustes (
			idAjustes INTEGER PRIMARY KEY AUTOINCREMENT,
			volumen REAL NOT NULL,
			idioma TEXT NOT NULL,
			jugador_aspecto TEXT NOT NULL,
			jugador_nombre TEXT NOT NULL
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

func obtener_record_de_tiempo():
	abrir_db()
	var query = """
        SELECT jugador, MIN(duracion) AS mejor_tiempo
        FROM tiempos
        ORDER BY mejor_tiempo DESC;
	"""
	db.query(query)
	var resultado = db.query_result
	cerrar_db()
	return resultado
	
func obtener_todo():
	abrir_db()
	db.query("SELECT * FROM tiempos;")
	var resultado = db.query_result
	cerrar_db()
	return resultado

func obtener_datos_ultima_partida():
	abrir_db()
	db.query("SELECT * FROM partida ORDER BY idPartida DESC LIMIT 1;")
	var resultado = db.query_result
	cerrar_db()
	return resultado

func hay_partida_guardada():
	abrir_db()
	db.query("SELECT COUNT(*) as total FROM partida;")
	var resultado = db.query_result
	cerrar_db()
	if resultado.size() > 0:
		return resultado[0]["total"] > 0
	return false

func guardar_partida():
	# 1. Asegurar que las tablas existan (esa función ya abre y cierra la db)
	crear_tablas_si_no_existen()
	
	# 2. Abrir para operar
	abrir_db()
	db.query("DELETE FROM partida")
	
	var llave_verde = 1 if (Global.llave_verde_obtenida == true) else 0
	var llave_purpura = 1 if (Global.llave_purpura_obtenida == true) else 0
	var llave_plateada = 1 if (Global.llave_plateada_obtenida == true) else 0
	var llave_dorada = 1 if (Global.llave_dorada_obtenida == true) else 0
	var llave_final = 1 if (Global.llave_final_obtenida == true) else 0
	
	var ruta_escena = get_tree().current_scene.scene_file_path
	var uid_escena = str(ResourceLoader.get_resource_uid(ruta_escena))
	
	# Usamos "?" para que el plugin maneje las comillas y los tipos de datos de forma segura
	var sql = """
		INSERT INTO partida 
		(llave_verde_conseguida, llave_purpura_conseguida, llave_plateada_conseguida, llave_dorada_conseguida, llave_final_conseguida, escena_actual, pos_x, pos_y) 
		VALUES (?, ?, ?, ?, ?, ?, ?, ?);
	"""
	
	var parametros = [
		llave_verde, 
		llave_purpura, 
		llave_plateada, 
		llave_dorada, 
		llave_final, 
		uid_escena, 
		Global.jugador_posX, 
		Global.jugador_posY
	]
	
	db.query_with_bindings(sql, parametros)
	cerrar_db()

func guardar_ajustes():
	# 1. Asegurar tablas
	crear_tablas_si_no_existen()
	
	# 2. Abrir para operar
	abrir_db()
	db.query("DELETE FROM ajustes")
	
	# Reparado usando query_with_bindings para evitar el fallo de comillas y comas
	var sql = "INSERT INTO ajustes (volumen, idioma, jugador_aspecto, jugador_nombre) VALUES (?, ?, ?, ?);"
	var parametros = [
		Global.volumen, 
		str(Global.idioma), 
		str(Global.jugador_aspecto), 
		str(Global.jugador_nombre)
	]
	
	db.query_with_bindings(sql, parametros)
	
	# Comprobación limpia
	db.query("SELECT * FROM ajustes")
	#print("Ajustes guardados: ", db.query_result)
	
	cerrar_db()

func obtener_datos_ajustes():
	abrir_db()
	db.query("SELECT * FROM ajustes ORDER BY idAjustes DESC LIMIT 1;")
	var resultado = db.query_result
	cerrar_db()
	print(resultado)
	return resultado
