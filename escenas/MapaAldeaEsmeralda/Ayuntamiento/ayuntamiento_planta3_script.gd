extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bajada_body_entered(body: CharacterBody2D) -> void:
	Global.volviendo_de_ayuntamiento = true
	# ir a la planta 2 del ayuntamiento
	get_tree().change_scene_to_file("uid://6lv3w0jcibyk")

func _on_subida_body_entered(body: CharacterBody2D) -> void:
	pass # Replace with function body.
