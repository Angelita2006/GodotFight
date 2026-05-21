extends Node2D

var quitar_glitch = false

func _ready() -> void:
	var fila = Database.obtener_datos_ultima_partida()
	if fila[0]["llave_plateada_conseguida"] == 0:
		quitar_glitch = false
	elif fila[0]["llave_plateada_conseguida"] == 1:
		quitar_glitch = true
	if quitar_glitch:
		$Glitch.hide()

func _process(_delta: float) -> void:
	pass
