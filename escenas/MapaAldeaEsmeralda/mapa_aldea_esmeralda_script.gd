extends Node2D

@export var menu_pausa: Control

func cargar_datos_partida():
	
	if !Global.hay_partida_guardada():
		return

	var fila = Global.obtener_datos_ultima_partida()
	
	if fila:
		if fila[0]["pos_x"] != 0:
			$PersonajePrincipal.global_position.x = fila[0]["pos_x"]
			$PersonajePrincipal.global_position.y = fila[0]["pos_y"]
		if fila[0]["llave_verde_conseguida"] == 0:
			Global.llave_verde_obtenida = false
		elif fila[0]["llave_verde_conseguida"] == 1:
			Global.llave_verde_obtenida = true
		
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
	
	if Global.misiones_principales_completadas == true:
		$PersonajePrincipal/Camera2D/TextoMision4.hide()
		$PersonajePrincipal/Camera2D/Mision4Completa.hide()
		$PersonajePrincipal/Camera2D/Mision4NoCompleta.hide()
		$PersonajePrincipal/Camera2D/Mision4.hide()
		$PersonajePrincipal/Camera2D/TextoMision3.hide()
		$PersonajePrincipal/Camera2D/Mision3Completa.hide()
		$PersonajePrincipal/Camera2D/Mision3NoCompleta.hide()
		$PersonajePrincipal/Camera2D/Mision3.hide()
		$PersonajePrincipal/Camera2D/TextoMision2.hide()
		$PersonajePrincipal/Camera2D/Mision2Completa.hide()
		$PersonajePrincipal/Camera2D/Mision2NoCompleta.hide()
		$PersonajePrincipal/Camera2D/Mision2.hide()
		$PersonajePrincipal/Camera2D/TextoMision1.hide()
		$PersonajePrincipal/Camera2D/Mision1Completa.hide()
		$PersonajePrincipal/Camera2D/Mision1NoCompleta.hide()
		$PersonajePrincipal/Camera2D/TextoMision5.show()
		$PersonajePrincipal/Camera2D/Mision5NoCompleta.show()
		$PersonajePrincipal/Camera2D/TextoMisionPrincipal.hide()
		$PersonajePrincipal/Camera2D/TextoMisionPrincipal2.show()
	elif Global.mision_final_completada == true:
		$PersonajePrincipal/Camera2D/TextoMision4.hide()
		$PersonajePrincipal/Camera2D/Mision4Completa.hide()
		$PersonajePrincipal/Camera2D/Mision4NoCompleta.hide()
		$PersonajePrincipal/Camera2D/Mision4.hide()
		$PersonajePrincipal/Camera2D/TextoMision3.hide()
		$PersonajePrincipal/Camera2D/Mision3Completa.hide()
		$PersonajePrincipal/Camera2D/Mision3NoCompleta.hide()
		$PersonajePrincipal/Camera2D/Mision3.hide()
		$PersonajePrincipal/Camera2D/TextoMision2.hide()
		$PersonajePrincipal/Camera2D/Mision2Completa.hide()
		$PersonajePrincipal/Camera2D/Mision2NoCompleta.hide()
		$PersonajePrincipal/Camera2D/Mision2.hide()
		$PersonajePrincipal/Camera2D/TextoMision1.hide()
		$PersonajePrincipal/Camera2D/Mision1Completa.hide()
		$PersonajePrincipal/Camera2D/Mision1NoCompleta.hide()
		$PersonajePrincipal/Camera2D/TextoMision5.show()
		$PersonajePrincipal/Camera2D/Mision5NoCompleta.hide()
		$PersonajePrincipal/Camera2D/Mision5Completa.show()
		$PersonajePrincipal/Camera2D/TextoMisionPrincipal.hide()
		$PersonajePrincipal/Camera2D/TextoMisionPrincipal2.show()
	
	$AnimationPlayer.play("fade_in")
	
	if Global.volviendo_de_biblioteca:
		$PersonajePrincipal.global_position = $Biblioteca/Puerta/Area.global_position
		$PersonajePrincipal.global_position.y += 30
		Global.volviendo_de_biblioteca = false
		
	elif Global.volviendo_de_ayuntamiento:
		$PersonajePrincipal.global_position = $Ayuntamiento/Puerta/Area.global_position
		$PersonajePrincipal.global_position.y += 30
		Global.volviendo_de_ayuntamiento = false
	
	elif Global.volviendo_de_banco:
		$PersonajePrincipal.global_position = $Banco/Puerta/Area.global_position
		$PersonajePrincipal.global_position.y += 35
		Global.volviendo_de_banco = false
	
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
	
	if Global.misiones_principales_completadas == true:
		$PersonajePrincipal/Camera2D/TextoMision4.hide()
		$PersonajePrincipal/Camera2D/Mision4Completa.hide()
		$PersonajePrincipal/Camera2D/Mision4.hide()
		$PersonajePrincipal/Camera2D/TextoMision3.hide()
		$PersonajePrincipal/Camera2D/Mision3Completa.hide()
		$PersonajePrincipal/Camera2D/Mision3.hide()
		$PersonajePrincipal/Camera2D/TextoMision2.hide()
		$PersonajePrincipal/Camera2D/Mision2Completa.hide()
		$PersonajePrincipal/Camera2D/Mision2.hide()
		$PersonajePrincipal/Camera2D/TextoMision1.hide()
		$PersonajePrincipal/Camera2D/Mision1Completa.hide()
	else:
		$PersonajePrincipal/Camera2D/Mision5NoCompleta.hide()
		
		if Global.llave_verde_obtenida:
			$PersonajePrincipal/Camera2D/Mision1NoCompleta.hide()
			$PersonajePrincipal/Camera2D/Mision1Completa.show()
		
		if Global.llave_purpura_obtenida:
			$PersonajePrincipal/Camera2D/Mision2NoCompleta.hide()
			$PersonajePrincipal/Camera2D/Mision2Completa.show()
		
		if Global.llave_plateada_obtenida:
			$PersonajePrincipal/Camera2D/Mision3NoCompleta.hide()
			$PersonajePrincipal/Camera2D/Mision3Completa.show()
		
		if Global.llave_dorada_obtenida:
			$PersonajePrincipal/Camera2D/Mision4NoCompleta.hide()
			$PersonajePrincipal/Camera2D/Mision4Completa.show()
		
		if Global.llave_dorada_obtenida and Global.llave_plateada_obtenida and Global.llave_purpura_obtenida and Global.llave_verde_obtenida:
			await get_tree().create_timer(1).timeout
			$PersonajePrincipal/Camera2D/TextoMision4.hide()
			$PersonajePrincipal/Camera2D/Mision4Completa.hide()
			$PersonajePrincipal/Camera2D/Mision4NoCompleta.hide()
			$PersonajePrincipal/Camera2D/Mision4.hide()
			$PersonajePrincipal/Camera2D/TextoMision3.hide()
			$PersonajePrincipal/Camera2D/Mision3Completa.hide()
			$PersonajePrincipal/Camera2D/Mision3NoCompleta.hide()
			$PersonajePrincipal/Camera2D/Mision3.hide()
			$PersonajePrincipal/Camera2D/TextoMision2.hide()
			$PersonajePrincipal/Camera2D/Mision2Completa.hide()
			$PersonajePrincipal/Camera2D/Mision2NoCompleta.hide()
			$PersonajePrincipal/Camera2D/Mision2.hide()
			$PersonajePrincipal/Camera2D/TextoMision1.hide()
			$PersonajePrincipal/Camera2D/Mision1Completa.hide()
			$PersonajePrincipal/Camera2D/Mision1NoCompleta.hide()
			
			$PersonajePrincipal/Camera2D/TextoMision5.show()
			$PersonajePrincipal/Camera2D/Mision5NoCompleta.show()
			$PersonajePrincipal/Camera2D/TextoMisionPrincipal.hide()
			$PersonajePrincipal/Camera2D/TextoMisionPrincipal2.show()
			Global.misiones_principales_completadas = true
	
	if Global.mision_final_completada == true:
		#return
		$PersonajePrincipal/Camera2D/MisionPrincipal.hide()
		$PersonajePrincipal/Camera2D/Mision1.hide()
		$PersonajePrincipal/Camera2D/Mision2.hide()
		$PersonajePrincipal/Camera2D/Mision1Completa.hide()
		$PersonajePrincipal/Camera2D/Mision5Completa.hide()
		
		$PersonajePrincipal/Camera2D/TextoMision5.hide()
		$PersonajePrincipal/Camera2D/Mision5NoCompleta.hide()
		$PersonajePrincipal/Camera2D/TextoMisionPrincipal2.hide()
	else:
		if Global.llave_final_obtenida:
			$PersonajePrincipal/Camera2D/Mision5NoCompleta.hide()
			$PersonajePrincipal/Camera2D/Mision5Completa.show()
			Global.mision_final_completada = true

func _on_menu_pausa_hidden() -> void:
	$PersonajePrincipal/Camera2D.enabled = true
