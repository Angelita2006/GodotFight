extends RigidBody2D

var dialogo_actual = 0

func _ready() -> void:
	if (Global.jugador_aspecto == "chico"):
		$Dialogo.text = "Bienvenido al mercado, "+str(Global.jugador_nombre)
	elif (Global.jugador_aspecto == "chica"):
		$Dialogo.text = "Bienvenida al mercado, "+str(Global.jugador_nombre)
	dialogo_actual = 1

func _process(_delta: float) -> void:
	if dialogo_actual == 2 and Input.is_action_just_pressed("aceptar"):
			entrar_nivel()

func cambiar_dialogo():
	$Dialogo.show()
	$Fondo_dialogo.show()
	if Global.llave_plateada_obtenida:
		$Dialogo.text = "Gracias por habernos ayudado, te estaremos agradecidos siempre "+str(Global.jugador_nombre)
		dialogo_actual = 3
	else:
		$Dialogo.text = "Buenas, "+str(Global.jugador_nombre)+", el mercado está destrozado, tienes que ayudarnos\n(Sí) Pulsa E"
		dialogo_actual = 2

func _on_abajo_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Vendedor_abajo")
		cambiar_dialogo()

func _on_arriba_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Vendedor_arriba")
		cambiar_dialogo()

func _on_izquierda_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Vendedor_izquierda")
		cambiar_dialogo()

func _on_derecha_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Vendedor_derecha")
		cambiar_dialogo()

func _on_vendedor_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Dialogo.hide()
		$Fondo_dialogo.hide()

func entrar_nivel():
	Database.abrir_db()
	Database.crear_tabla_si_no_existe()
	Database.db.query("DELETE FROM partida")
	Database.db.query("INSERT INTO partida (pos_x,pos_y) VALUES ("+str(Global.jugador_posX)+","+str(Global.jugador_posY)+")")
	Database.cerrar_db()
	# ir al nivel-mercao
	Cargador.cargar_escena("uid://ut7fnsn5cbc3", false)
