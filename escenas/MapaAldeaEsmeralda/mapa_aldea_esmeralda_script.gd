extends Node2D

@export var menu_pausa: Control

func cargar_datos_partida():
	
	# Si no hay partida guardada
	if !Database.hay_partida_guardada():
		return

	var fila = Database.obtener_datos_ultima_partida()
	
	$PersonajePrincipal.global_position.x = fila[0]["pos_x"]
	$PersonajePrincipal.global_position.y = fila[0]["pos_y"]
	if fila[0]["llave_verde_conseguida"] == 0:
		Global.llave_verde_obtenida = false
	elif fila[0]["llave_verde_conseguida"] == 1:
		Global.llave_verde_obtenida = true
	print(Global.llave_verde_obtenida)
	
	if fila[0]["llave_purpura_conseguida"] == 0:
		Global.llave_purpura_obtenida = false
	elif fila[0]["llave_purpura_conseguida"] == 1:
		Global.llave_purpura_obtenida = true
	
	if fila[0]["llave_plateada_conseguida"] == 0:
		Global.llave_plateada_obtenida = false
	elif fila[0]["llave_plateada_conseguida"] == 1:
		Global.llave_plateada_obtenida = true
	
	if fila[0]["llave_dorada_conseguida"] == 0:
		Global.llave_dorada_obtenida = false
	elif fila[0]["llave_dorada_conseguida"] == 1:
		Global.llave_dorada_obtenida = true
	
	if fila[0]["llave_final_conseguida"] == 0:
		Global.llave_final_obtenida = false
	elif fila[0]["llave_final_conseguida"] == 1:
		Global.llave_final_obtenida = true

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
		cargar_datos_partida()

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
		$PersonajePrincipal/Camera2D.enabled = false
	
	if Global.volviendo_de_biblioteca:
		$PersonajePrincipal.hide()

func _on_menu_pausa_hidden() -> void:
	$PersonajePrincipal/Camera2D.enabled = true
