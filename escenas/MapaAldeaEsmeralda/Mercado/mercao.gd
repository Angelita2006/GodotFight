extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.llave_plateada_obtenida:
		$Glitch1.hide()
		$Glitch2.hide()
		$Glitch3.hide()
		$Glitch4.hide()
		$ColisionGlitch.hide()
