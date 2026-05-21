extends RigidBody2D

var dialogo_actual = 0

func _ready() -> void:
	if (Global.jugador_aspecto == "chico"):
		$Dialogo.text = "Bienvenido al parque, "+str(Global.jugador_nombre)
	elif (Global.jugador_aspecto == "chica"):
		$Dialogo.text = "Bienvenida al parque, "+str(Global.jugador_nombre)
	dialogo_actual = 1

func _process(_delta: float) -> void:
	if dialogo_actual == 2 and Input.is_action_just_pressed("aceptar"):
		entrar_nivel()

func cambiar_dialogo():
	$Dialogo.show()
	$Fondo_dialogo.show()
	if Global.llave_verde_obtenida:
		$Dialogo.text = "Gracias por habernos ayudado, te estaremos agradecidos siempre "+str(Global.jugador_nombre)
		dialogo_actual = 3
	else:
		$Dialogo.text = "Buenas, "+str(Global.jugador_nombre)+", el parque está horrible, tienes que arreglarlo\n(Sí) Pulsa E"
		dialogo_actual = 2

func _on_abajo_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Jardinera_abajo")
		cambiar_dialogo()

func _on_arriba_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Jardinera_arriba")
		cambiar_dialogo()

func _on_derecha_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Jardinera_derecha")
		cambiar_dialogo()

func _on_izquierda_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Jardinera_izquierda")
		cambiar_dialogo()

func _on_jardinera_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Dialogo.hide()
		$Fondo_dialogo.hide()
	
func entrar_nivel():
	Database.guardar_partida()
	# ir al nivel-parque
	Cargador.cargar_escena("uid://b8i0qhu37u1ep", false)
