extends StaticBody2D

var quitar_glitch = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fila = Database.obtener_datos_ultima_partida()
	if fila:
		if fila[0]["llave_dorada_conseguida"] == 0:
			quitar_glitch = false
		elif fila[0]["llave_dorada_conseguida"] == 1:
			quitar_glitch = true
	if quitar_glitch:
		$Glitch.hide()
		$Banquero.hide()
		$Banquero/Colisiones.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_animacion_animation_finished(source: AnimatedSprite2D) -> void:
	if source.animation == "abrir" and source.animation_finished:
		Global.volviendo_de_banco = true
		source.play("cerrar")
		if source.animation_finished:
			source.stop()
		Global.volviendo_de_banco = false
		# ir a la planta 1 del banco
		get_tree().change_scene_to_file("uid://bjch24811gc2f")
