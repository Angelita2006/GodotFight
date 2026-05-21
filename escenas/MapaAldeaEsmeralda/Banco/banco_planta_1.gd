extends StaticBody2D


func _ready() -> void:
	if Global.volviendo_de_banco:
		$PersonajePrincipal.position.x = 527
		$PersonajePrincipal.position.y = 312
		Global.volviendo_de_banco = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_salida_body_entered(_body: CharacterBody2D) -> void:
	Global.volviendo_de_banco = true
	# ir al mapa
	get_tree().change_scene_to_file("uid://c61j2kork7ar5")
	
