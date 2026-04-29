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
	get_tree().change_scene_to_file("res://escenas/MapaAldeaEsmeralda/ayuntamiento/ayuntamiento_planta1.tscn")
	
func _on_subida_body_entered(body: CharacterBody2D) -> void:
	Global.volviendo_de_ayuntamiento = true
	get_tree().change_scene_to_file("res://escenas/MapaAldeaEsmeralda/ayuntamiento/ayuntamiento_planta3.tscn")
