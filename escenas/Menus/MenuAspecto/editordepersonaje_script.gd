extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.jugador_aspecto == "chico":
		$ChicoBoton.button_pressed = true
	elif Global.jugador_aspecto == "chica":
		$ChicaBoton.button_pressed = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_guardar_pressed() -> void:
	if $ChicoBoton.button_pressed:
		Global.jugador_aspecto = "chico"
		if $NombreEditor.text != "":
			Global.jugador_nombre = $NombreEditor.text
		else:
			Global.jugador_nombre = "Mike"
	elif $ChicaBoton.button_pressed:
		Global.jugador_aspecto = "chica"
		if $NombreEditor.text != "":
			Global.jugador_nombre = $NombreEditor.text
		else:
			Global.jugador_nombre = "Lisa"
	
	print(Global.jugador_aspecto)
	print(Global.jugador_nombre)

func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/Menus/MenuInicio1/menu_inicio.tscn")

func _on_chico_boton_pressed() -> void:
	$ChicaBoton.button_pressed = false

func _on_chica_boton_pressed() -> void:
	$ChicoBoton.button_pressed = false
