extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("abrir")
		
		var audio = $Audio.duplicate()
		get_tree().root.add_child.call_deferred(audio)
		
		audio.ready.connect(func(): audio.play())
		
		audio.finished.connect(func(): audio.queue_free())
		$Colision.set_deferred("disabled", true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("cerrar")
		
		var audio = $Audio.duplicate()
		get_tree().root.add_child.call_deferred(audio)
		
		audio.ready.connect(func(): audio.play())
		
		audio.finished.connect(func(): audio.queue_free())
		$Colision.set_deferred("disabled", true)
