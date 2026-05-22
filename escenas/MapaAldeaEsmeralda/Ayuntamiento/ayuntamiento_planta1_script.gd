extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.volviendo_de_ayuntamiento:
		$PersonajePrincipal.position.x = 526
		$PersonajePrincipal.position.y = 363
		Global.volviendo_de_ayuntamiento = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_salida_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		Global.volviendo_de_ayuntamiento = true
		# ir al mapa
		get_tree().call_deferred("change_scene_to_file", "uid://c61j2kork7ar5")
	
func _on_subida_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		# ir a la planta 2 del ayuntamiento
		get_tree().call_deferred("change_scene_to_file", "uid://6lv3w0jcibyk")
