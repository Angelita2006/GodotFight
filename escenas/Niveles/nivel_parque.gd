extends Node2D

@onready var patos: int = 0

@onready var arboles: int = 0

var tiempo: String = "00:00"
var tiempo_total: float = 0.0

var puntos: int = 0

func _ready() -> void:
	$Personaje_Codigo/Primer_Mensaje.show()
	$Personaje_Codigo/Mensaje_mision.hide()
	
	$Plataformas2.hide()
	$Plataformas2.collision_enabled = false
	
	$Plataformas3.hide()
	$Plataformas3.collision_enabled = false
	
	$Plataformas4.hide()
	$Plataformas4.collision_enabled = false

func _process(delta: float) -> void:
	$Personaje_Codigo/Estado_Mision.text = str(patos)
	
	tiempo_total += delta
	var segundos: int = int(tiempo_total)
	var milesimas: int = int((tiempo_total - segundos) * 1000)
	tiempo = "%03d:%03d" % [segundos, milesimas]
	$Personaje_Codigo/Tiempo.text = tiempo

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
	get_tree().reload_current_scene()

func _on_puerta_de_meta_body_entered(_body: Node2D) -> void:
	if patos == 3:
		Global.llave_verde_obtenida = true
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer2.play()
		$Final2.show()
		$Personaje_Codigo/Camera2D.set_deferred("enabled", false)
		await $AudioStreamPlayer2.finished
		Database.guardar_partida()
		puntos = 10 * arboles
		Database.guardar_tiempo(10, tiempo_total, puntos)
		# ir al mapa
		Cargador.cargar_escena("uid://c61j2kork7ar5", false)

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
	$Plataformas2.set_deferred("collision_enabled", true)
	$Plataformas4.show()
	$Plataformas4.set_deferred("collision_enabled", true)

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
	$Plataformas2/CodigoErroneo.hide()
	$Plataformas2/CodigoCorrecto.show()
	$Plataformas3.show()
	$Plataformas3.set_deferred("collision_enabled", true)

func _on_elemento_secreto_body_entered(_body: Node2D) -> void:
	$Arbol1.hide()
	$Arbol1/CollisionShape2D.set_deferred("disabled", true)
	arboles += 1

func _on_elemento_secreto_2_body_entered(_body: Node2D) -> void:
	$Arbol2.hide()
	$Arbol2/CollisionShape2D.set_deferred("disabled", true)
	$Plataformas5.hide()
	$Plataformas7.show()
	$Plataformas7.set_deferred("collision_enabled", true)
	$Arbol3.show()
	$Arbol3/CollisionShape2D.set_deferred("disabled", false)
	arboles += 1

func _on_elemento_secreto_3_body_entered(_body: Node2D) -> void:
	$Arbol3.hide()
	$Arbol3/CollisionShape2D.set_deferred("disabled", true)
	$Plataformas6.hide()
	$Plataformas8.show()
	$Plataformas8.set_deferred("collision_enabled", true)
	$Arbol4.show()
	$Arbol4/CollisionShape2D.set_deferred("disabled", false)
	arboles += 1

func _on_elemento_secreto_4_body_entered(_body: Node2D) -> void:
	$Arbol4.hide()
	$Arbol4/CollisionShape2D.set_deferred("disabled", true)
	$Plataformas7.hide()
	$Plataformas9.show()
	$Plataformas9.set_deferred("collision_enabled", true)
	arboles += 1
