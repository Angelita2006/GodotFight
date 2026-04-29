extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_animacion_animation_finished(source: AnimatedSprite2D) -> void:
	if source.animation == "abrir" and source.animation_finished:
		Global.volviendo_de_ayuntamiento = true
		source.play("cerrar")
		if source.animation_finished:
			source.stop()
		Global.volviendo_de_ayuntamiento = false
		get_tree().change_scene_to_file("res://escenas/MapaAldeaEsmeralda/ayuntamiento/ayuntamiento_planta1.tscn")
