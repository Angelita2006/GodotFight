
extends Area2D

var activado: bool = false
var direccion: String = "derecha"

func _process(_delta: float) -> void:
	if activado and direccion == "derecha":
		rotation_degrees = -90.9
		position.x += 10
		if position.x == -3200.0:
			direccion = "izquierda"
	elif activado and direccion == "izquierda":
		rotation_degrees = -267.7
		position.x -= 10
		if position.x == -4400.0:
			direccion = "derecha"

func _on_activador_pincho_body_entered(_body: Node2D) -> void:
	activado = true
