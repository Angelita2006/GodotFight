extends RigidBody2D

var dialogo_actual = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (Global.jugador_aspecto == "chico"):
		$Dialogo.text = "Bienvenido al mercado, "+str(Global.jugador_nombre)
	elif (Global.jugador_aspecto == "chica"):
		$Dialogo.text = "Bienvenida al mercado, "+str(Global.jugador_nombre)
	dialogo_actual = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func cambiar_dialogo():
	$Dialogo.show()
	$Fondo_dialogo.show()
	if Global.llave_verde_obtenida:
		position.x = 1540
		position.y = 1690
		$Dialogo.text = "Gracias por habernos ayudado, te estaremos agradecidos siempre "+str(Global.jugador_nombre)
		dialogo_actual = 3
	else:
		position.x = 1130
		position.y = 1635
		$Dialogo.text = "Buenas, "+str(Global.jugador_nombre)+", el mercado está destrozado, tienes que ayudarnos\n(Sí) Pulsa E"
		dialogo_actual = 2
		if Input.is_action_pressed("aceptar"):
			Database.abrir_db()
			Database.crear_tabla_si_no_existe()
			Database.db.query("DELETE FROM partida")
			Database.db.query("INSERT INTO partida (pos_x,pos_y) VALUES ("+str(Global.jugador_posX)+","+str(Global.jugador_posY)+")")
			Database.cerrar_db()
			Cargador.cargar_escena("res://escenas/Niveles/tutorial.tscn")

func _on_abajo_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Vendedor_abajo")
	cambiar_dialogo()

func _on_arriba_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Vendedor_arriba")
	cambiar_dialogo()

func _on_izquierda_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Vendedor_izquierda")
	cambiar_dialogo()

func _on_derecha_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Vendedor_derecha")
	cambiar_dialogo()

func _on_vendedor_body_exited(body: CharacterBody2D) -> void:
	$Dialogo.hide()
	$Fondo_dialogo.hide()
