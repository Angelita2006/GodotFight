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

func insertar_datos_ejemplo():
	var ejemplos_tiempos = [
		{"jugador":"Ana", "nivel":1, "duracion":300},
		{"jugador":"Ana", "nivel":2, "duracion":240},
	]
	for fila in ejemplos_tiempos:
		var sql = "INSERT INTO tiempos (jugador, nivel, duracion) VALUES ('%s', %d, %d);" % [fila["jugador"], fila["nivel"], fila["duracion"]]
		db.query(sql)
	
	var ejemplo_partida = {"llave_verde_conseguida":1, "llave_purpura_conseguida":0, "llave_plateada_conseguida":0, "llave_dorada_conseguida":0, "llave_final_conseguida":0, "escena_actual":"uid://c61j2kork7ar5", "pos_x":1348.0, "pos_y":28.0}
	

func reiniciar_datos():
	abrir_db()
	var sql = "delete from tiempos;"
	db.query(sql)
	sql = "delete from partida;"
	db.query(sql)
	cerrar_db()

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
	var sql = "SELECT * FROM partida ORDER BY idPartida DESC LIMIT 1;"
	db.query(sql)
	var resultado = db.query_result
	print(resultado)
	return resultado

func hay_partida_guardada():
	var sql = "SELECT COUNT(*) as total FROM partida;"
	db.query(sql)
	var resultado = db.query_result
	if resultado.size() > 0:
		return resultado[0]["total"] > 0

	return false

func guardar_partida():
	#abrir_db()
	crear_tablas_si_no_existen()
	db.query("DELETE FROM partida")
	var llave_verde_conseguida = 1 if (Global.llave_verde_obtenida == true) else 0
	var llave_purpura_conseguida = 1 if (Global.llave_purpura_obtenida == true) else 0
	var llave_plateada_conseguida = 1 if (Global.llave_plateada_obtenida == true) else 0
	var llave_dorada_conseguida = 1 if (Global.llave_dorada_obtenida == true) else 0
	var llave_final_conseguida = 1 if (Global.llave_final_obtenida == true) else 0
	var ruta_escena = get_tree().current_scene.scene_file_path
	var uid_escena = ResourceLoader.get_resource_uid(ruta_escena)
	db.query("INSERT INTO partida (llave_verde_conseguida, llave_purpura_conseguida, llave_plateada_conseguida, llave_dorada_conseguida, llave_final_conseguida, escena_actual, pos_x, pos_y) VALUES ("+str(llave_verde_conseguida)+","+str(llave_purpura_conseguida)+","+str(llave_plateada_conseguida)+","+str(llave_dorada_conseguida)+","+str(llave_final_conseguida)+","+str(uid_escena)+","+str(Global.jugador_posX)+","+str(Global.jugador_posY)+")")
	#cerrar_db()
