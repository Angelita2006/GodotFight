extends Node

@onready var menu_carga = preload("res://escenas/Menus/MenuCarga/menu_carga.tscn")

var ruta_escena = ""
var escena_cargada = null
var instancia_escena = null
var cargando = false
var mostrar_menu = true


func cargar_escena(path, mostrar_menu_carga := true):

	if cargando:
		return  # evitar dobles cargas
	
	mostrar_menu = mostrar_menu_carga
	ruta_escena = path
	cargando = true
	
	print("Cargando escena:", path)

	# Mostrar menú de carga
	if mostrar_menu:
		instancia_escena = menu_carga.instantiate()
		get_tree().root.add_child(instancia_escena)

	# Iniciar carga en hilo
	var err = ResourceLoader.load_threaded_request(path)
	if err != OK:
		push_error("Error al iniciar carga: " + str(err))
		cargando = false
		return


func _process(_delta):

	if not cargando:
		return
	
	var progreso = []
	var estado = ResourceLoader.load_threaded_get_status(ruta_escena, progreso)

	match estado:

		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if mostrar_menu and progreso.size() > 0:
				if instancia_escena:
					var barra = instancia_escena.get_node_or_null("ProgressBar")
					if barra:
						barra.value = progreso[0] * 100

		ResourceLoader.THREAD_LOAD_LOADED:
			escena_cargada = ResourceLoader.load_threaded_get(ruta_escena)
			cargando = false
			entrar_escena_cargada()

		ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Fallo al cargar la escena")
			cargando = false

func entrar_escena_cargada():
	if not escena_cargada:
		push_error("Escena no válida")
		return
	
	# Cambiar de forma diferida para limpiar colisiones pendientes
	get_tree().call_deferred("change_scene_to_packed", escena_cargada)
	
	# 4. Quitar menú de carga
	if instancia_escena:
		instancia_escena.queue_free()
		instancia_escena = null
