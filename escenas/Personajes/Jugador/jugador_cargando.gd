extends CharacterBody2D

@export var animacion_chico : AnimatedSprite2D
@export var animacion_chica : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.jugador_aspecto == "chica":
		
		animacion_chico.hide()
		animacion_chica.show()
		
		animacion_chica.play("correr_derecha_chica")
		
	elif Global.jugador_aspecto == "chico":
		
		animacion_chico.show()
		animacion_chica.hide()
		
		animacion_chico.play("correr_derecha_chico")
