extends RigidBody2D

var dialogo_actual = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (Global.jugador_aspecto == "chico"):
		$Dialogo.text = "Bienvenido al banco, "+str(Global.jugador_nombre)
	elif (Global.jugador_aspecto == "chica"):
		$Dialogo.text = "Bienvenida al banco, "+str(Global.jugador_nombre)
	dialogo_actual = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func cambiar_dialogo():
	$Dialogo.show()
	$Fondo_dialogo.show()
	$Dialogo.text = "Buenas, "+str(Global.jugador_nombre)+", el banco han quedado desolado, hay que recuperar los billetes perdidos\n(Sí) Pulsa E"
	dialogo_actual = 2
	if Input.is_action_pressed("aceptar"):
		Database.abrir_db()
		Database.crear_tabla_si_no_existe()
		Database.db.query("DELETE FROM partida")
		Database.db.query("INSERT INTO partida (pos_x,pos_y) VALUES ("+str(Global.jugador_posX)+","+str(Global.jugador_posY)+")")
		Database.cerrar_db()
		Cargador.cargar_escena("res://escenas/Niveles/tutorial.tscn")

func _on_abajo_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Banquero_abajo")
	cambiar_dialogo()

func _on_arriba_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Banquero_arriba")
	cambiar_dialogo()

func _on_izquierda_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Banquero_izquierda")
	cambiar_dialogo()

func _on_derecha_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Banquero_derecha")
	cambiar_dialogo()

func _on_banquero_body_exited(body: CharacterBody2D) -> void:
	$Dialogo.hide()
	$Fondo_dialogo.hide()
