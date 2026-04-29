extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bajada_body_entered(body: CharacterBody2D) -> void:
	Global.volviendo_de_biblioteca = true
	get_tree().change_scene_to_file("res://escenas/MapaAldeaEsmeralda/biblioteca/biblioteca_planta1.tscn")
