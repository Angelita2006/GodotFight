extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_abajo_body_entered(body: CharacterBody2D) -> void:
	if Global.llave_verde_obtenida:
		position.x = 173.642
		position.y = 44.207
		$Dialogo.text = "Gracias por habernos ayudado, te estaremos agradecidos siempre "+str(Global.jugador_nombre)
	else:
		position.x = 212.285
		position.y = 98.79
		$Dialogo.text = "Buenas, "+str(Global.jugador_nombre)+", el parque está horrible, tienes que arreglarlo\n(Sí) Pulsa S (No) Pulsa N"
		if Input.is_action_pressed("aceptar"):
			Cargador.cargar_escena("res://escenas/Niveles/tutorial.tscn")
		elif Input.is_action_pressed("rechazar"):
			$Dialogo.text = "Vale, nos vemos luego jugador "+str(Global.jugador_nombre)
