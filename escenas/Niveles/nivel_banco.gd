extends Node2D

@onready var oro: int = 0

var tiempo: String = "00:00"
var tiempo_total: float = 0.0

func _ready() -> void:
	$"Personaje_Codigo/Nivel_Banco_Mision".hide()
	$Plataforma2.hide()
	$Palabra_faltante.show()
	$Plataformas1/Codigo_Incompleto.show()
	$Plataformas1/Codigo_Completo.hide()

func _process(delta: float) -> void:
	tiempo_total += delta
	var segundos: int = int(tiempo_total)
	var milesimas: int = int((tiempo_total - segundos) * 1000)
	tiempo = "%03d:%03d" % [segundos, milesimas]
	$Personaje_Codigo/Tiempo.text = tiempo

func _on_activar_primer_mensaje_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Nivel_Banco_Mision.show()

func _on_muerte_body_entered(_body: Node2D) -> void:
	# ir al nivel-banco
	get_tree().reload_current_scene()

func _on_puerta_de_salida_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Advertencia.show()

func _on_aceptar_pressed() -> void:
	$Personaje_Codigo/Camera2D.set_deferred("enabled", false)
	# ir al mapa
	Cargador.cargar_escena("uid://c61j2kork7ar5", false)

func _on_cancelar_pressed() -> void:
	$Personaje_Codigo/Advertencia.hide()

func _on_puerta_de_meta_body_entered(_body: Node2D) -> void:
	if oro == 4:
		Global.llave_dorada_obtenida = true
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer2.play()
		$Final2.show()
		$Personaje_Codigo/Camera2D.set_deferred("enabled", false)
		await $AudioStreamPlayer2.finished
		Database.guardar_partida()
		Database.guardar_tiempo(13, tiempo_total, 0)
		# ir al mapa
		Cargador.cargar_escena("uid://c61j2kork7ar5", false)

func _on_palabra_faltante_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Nivel_Banco_Mision.hide()
	$Personaje_Codigo/Nivel_Banco_Mision2.show()
	$Plataformas1/Codigo_Incompleto.hide()
	$Plataformas1/Codigo_Completo.show()
	$Plataforma3.show() 
	$Plataforma3.set_deferred("enabled", true)
	$Oro1.show()
	$Oro1/CollisionShape2D.set_deferred("disabled", false)
	$Palabra_faltante.hide()
	$Palabra_faltante/CollisionShape2D.set_deferred("disabled", true)

func _on_oro_1_body_entered(_body: Node2D) -> void:
	$Oro1.hide()
	$Oro1/CollisionShape2D.set_deferred("disabled", true)
	$Oro2.show()
	$Oro2/CollisionShape2D.set_deferred("disabled", false)
	oro += 1

func _on_oro_2_body_entered(_body: Node2D) -> void:
	$Oro2.hide()
	$Oro2/CollisionShape2D.set_deferred("disabled", true)
	$Oro3.show()
	$Oro3/CollisionShape2D.set_deferred("disabled", false)
	oro += 1

func _on_oro_3_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Nivel_Banco_Mision2.hide()
	$Personaje_Codigo/Nivel_Banco_Mision3.show()
	$Oro3.hide()
	$Oro3/CollisionShape2D.set_deferred("disabled", true)
	$Activador_Pincho.show()
	$Activador_Pincho/CollisionShape2D.set_deferred("disabled", false)
	$Plataformas2.show()
	$Plataformas2.set_deferred("enabled", true)
	$Pincho.show()
	$Pincho/CollisionShape2D.set_deferred("disabled", false)
	$Plataforma3.hide()
	$Plataforma3.set_deferred("enabled", false)
	$Oro4.show()
	$Oro4/CollisionShape2D.set_deferred("disabled", false)
	oro += 1

func _on_oro_4_body_entered(_body: Node2D) -> void:
	$Oro4.hide()
	$Oro4/CollisionShape2D.set_deferred("disabled", true)
	$Plataforma4.show()
	$Plataforma4.set_deferred("enabled", true)
	$Plataforma2.show()
	$Plataforma2.set_deferred("enabled", true)
	oro += 1

func _on_pincho_body_entered(_body: Node2D) -> void:
	# ir al nivel-banco
	get_tree().reload_current_scene()
