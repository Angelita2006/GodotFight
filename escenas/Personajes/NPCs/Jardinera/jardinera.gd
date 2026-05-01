extends RigidBody2D

var dialogo_actual = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (Global.jugador_aspecto == "chico"):
		$Dialogo.text = "Bienvenido al parque, "+str(Global.jugador_nombre)
	elif (Global.jugador_aspecto == "chica"):
		$Dialogo.text = "Bienvenida al parque, "+str(Global.jugador_nombre)
	dialogo_actual = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dialogo_actual == 2 and Input.is_action_pressed("aceptar"):
		Database.abrir_db()
		Database.crear_tabla_si_no_existe()
		Database.db.query("DELETE FROM partida")
		Database.db.query("INSERT INTO partida (pos_x,pos_y) VALUES ("+str(Global.jugador_posX)+","+str(Global.jugador_posY)+")")
		Database.cerrar_db()
		Cargador.cargar_escena("res://escenas/Niveles/tutorial.tscn")
	elif dialogo_actual == 2 and Input.is_action_pressed("rechazar"):
		$Dialogo.text = "Vale, nos vemos luego jugador "+str(Global.jugador_nombre)
		dialogo_actual = 3

func _on_abajo_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Jardinera_abajo")
	cambiar_dialogo()

func _on_arriba_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Jardinera_arriba")
	cambiar_dialogo()

func _on_derecha_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Jardinera_derecha")
	cambiar_dialogo()

func _on_izquierda_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Jardinera_izquierda")
	cambiar_dialogo()

func cambiar_dialogo():
	$Dialogo.show()
	$Fondo_dialogo.show()
	if Global.llave_verde_obtenida:
		position.x = 173.642
		position.y = 44.207
		$Dialogo.text = "Gracias por habernos ayudado, te estaremos agradecidos siempre "+str(Global.jugador_nombre)
	else:
		position.x = 212.285
		position.y = 98.79
		$Dialogo.text = "Buenas, "+str(Global.jugador_nombre)+", el parque está horrible, tienes que arreglarlo\n(Sí) Pulsa E (No) Pulsa Q"
		dialogo_actual = 2
		if Input.is_action_pressed("aceptar"):
			Cargador.cargar_escena("res://escenas/Niveles/tutorial.tscn")
		elif Input.is_action_pressed("rechazar"):
			$Dialogo.text = "Vale, nos vemos luego jugador "+str(Global.jugador_nombre)

func _on_jardinera_body_exited(body: Node2D) -> void:
	$Dialogo.hide()
	$Fondo_dialogo.hide()
