extends Node2D

@onready var secretoEncontrado: bool = false

var palabra1: bool = false
var palabra2: bool = false
var palabra3: bool = false

func _ready() -> void:
	$Plataformas1.show()
	$Plataformas1.collision_enabled = true
	
	$Plataformas2.show()
	$Plataformas2.collision_enabled = true
	
	$Plataformas3.hide()
	$Plataformas3.collision_enabled = false
	
	$Plataformas1/Codigo_Incompleto1.show()
	$Plataformas1/Codigo_Incompleto2.hide()
	$Plataformas1/Codigo_Incompleto3.hide()
	$Plataformas1/Codigo_Completo.hide()


func _on_muerte_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file("res://escenas/Niveles/nivel-mercao.tscn")


func _on_puerta_de_meta_body_entered(_body: Node2D) -> void:
	## GUARDAR QUE EL NIVEL HA SIDO COMPLETADO Y SI EL COLECCIONABLE SECRETO HA SIDO RECOGIDO
	$Personaje_Codigo/Camera2D.enabled = false
	Cargador.cargar_escena("res://escenas/MapaAldeaEsmeralda/mapa_aldea_esmeralda.tscn", true)


func _on_puerta_de_salida_body_entered(_body: CharacterBody2D) -> void:
	$Personaje_Codigo/Advertencia.show()

func _on_aceptar_pressed() -> void:
	$Personaje_Codigo/Camera2D.enabled = false
	Cargador.cargar_escena("res://escenas/MapaAldeaEsmeralda/mapa_aldea_esmeralda.tscn", true)


func _on_cancelar_pressed() -> void:
	$Personaje_Codigo/Advertencia.hide()


func _on_secreto_body_entered(_body: Node2D) -> void:
	$Secreto.hide()
	$Secreto/CollisionShape2D.set_deferred("disabled", true)
	secretoEncontrado = true


func _on_activar_primer_mensaje_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Nivel_Mision.show()


func _on_activar_mensaje_pista_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Nivel_Mision.hide()
	$Personaje_Codigo/Pista_Mision.show()


func _on_palabra_faltante_body_entered(_body: Node2D) -> void:
	if !palabra1:
		$Personaje_Codigo.position = Vector2(7524,1543)
	else:
		palabra2 = true
		$Plataformas1/Codigo_Incompleto2.hide()
		$Plataformas1/Codigo_Incompleto3.show()
		
		$Palabra_faltante.hide()


func _on_palabra_faltante_2_body_entered(_body: Node2D) -> void:
	palabra1 = true
	$Plataformas1/Codigo_Incompleto1.hide()
	$Plataformas1/Codigo_Incompleto2.show()
	
	$Palabra_faltante2.hide()


func _on_palabra_faltante_3_body_entered(_body: Node2D) -> void:
	if !palabra2:
		$Personaje_Codigo.position = Vector2(7524,1543)
	else:
		palabra3 = true
		$Plataformas1/Codigo_Incompleto3.hide()
		$Plataformas1/Codigo_Completo.show()
		
		$Palabra_faltante3.hide()
		
		$Plataformas2.hide()
		$Plataformas2.collision_enabled = false
		
		$Plataformas3.show()
		$Plataformas3.collision_enabled = true
		
		


func _on_activar_aviso_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Aviso.show()
	$Personaje_Codigo/Nivel_Mision.hide()
	$Personaje_Codigo/Pista_Mision.hide()


func _on_pincho_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file("res://escenas/Niveles/nivel-mercao.tscn")
