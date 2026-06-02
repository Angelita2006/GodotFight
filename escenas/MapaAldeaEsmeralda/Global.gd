extends Node
var jugador_aspecto: String = "chico"
var jugador_nombre: String = "Mike"
var jugador_posX: float = 0
var jugador_posY: float = 0
var volviendo_de_biblioteca: bool = false
var volviendo_de_ayuntamiento: bool = false
var volviendo_de_banco: bool = false
var puntuacion_total_jugador: int = 0
var llave_purpura_obtenida: bool = false
var llave_verde_obtenida: bool = false
var llave_dorada_obtenida: bool = false
var llave_plateada_obtenida: bool = false
var llave_final_obtenida: bool = false
var misiones_principales_completadas: bool = false
var mision_final_completada: bool = false
var volumen: float = 0.4
var idioma: String = ""

const RUTA_PARTIDA = "user://partida.json"
const RUTA_AJUSTES = "user://configuracion.cfg"

func _ready() -> void:
	# Inicializa los archivos con valores por defecto si no existen
	_crear_archivos_si_no_existen()

func _crear_archivos_si_no_existen() -> void:
	
	# Inicializar ajustes por defecto
	if not FileAccess.file_exists(RUTA_AJUSTES):
		var config = ConfigFile.new()
		config.set_value("ajustes", "volumen", 0.7)
		config.set_value("ajustes", "idioma", "es")
		config.set_value("ajustes", "jugador_aspecto", "chico")
		config.set_value("ajustes", "jugador_nombre", "Mike")
		config.save(RUTA_AJUSTES)

func _guardar_json(ruta: String, datos: Variant) -> void:
	var archivo = FileAccess.open(ruta, FileAccess.WRITE)
	if archivo:
		archivo.store_string(JSON.stringify(datos))
		archivo.close()

func _cargar_json(ruta: String) -> Variant:
	if not FileAccess.file_exists(ruta):
		return null
	var archivo = FileAccess.open(ruta, FileAccess.READ)
	if archivo:
		var contenido = archivo.get_as_text()
		archivo.close()
		var json = JSON.new()
		if json.parse(contenido) == OK:
			return json.get_data()
	return null

func hay_partida_guardada() -> bool:
	return FileAccess.file_exists(RUTA_PARTIDA)

func guardar_partida() -> void:
	var ruta_escena = get_tree().current_scene.scene_file_path
	var uid_escena = str(ResourceLoader.get_resource_uid(ruta_escena))
	
	var datos_partida = {
		"llave_verde_conseguida": 1 if Global.llave_verde_obtenida else 0,
		"llave_purpura_conseguida": 1 if Global.llave_purpura_obtenida else 0,
		"llave_plateada_conseguida": 1 if Global.llave_plateada_obtenida else 0,
		"llave_dorada_conseguida": 1 if Global.llave_dorada_obtenida else 0,
		"llave_final_conseguida": 1 if Global.llave_final_obtenida else 0,
		"escena_actual": uid_escena,
		"pos_x": Global.jugador_posX,
		"pos_y": Global.jugador_posY
	}
	
	_guardar_json(RUTA_PARTIDA, datos_partida)

func obtener_datos_ultima_partida() -> Array:
	var datos = _cargar_json(RUTA_PARTIDA)
	if datos:
		return [datos] # Devolvemos un Array para mantener compatibilidad con tu código original
	return []

func guardar_ajustes() -> void:
	var config = ConfigFile.new()
	# Cargamos el archivo existente para no borrar otras posibles secciones
	if FileAccess.file_exists(RUTA_AJUSTES):
		config.load(RUTA_AJUSTES)
		
	config.set_value("ajustes", "volumen", Global.volumen)
	config.set_value("ajustes", "idioma", str(Global.idioma))
	config.set_value("ajustes", "jugador_aspecto", str(Global.jugador_aspecto))
	config.set_value("ajustes", "jugador_nombre", str(Global.jugador_nombre))
	config.save(RUTA_AJUSTES)

func obtener_datos_ajustes() -> Array:
	var config = ConfigFile.new()
	var error = config.load(RUTA_AJUSTES)
	if error == OK:
		var datos = {
			"volumen": config.get_value("ajustes", "volumen", 0.7),
			"idioma": config.get_value("ajustes", "idioma", "es"),
			"jugador_aspecto": config.get_value("ajustes", "jugador_aspecto", "chico"),
			"jugador_nombre": config.get_value("ajustes", "jugador_nombre", "Mike")
		}
		print([datos])
		return [datos] # Mantiene el formato de Array que esperaba tu lógica
	return []
