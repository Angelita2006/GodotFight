extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_2d_body_entered(_body: CharacterBody2D) -> void:
	$Animacion.play("abrir")
	$Audio.play()
	$Colision.disabled = false

func _on_area_2d_body_exited(_body: CharacterBody2D) -> void:
	$Animacion.play("cerrar")
	$Audio.play()
	$Colision.disabled = true
