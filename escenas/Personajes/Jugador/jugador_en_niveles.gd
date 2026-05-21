extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -1000.0

enum State { Quieto, Corriendo, Saltando, Callendo }
var current_state: State

func _physics_process(delta: float) -> void:
	player_gravity(delta)
	player_jump()
	player_run()
	
	animacion_personaje()
	move_and_slide()
	
func player_gravity(delta) -> void:
	if not is_on_floor():
		var gravity = get_gravity() * 2
		velocity += gravity * delta
		
		if velocity.y > 0:
			current_state = State.Callendo

func player_jump() -> void:
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		current_state = State.Saltando

func player_run() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			current_state = State.Corriendo
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			current_state = State.Quieto
	
	if direction != 0:
		$AnimatedSprite2D.flip_h = direction < 0

func animacion_personaje() -> void:
	if current_state == State.Quieto:
		$AnimatedSprite2D.play("quieto")
	elif current_state == State.Corriendo:
		$AnimatedSprite2D.play("caminando")
	elif current_state == State.Saltando:
		$AnimatedSprite2D.play("saltando")
	elif current_state == State.Callendo:
		$AnimatedSprite2D.play("callendo")
