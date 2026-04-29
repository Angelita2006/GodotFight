extends Node2D

var interactuando: bool = false

func _ready() -> void:
	$"Personaje Codigo/Nivel_Tutorial_Mision".hide()
	$"Personaje Codigo/Mensaje_Final_Nivel".hide()
	$Plataformas2.hide()
	$"Palabra faltante".show()
	$Plataformas/Codigo_Incompleto.show()
	$Plataformas/Codigo_Completo.hide()
	
	$"Personaje Codigo/Primer_Mensaje".show()
	await get_tree().create_timer(4).timeout
	$"Personaje Codigo/Primer_Mensaje".hide()


func _input(_event: InputEvent) -> void:
	if interactuando and Input.is_action_just_pressed("interactuar"):
		$"Palabra faltante".hide()
		$Plataformas/Codigo_Incompleto.hide()
		$Plataformas/Codigo_Completo.show()
		$Plataformas2.show()

func _on_palabra_faltante_body_entered(_body: Node2D) -> void:
	interactuando = true


func _on_palabra_faltante_body_exited(_body: Node2D) -> void:
	interactuando = false


func _on_activar_primer_mensaje_body_entered(_body: Node2D) -> void:
	$"Personaje Codigo/Primer_Mensaje".hide()
	$"Personaje Codigo/Mensaje_Final_Nivel".hide()
	$"Personaje Codigo/Nivel_Tutorial_Mision".show()
	await get_tree().create_timer(4).timeout
	$"Personaje Codigo/Nivel_Tutorial_Mision".hide()


func _on_activar_ultimo_mensaje_body_entered(_body: Node2D) -> void:
	$"Personaje Codigo/Primer_Mensaje".hide()
	$"Personaje Codigo/Nivel_Tutorial_Mision".hide()
	$"Personaje Codigo/Mensaje_Final_Nivel".show()
	await get_tree().create_timer(4).timeout
	$"Personaje Codigo/Mensaje_Final_Nivel".hide()


func _on_muerte_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file("res://escenas/Niveles/tutorial.tscn")


func _on_puerta_de_salida_body_entered(_body: Node2D) -> void:
	Cargador.cargar_escena("res://escenas/MapaAldeaEsmeralda/mapa_aldea_esmeralda.tscn", true)
