extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bajada_body_entered(body: CharacterBody2D) -> void:
	Global.volviendo_de_ayuntamiento = true
	get_tree().change_scene_to_file("res://escenas/MapaAldeaEsmeralda/ayuntamiento/ayuntamiento_planta2.tscn")

func _on_subida_body_entered(body: CharacterBody2D) -> void:
	pass # Replace with function body.
