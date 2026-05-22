extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.jugador_aspecto == "chico":
		$ChicoBoton.button_pressed = true
	elif Global.jugador_aspecto == "chica":
		$ChicaBoton.button_pressed = true
	
	if Global.jugador_nombre != "":
		$NombreEditor.text = Global.jugador_nombre

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
