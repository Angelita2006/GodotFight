extends Node2D

func _ready() -> void:
	if Global.llave_plateada_obtenida:
		$Glitch1.hide()
		$Glitch2.hide()
		$Glitch3.hide()
		$Glitch4.hide()
		$ColisionGlitch.hide()

func _process(_delta: float) -> void:
	pass
