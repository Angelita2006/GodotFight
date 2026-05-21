extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.volviendo_de_ayuntamiento:
		$PersonajePrincipal.position.x = 757
		$PersonajePrincipal.position.y = 360
		Global.volviendo_de_ayuntamiento = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bajada_body_entered(body: CharacterBody2D) -> void:
	Global.volviendo_de_ayuntamiento = true
	# ir a la planta 1 del ayuntamiento
	get_tree().change_scene_to_file("uid://cyr5170lqj6c3")
	
func _on_subida_body_entered(body: CharacterBody2D) -> void:
	Global.volviendo_de_ayuntamiento = true
	# ir a la planta 3 del ayuntamiento
	get_tree().change_scene_to_file("uid://bh3tp261kottk")
