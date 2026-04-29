extends Node2D

@export var menu_pausa: Control

func cargar_posicion():

	Database.abrir_db()
	
	Database.crear_tabla_si_no_existe()
	
	# Si no hay partida guardada
	if !Database.hay_partida_guardada():
		return

	var fila = Database.obtener_datos_ultima_partida()
	print(fila)
	
	$PersonajePrincipal.global_position.x = fila[0]["pos_x"]
	$PersonajePrincipal.global_position.y = fila[0]["pos_y"]
	Database.cerrar_db()

func _ready() -> void:
	$AnimationPlayer.play("fade_in")
	
	if Global.volviendo_de_biblioteca:
		$PersonajePrincipal.global_position = $Biblioteca/Puerta/Area.global_position
		$PersonajePrincipal.global_position.y += 25
		Global.volviendo_de_biblioteca = false
		
	elif Global.volviendo_de_ayuntamiento:
		$PersonajePrincipal.global_position = $Ayuntamiento/Puerta/Area.global_position
		$PersonajePrincipal.global_position.y += 25
		Global.volviendo_de_ayuntamiento = false
	
	else:
		cargar_posicion()

	var poly = $Limites/Colisiones.polygon

	var min_x = INF
	var max_x = -INF
	var min_y = INF
	var max_y = -INF

	# Convertir puntos locales a globales
	for p in poly:
		var gp = $Limites/Colisiones.to_global(p)
		min_x = min(min_x, gp.x)
		max_x = max(max_x, gp.x)
		min_y = min(min_y, gp.y)
		max_y = max(max_y, gp.y)

	# Aplicar límites a la cámara
	var cam = $PersonajePrincipal/Camera2D
	cam.limit_left = min_x
	cam.limit_top = min_y
	cam.limit_right = max_x
	cam.limit_bottom = max_y

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pausar"):
		menu_pausa.show()
		$"PersonajePrincipal/Camera2D/Fondo Pausa".show()

	if Global.volviendo_de_biblioteca:
		$PersonajePrincipal.hide()

func _on_menu_pausa_hidden() -> void:
	$"PersonajePrincipal/Camera2D/Fondo Pausa".hide()
