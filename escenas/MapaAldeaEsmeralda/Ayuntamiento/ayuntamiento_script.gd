extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.llave_final_obtenida:
		$Glitch1.hide()
		$Glitch2.hide()
		$Glitch3.hide()
		$Glitch4.hide()
		$Glitch5.hide()
		$Presidente.hide()

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
		# ir a la planta 1 del ayuntamiento
		get_tree().change_scene_to_file("uid://cyr5170lqj6c3")
