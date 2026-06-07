extends CharacterBody2D
@export var animacion_chico: AnimatedSprite2D
@export var animacion_chica: AnimatedSprite2D
var _velocidad: float = 100
var ultima_direccion := "abajo"

func _physics_process(_delta):
	if Global.jugador_aspecto == "chico" and $Camera2D.visible == true:
		
		animacion_chica.hide()
		animacion_chico.show()		
		
		if Input.is_action_pressed("correr"):
			_velocidad = 200
			animacion_chico.speed_scale = 1.8
		else:
			_velocidad = 80
			animacion_chico.speed_scale = 1
		
		if Input.is_action_pressed("move_right"):
			velocity.x = _velocidad
			velocity.y = 0
			animacion_chico.play("caminar_derecha_chico")
			ultima_direccion = "derecha"
		elif Input.is_action_pressed("move_left"):
			velocity.x = - _velocidad
			velocity.y = 0
			animacion_chico.play("caminar_izquierda_chico")
			ultima_direccion = "izquierda"
		elif Input.is_action_pressed("move_up"):
			velocity.y = - _velocidad
			velocity.x = 0
			animacion_chico.play("caminar_arriba_chico")
			ultima_direccion = "arriba"
		elif Input.is_action_pressed("move_down"):
			velocity.y = _velocidad
			velocity.x = 0
			animacion_chico.play("caminar_abajo_chico")
			ultima_direccion = "abajo"
		else:
			velocity.x = 0
			velocity.y = 0
			match ultima_direccion:
				"derecha":
					animacion_chico.play("quieto_derecha_chico")
				"izquierda":
					animacion_chico.play("quieto_izquierda_chico")
				"arriba":
					animacion_chico.play("quieto_arriba_chico")
				"abajo":
					animacion_chico.play("quieto_abajo_chico")
					
	elif Global.jugador_aspecto == "chica" and $Camera2D.visible == true:
		
		animacion_chico.hide()
		animacion_chica.show()
		
		if Input.is_action_pressed("correr"):
			_velocidad = 200
			animacion_chica.speed_scale = 1.8
		else:
			_velocidad = 80
			animacion_chica.speed_scale = 1
		
		if Input.is_action_pressed("move_right"):
			velocity.x = _velocidad
			velocity.y = 0
			animacion_chica.play("caminar_derecha_chica")
			ultima_direccion = "derecha"
		elif Input.is_action_pressed("move_left"):
			velocity.x = - _velocidad
			velocity.y = 0
			animacion_chica.play("caminar_izquierda_chica")
			ultima_direccion = "izquierda"
		elif Input.is_action_pressed("move_up"):
			velocity.y = - _velocidad
			velocity.x = 0
			animacion_chica.play("caminar_arriba_chica")
			ultima_direccion = "arriba"
		elif Input.is_action_pressed("move_down"):
			velocity.y = _velocidad
			velocity.x = 0
			animacion_chica.play("caminar_abajo_chica")
			ultima_direccion = "abajo"
		else:
			velocity.x = 0
			velocity.y = 0
			match ultima_direccion:
				"derecha":
					animacion_chica.play("quieto_derecha_chica")
				"izquierda":
					animacion_chica.play("quieto_izquierda_chica")
				"arriba":
					animacion_chica.play("quieto_arriba_chica")
				"abajo":
					animacion_chica.play("quieto_abajo_chica")
	Global.jugador_posX = global_position.x
	Global.jugador_posY = global_position.y
	move_and_slide()
