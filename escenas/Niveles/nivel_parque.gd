extends Node2D


func _on_puerta_de_salida_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Advertencia.show()


func _on_aceptar_pressed() -> void:
	$Personaje_Codigo/Camera2D.enabled = false
	Cargador.cargar_escena("res://escenas/MapaAldeaEsmeralda/mapa_aldea_esmeralda.tscn", true)


func _on_cancelar_pressed() -> void:
	$Personaje_Codigo/Advertencia.hide()


func _on_muerte_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file("res://escenas/Niveles/nivel-parque.tscn")


func _on_puerta_de_meta_body_entered(_body: Node2D) -> void:
	# Guardar que el nivel ha sido completado
	$Personaje_Codigo/Camera2D.enabled = false
	Cargador.cargar_escena("res://escenas/MapaAldeaEsmeralda/mapa_aldea_esmeralda.tscn", true)
