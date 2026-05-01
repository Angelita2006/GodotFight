extends RigidBody2D

var dialogo_actual = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (Global.jugador_aspecto == "chico"):
		$Dialogo.text = "Bienvenido a la biblioteca, "+str(Global.jugador_nombre)
	elif (Global.jugador_aspecto == "chica"):
		$Dialogo.text = "Bienvenida a la biblioteca, "+str(Global.jugador_nombre)
	dialogo_actual = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dialogo_actual == 2 and Input.is_action_pressed("aceptar"):
		Cargador.cargar_escena("res://escenas/Niveles/tutorial.tscn")
	elif dialogo_actual == 2 and Input.is_action_pressed("rechazar"):
		$Dialogo.text = "Vale, nos vemos luego "+str(Global.jugador_nombre)
		dialogo_actual = 3

func _on_abajo_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Bibliotecaria_abajo")
	cambiar_dialogo()

func _on_arriba_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Bibliotecaria_arriba")
	cambiar_dialogo()

func _on_izquierda_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Bibliotecaria_izquierda")
	cambiar_dialogo()

func _on_derecha_body_entered(body: CharacterBody2D) -> void:
	$Animacion.play("Bibliotecaria_derecha")
	cambiar_dialogo()

func cambiar_dialogo():
	$Dialogo.show()
	$Fondo_dialogo.show()
	if Global.llave_purpura_obtenida:
		this.hide()
		$Dialogo.text = "Gracias por ayudar a preservar el conocimento que otorga nuestra biblioteca, vuelve cuando quieras "+str(Global.jugador_nombre)
	else:
		$Dialogo.text = "Buenas, "+str(Global.jugador_nombre)+", las estanterías han quedado en ruinas, hay que recuperar los libros\n(Sí) Pulsa E (No) Pulsa Q"
		dialogo_actual = 2
		#if Input.is_action_pressed("aceptar"):
			#Cargador.cargar_escena("res://escenas/Niveles/tutorial.tscn")
		#elif Input.is_action_pressed("rechazar"):
			#$Dialogo.text = "Vale, nos vemos luego "+str(Global.jugador_nombre)


func _on_bibliotecaria_body_exited(body: CharacterBody2D) -> void:
	$Dialogo.hide()
	$Fondo_dialogo.hide()
