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
		
		var audio_fantasma = $Audio.duplicate()
		get_tree().root.add_child.call_deferred(audio_fantasma)
		
		# CONECTAMOS EL PLAY: Se reproducirá automáticamente en cuanto el nodo entre al juego
		audio_fantasma.ready.connect(func(): audio_fantasma.play())
		
		audio_fantasma.finished.connect(func(): audio_fantasma.queue_free())
		$Colision.set_deferred("disabled", true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Animacion.play("cerrar")
		
		var audio_fantasma = $Audio.duplicate()
		get_tree().root.add_child.call_deferred(audio_fantasma)
		
		# CONECTAMOS EL PLAY: Evita el error de la línea 46 esperando a que esté dentro del árbol
		audio_fantasma.ready.connect(func(): audio_fantasma.play())
		
		audio_fantasma.finished.connect(func(): audio_fantasma.queue_free())
		$Colision.set_deferred("disabled", true)
