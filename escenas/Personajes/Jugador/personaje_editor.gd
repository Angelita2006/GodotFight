extends CharacterBody2D

@export var animacion_chico : AnimatedSprite2D
@export var animacion_chica : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion_chico.play("quieto_abajo")
	animacion_chica.play("quieto_abajo")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
