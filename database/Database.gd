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
			volumen REAL NOT NULL DEFAULT 0.7,
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

func hay_partida_guardada():
	abrir_db()
	db.query("SELECT COUNT(*) as total FROM partida;")
	var resultado = db.query_result
	cerrar_db()
	if resultado.size() > 0:
		return resultado[0]["total"] > 0
	return false

func guardar_partida():
	# 1. Asegurar que las tablas existan
	crear_tablas_si_no_existen()
	
	# 2. Abrir para operar
	abrir_db()
	
	var llave_verde = 1 if Global.llave_verde_obtenida else 0
	var llave_purpura = 1 if Global.llave_purpura_obtenida else 0
	var llave_plateada = 1 if Global.llave_plateada_obtenida else 0
	var llave_dorada = 1 if Global.llave_dorada_obtenida else 0
	var llave_final = 1 if Global.llave_final_obtenida else 0
	
	var ruta_escena = get_tree().current_scene.scene_file_path
	var uid_escena = str(ResourceLoader.get_resource_uid(ruta_escena))
	
	# Comprobar si ya existe una partida guardada
	db.query("SELECT COUNT(*) as total FROM partida;")
	var resultado = db.query_result
	
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
	
	if resultado.size() > 0 and resultado[0]["total"] > 0:
		# UPDATE si ya existe
		var sql_update = """
			UPDATE partida
			SET
				llave_verde_conseguida = ?,
				llave_purpura_conseguida = ?,
				llave_plateada_conseguida = ?,
				llave_dorada_conseguida = ?,
				llave_final_conseguida = ?,
				escena_actual = ?,
				pos_x = ?,
				pos_y = ?
			WHERE idPartida = (
				SELECT idPartida FROM partida
				ORDER BY idPartida DESC
				LIMIT 1
			);
		"""
		
		db.query_with_bindings(sql_update, parametros)
	else:
		# INSERT si no existe
		var sql_insert = """
			INSERT INTO partida
			(llave_verde_conseguida, llave_purpura_conseguida, llave_plateada_conseguida,
			llave_dorada_conseguida, llave_final_conseguida, escena_actual, pos_x, pos_y)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?);
		"""
		
		db.query_with_bindings(sql_insert, parametros)
	
	cerrar_db()

func obtener_datos_ultima_partida():
	abrir_db()
	db.query("SELECT * FROM partida ORDER BY idPartida DESC LIMIT 1;")
	var resultado = db.query_result
	cerrar_db()
	return resultado

func guardar_ajustes():
	# 1. Asegurar tablas
	crear_tablas_si_no_existen()
	
	# 2. Abrir para operar
	abrir_db()
	
	# Comprobar si ya existen ajustes
	db.query("SELECT COUNT(*) as total FROM ajustes;")
	var resultado = db.query_result
	
	var parametros = [
		Global.volumen,
		str(Global.idioma),
		str(Global.jugador_aspecto),
		str(Global.jugador_nombre)
	]
	
	if resultado.size() > 0 and resultado[0]["total"] > 0:
		# UPDATE si ya existen
		var sql_update = """
			UPDATE ajustes
			SET
				volumen = ?,
				idioma = ?,
				jugador_aspecto = ?,
				jugador_nombre = ?
			WHERE idAjustes = (
				SELECT idAjustes FROM ajustes
				ORDER BY idAjustes DESC
				LIMIT 1
			);
		"""
		
		db.query_with_bindings(sql_update, parametros)
	else:
		# INSERT si no existen
		var sql_insert = """
			INSERT INTO ajustes
			(volumen, idioma, jugador_aspecto, jugador_nombre)
			VALUES (?, ?, ?, ?);
		"""
		
		db.query_with_bindings(sql_insert, parametros)
	
	cerrar_db()

func obtener_datos_ajustes():
	abrir_db()
	db.query("SELECT * FROM ajustes ORDER BY idAjustes DESC LIMIT 1;")
	var resultado = db.query_result
	cerrar_db()
	print(resultado)
	return resultado

func guardar_tiempo(nivel: String, duracion: float):
	# 1. Asegurar tablas
	crear_tablas_si_no_existen()
	
	# 2. Abrir para operar
	abrir_db()
	
	var sql = "INSERT INTO tiempos (jugador, nivel, duracion) VALUES (?, ?, ?);"
	var parametros = [
		str(Global.jugador_nombre), 
		str(nivel), 
		str(duracion)
	]
	
	db.query_with_bindings(sql, parametros)
	
	# Comprobación limpia
	db.query("SELECT * FROM tiempos")
	print("Tiempos guardados: ", db.query_result)
	
	cerrar_db()

func obtener_todo():
	abrir_db()
	db.query("SELECT * FROM tiempos;")
	var resultado = db.query_result
	cerrar_db()
	return resultado
