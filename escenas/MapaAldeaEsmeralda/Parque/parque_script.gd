extends Node2D

var direccion1 = 1
var direccion2 = 1
var direccion3 = 1

var esperando1 = false
var esperando2 = false
var esperando3 = false

var velocidad = 30.0

var quitar_glitch = false

func _ready() -> void:
	var fila = Database.obtener_datos_ultima_partida()
	if fila:
		if fila[0]["llave_verde_conseguida"] == 0:
			quitar_glitch = false
		elif fila[0]["llave_verde_conseguida"] == 1:
			quitar_glitch = true
	if quitar_glitch:
		$Glitch.hide()
	
	$Patito/Animacion.play("quieto_agua_izquierda")
	$Patito2/Animacion.play("quieto_agua_derecha")
	$Patito3/Animacion.play("quieto_derecha")

func _process(delta: float) -> void:
	
	# --- PATITO 1 (de -6 a 40) ---
	if not esperando1:
		$Patito.position.x += direccion1 * velocidad * delta

		if direccion1 == 1:
			$Patito/Animacion.play("nadar_derecha")
			if $Patito.position.x >= 40:
				esperar_y_cambiar_direccion(1)
		else:
			$Patito/Animacion.play("nadar_izquierda")
			if $Patito.position.x <= -6:
				esperar_y_cambiar_direccion(1)

	# --- PATITO 2 (de 70 a 90) ---
	if not esperando2:
		$Patito2.position.x += direccion2 * velocidad * delta

		if direccion2 == 1:
			$Patito2/Animacion.play("nadar_derecha")
			if $Patito2.position.x >= 90:
				esperar_y_cambiar_direccion(2)
		else:
			$Patito2/Animacion.play("nadar_izquierda")
			if $Patito2.position.x <= 70:
				esperar_y_cambiar_direccion(2)

	# --- PATITO 3 (de 140 a 190) ---
	if not esperando3:
		$Patito3.position.x += direccion3 * velocidad * delta

		if direccion3 == 1:
			$Patito3/Animacion.play("caminar_derecha")
			if $Patito3.position.x >= 190:
				esperar_y_cambiar_direccion(3)
		else:
			$Patito3/Animacion.play("caminar_izquierda")
			if $Patito3.position.x <= 140:
				esperar_y_cambiar_direccion(3)

func esperar_y_cambiar_direccion(id):
	match id:
		1:
			esperando1 = true
			$Patito/Animacion.play("quieto_agua_izquierda")
			await get_tree().create_timer(2.0).timeout
			direccion1 *= -1
			esperando1 = false

		2:
			esperando2 = true
			$Patito2/Animacion.play("quieto_agua_derecha")
			await get_tree().create_timer(2.0).timeout
			direccion2 *= -1
			esperando2 = false

		3:
			esperando3 = true
			$Patito3/Animacion.play("quieto_derecha")
			await get_tree().create_timer(2.0).timeout
			direccion3 *= -1
			esperando3 = false

func _on_area_glitch_body_entered(_body: Node2D) -> void:
	if Global.llave_verde_obtenida:
		$Glitch.hide()
		$AreaGlitch/ColisionGlitch.disabled = true
	else:
		$Glitch.show()
		$AreaGlitch/ColisionGlitch.disabled = false
