extends RigidBody2D

var dialogo_actual = 0

func _ready() -> void:
	if (Global.jugador_aspecto == "chico"):
		$Dialogo.text = "Bienvenido a la biblioteca, "+str(Global.jugador_nombre)
	elif (Global.jugador_aspecto == "chica"):
		$Dialogo.text = "Bienvenida a la biblioteca, "+str(Global.jugador_nombre)
	dialogo_actual = 1

func _process(_delta: float) -> void:
	if dialogo_actual == 2 and Input.is_action_just_pressed("aceptar"):
		entrar_nivel()

func cambiar_dialogo():
	$Dialogo.show()
	$Fondo_dialogo.show()
		#$Dialogo.text = "Gracias por ayudar a preservar el conocimento que otorga nuestra biblioteca, vuelve cuando quieras "+str(Global.jugador_nombre)
	$Dialogo.text = "Buenas, "+str(Global.jugador_nombre)+", las estanterías han quedado en ruinas, hay que recuperar los libros\n(Sí) Pulsa E"
	dialogo_actual = 2

func _on_abajo_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Bibliotecaria_abajo")
		cambiar_dialogo()

func _on_bibliotecaria_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Dialogo.hide()
		$Fondo_dialogo.hide()

func _on_arriba_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Bibliotecaria_arriba")
		cambiar_dialogo()

func _on_izquierda_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Bibliotecaria_izquierda")
		cambiar_dialogo()

func _on_derecha_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("Bibliotecaria_derecha")
		cambiar_dialogo()

func entrar_nivel():
	Database.abrir_db()
	Database.crear_tabla_si_no_existe()
	Database.db.query("DELETE FROM partida")
	Database.db.query("INSERT INTO partida (pos_x,pos_y) VALUES ("+str(Global.jugador_posX)+","+str(Global.jugador_posY)+")")
	Database.cerrar_db()
	# ir al nivel-biblioteca
	Cargador.cargar_escena("uid://c725xxgdnccq1", false)
