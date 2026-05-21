extends Node2D

@onready var patos: int = 0

@onready var secretoEncontrado: bool = false

func _ready() -> void:
	$Personaje_Codigo/Primer_Mensaje.show()
	$Personaje_Codigo/Mensaje_mision.hide()
	
	$Plataformas2.hide()
	$Plataformas2.collision_enabled = false
	
	$Plataformas3.hide()
	$Plataformas3.collision_enabled = false
	
	$Plataformas4.hide()
	$Plataformas4.collision_enabled = false


func _process(_delta: float) -> void:
	$Personaje_Codigo/Estado_Mision.text = str(patos)


func _on_puerta_de_salida_body_entered(_body: CharacterBody2D) -> void:
	$Personaje_Codigo/Advertencia.show()

func _on_aceptar_pressed() -> void:
	$Personaje_Codigo/Camera2D.enabled = false
	# ir al mapa
	Cargador.cargar_escena("uid://c61j2kork7ar5", true)


func _on_cancelar_pressed() -> void:
	$Personaje_Codigo/Advertencia.hide()


func _on_muerte_body_entered(_body: Node2D) -> void:
	# ir al nivel-parque
	get_tree().change_scene_to_file("uid://b8i0qhu37u1ep")


func _on_puerta_de_meta_body_entered(_body: Node2D) -> void:
	# GUARDAR QUE EL NIVEL HA SIDO COMPLETADO Y SI EL COLECCIONABLE SECRETO HA SIDO RECOGIDO
	if patos == 3:
		$Personaje_Codigo/Camera2D.enabled = false
		# ir al mapa
		Cargador.cargar_escena("uid://c61j2kork7ar5", true)


func _on_activar_primer_mensaje_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Primer_Mensaje.hide()
	$Personaje_Codigo/Mensaje_mision.show()
	
	$Personaje_Codigo/Fondo_Mision.show()
	$Personaje_Codigo/Estado_Mision.show()
	$Personaje_Codigo/Mision.show()


func _on_palabra_faltante_body_entered(_body: Node2D) -> void:
	$PalabraFaltante.hide()
	$Plataformas1/CodigoErroneo.hide()
	$Plataformas1/CodigoCorrecto.show()
	$Plataformas2.show()
	$Plataformas2.collision_enabled = true
	$Plataformas4.show()
	$Plataformas4.collision_enabled = true


func _on_pato_1_body_entered(_body: Node2D) -> void:
	$Pato1.hide()
	$Pato1/CollisionShape2D.set_deferred("disabled", true)
	patos += 1


func _on_pato_2_body_entered(_body: Node2D) -> void:
	$Pato2.hide()
	$Pato2/CollisionShape2D.set_deferred("disabled", true)
	patos += 1


func _on_pato_3_body_entered(_body: Node2D) -> void:
	$Pato3.hide()
	$Pato3/CollisionShape2D.set_deferred("disabled", true)
	patos += 1


func _on_palabra_faltante_2_body_entered(_body: Node2D) -> void:
	$PalabraFaltante2.hide()
	$Plataformas3.show()
	$Plataformas3.collision_enabled = true


func _on_elemento_secreto_body_entered(_body: Node2D) -> void:
	$ElementoSecreto.hide()
	$ElementoSecreto/CollisionShape2D.set_deferred("disabled", true)
	secretoEncontrado = true
