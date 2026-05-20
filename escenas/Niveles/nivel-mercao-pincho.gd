extends Area2D

var activado: bool = false

func _process(_delta: float) -> void:
	if activado:
		position.y += 12


func _on_activador_pincho_body_entered(_body: Node2D) -> void:
	activado = true
