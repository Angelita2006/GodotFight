extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bajada_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		Global.volviendo_de_biblioteca = true
		# ir a la planta 1 de la biblioteca
		get_tree().change_scene_to_file("uid://e8cyhqcwav5e")
