extends Node2D

var palabra1: bool = false
var palabra2: bool = false

@onready var concejales: int = 0
var puntos: int = 0

var tiempo: String = "00:00"
var tiempo_total: float = 0.0

func _ready() -> void:
	$"Personaje_Codigo/Nivel_Final_Mision".hide()
	$"Personaje_Codigo/Mensaje_Final_Nivel".hide()
	$Plataforma2.hide()
	$Palabra_faltante.show()
	$Plataformas1/Codigo_Incompleto.show()
	$Plataformas1/Codigo_Completo.hide()
	$Personaje_Codigo/Primer_Mensaje.show()

func _process(delta: float) -> void:
	tiempo_total += delta
	var segundos: int = int(tiempo_total)
	var milesimas: int = int((tiempo_total - segundos) * 1000)
	tiempo = "%03d:%03d" % [segundos, milesimas]
	$Personaje_Codigo/Tiempo.text = tiempo

func _on_palabra_faltante_body_entered(_body: Node2D) -> void:
	$Plataformas1/Activar_Primer_Mensaje2/CollisionShape2D.set_deferred("disabled", false)
	$Plataformas1/Codigo_Incompleto.hide()
	$Plataformas1/Codigo_Completo.show()
	$Palabra_faltante.hide()
	$Plataforma3.show()
	$Plataforma3.set_deferred("collision_enabled", true)
	$Concejal1.show()
	$Concejal1/CollisionShape2D.set_deferred("disabled", false)
	$Personaje_Codigo/Fondo_Mision.show()
	$Personaje_Codigo/Mision.show()
	$Personaje_Codigo/Estado_Mision.show()

func _on_activar_primer_mensaje_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Primer_Mensaje.hide()
	$Personaje_Codigo/Mensaje_Final_Nivel.hide()
	$Personaje_Codigo/Nivel_Final_Mision.show()

func _on_activar_ultimo_mensaje_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Primer_Mensaje.hide()
	$Personaje_Codigo/Nivel_Final_Mision2.hide()
	$Personaje_Codigo/Mensaje_Final_Nivel.show()

func _on_muerte_body_entered(_body: Node2D) -> void:
	# ir al nivel-final
	get_tree().call_deferred("reload_current_scene")

func _on_puerta_de_salida_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Advertencia.show()

func _on_aceptar_pressed() -> void:
	$Personaje_Codigo/Camera2D.enabled = false
	# ir al mapa
	Cargador.cargar_escena("uid://c61j2kork7ar5", false)

func _on_cancelar_pressed() -> void:
	$Personaje_Codigo/Advertencia.hide()

func _on_puerta_de_meta_body_entered(_body: Node2D) -> void:
	if concejales == 3:
		Global.llave_final_obtenida = true
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer2.play()
		$Final2.show()
		$Personaje_Codigo/Camera2D.enabled = false
		await $AudioStreamPlayer2.finished
		Global.guardar_partida()
		puntos = concejales * 10
		Database.guardar_tiempo(14, tiempo_total, puntos)
		# ir a la escena final del alcalde
		Cargador.cargar_escena("uid://dnyq6bak8a6c3", false)

func _on_concejal_1_body_entered(_body: Node2D) -> void:
	$Concejal1.hide()
	$Concejal1/CollisionShape2D.set_deferred("disabled", true)
	$Plataforma3.hide()
	$Plataforma3.set_deferred("collision_enabled", false)
	$Plataforma4.show()
	$Plataforma4.set_deferred("collision_enabled", true)
	$Pincho.show()
	$Pincho/CollisionShape2D.set_deferred("disabled", false)
	$Activador_Pincho.show()
	$Activador_Pincho/CollisionShape2D.set_deferred("disabled", false)
	$Concejal2.show()
	$Concejal2/CollisionShape2D.set_deferred("disabled", false)
	$Personaje_Codigo/Estado_Mision.set_deferred("text", "1")
	concejales += 1

func _on_concejal_2_body_entered(_body: Node2D) -> void:
	$Concejal2.hide()
	$Concejal2/CollisionShape2D.set_deferred("disabled", true)
	$Plataforma5.show()
	$Plataforma5.set_deferred("enabled", true)
	$Plataforma6.show()
	$Plataforma6.set_deferred("enabled", true)
	$Pincho2.show()
	$Pincho2/CollisionShape2D.set_deferred("disabled", false)
	$Activador_Pincho2.show()
	$Activador_Pincho2/CollisionShape2D.set_deferred("disabled", false)
	$Concejal3.show()
	$Concejal3/CollisionShape2D.set_deferred("disabled", false)
	$Personaje_Codigo/Estado_Mision.set_deferred("text", "2")
	concejales += 1

func _on_concejal_3_body_entered(_body: Node2D) -> void:
	$Concejal3.hide()
	$Concejal3/CollisionShape2D.set_deferred("disabled", true)
	$Plataformas2.show()
	$Plataformas2.set_deferred("collision_enabled", true)
	$Palabra_faltante2.show()
	$Palabra_faltante2/CollisionShape2D.set_deferred("disabled", false)
	$Palabra_faltante3.show()
	$Palabra_faltante3/CollisionShape2D.set_deferred("disabled", false)
	$Personaje_Codigo/Estado_Mision.set_deferred("text", "3")
	concejales += 1

func _on_palabra_faltante_2_body_entered(_body: Node2D) -> void:
	palabra1 = true
	$Palabra_faltante2.hide()
	$Palabra_faltante2/CollisionShape2D.set_deferred("disabled", true)
	$Plataformas2/Codigo_Incompleto.hide()
	$Plataformas2/Codigo_Incompleto2.show()

func _on_palabra_faltante_3_body_entered(_body: Node2D) -> void:
	if palabra1:
		palabra2 = true
		$Palabra_faltante3.hide()
		$Palabra_faltante3/CollisionShape2D.set_deferred("disabled", true)
		$Plataforma7.show()
		$Plataforma7.set_deferred("collision_enabled", true)
		$Plataformas2/Codigo_Incompleto2.hide()
		$Plataformas2/Codigo_Completo.show()
		$Plataforma2.show()
		$Plataforma2.set_deferred("collision_enabled", true)
	else:
		$Plataformas2.hide()
		$Plataformas2.set_deferred("collision_enabled", false)

func _on_pincho_body_entered(_body: Node2D) -> void:
	# ir al nivel-final
	get_tree().call_deferred("reload_current_scene")

func _on_activar_primer_mensaje_2_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Nivel_Final_Mision.hide()
	$Personaje_Codigo/Nivel_Final_Mision2.show()
