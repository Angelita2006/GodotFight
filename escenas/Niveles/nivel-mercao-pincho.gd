extends Area2D

var activado: bool = false

var posXizquierda: float = -4400.0
var posXderecha: float = -3200.0

func _process(_delta: float) -> void:
	if activado and position.x == posXderecha:
		position.x -= 20
	elif activado and position.x == posXizquierda:
		position.x += 20

func _on_activador_pincho_body_entered(_body: Node2D) -> void:
	activado = true
