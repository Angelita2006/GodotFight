extends RigidBody2D

var dialogo_actual = 0

func _ready() -> void:
	if (Global.jugador_aspecto == "chico"):
		$Dialogo.text = "Bienvenido al ayuntamiento, "+str(Global.jugador_nombre)
	elif (Global.jugador_aspecto == "chica"):
		$Dialogo.text = "Bienvenida al ayuntamiento, "+str(Global.jugador_nombre)
	dialogo_actual = 1

func _process(_delta: float) -> void:
	if dialogo_actual == 2 and Input.is_action_just_pressed("aceptar"):
		entrar_nivel()

func cambiar_dialogo():
	$Dialogo.show()
	$Fondo_dialogo.show()
	if Global.llave_final_obtenida:
		$Dialogo.text = "Gracias por salvar nuestra Aldea Esmeralda, "+str(Global.jugador_nombre)
		dialogo_actual = 3
	else:
		$Dialogo.text = "Buenas, "+str(Global.jugador_nombre)+", el mercado está destrozado, tienes que ayudarnos\n(Sí) Pulsa E"
		dialogo_actual = 2

func _on_abajo_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("quieto_abajo")
		cambiar_dialogo()

func _on_arriba_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("quieto_arriba")
		cambiar_dialogo()

func _on_izquierda_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("quieto_izquierda")
		cambiar_dialogo()

func _on_derecha_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("quieto_derecha")
		cambiar_dialogo()

func _on_presidente_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Dialogo.hide()
		$Fondo_dialogo.hide()

func entrar_nivel():
	Database.guardar_partida()
	# ir al nivel-final
	Cargador.cargar_escena("uid://cws4x5uu4r10r", false)
