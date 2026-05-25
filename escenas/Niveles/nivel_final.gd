extends Node2D

var interactuando: bool = false

var palabra_tocada = false

var tiempo: String = "00:00"
var tiempo_total: float = 0.0

func _ready() -> void:
	$"Personaje_Codigo/Nivel_Tutorial_Mision".hide()
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

func _input(_event: InputEvent) -> void:
	if interactuando and Input.is_action_just_pressed("interactuar"):
		$"Palabra faltante".hide()
		$Plataformas/Codigo_Incompleto.hide()
		$Plataformas/Codigo_Completo.show()
		$Plataformas2.show()

func _on_palabra_faltante_body_entered(_body: Node2D) -> void:
	interactuando = true
	palabra_tocada = true
	$Plataformas1/Codigo_Incompleto.hide()
	$Plataformas1/Codigo_Completo.show()
	$Plataforma2.show() 
	$Palabra_faltante.hide()

func _on_activar_primer_mensaje_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Primer_Mensaje.hide()
	$Personaje_Codigo/Mensaje_Final_Nivel.hide()
	$Personaje_Codigo/Nivel_Tutorial_Mision.show()

func _on_activar_ultimo_mensaje_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Primer_Mensaje.hide()
	$Personaje_Codigo/Nivel_Tutorial_Mision.hide()
	$Personaje_Codigo/Mensaje_Final_Nivel.show()

func _on_muerte_body_entered(_body: Node2D) -> void:
	# ir al nivel-final
	get_tree().reload_current_scene()

func _on_puerta_de_salida_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Advertencia.show()

func _on_aceptar_pressed() -> void:
	$Personaje_Codigo/Camera2D.enabled = false
	# ir al mapa
	Cargador.cargar_escena("uid://c61j2kork7ar5", true)

func _on_cancelar_pressed() -> void:
	$Personaje_Codigo/Advertencia.hide()

func _on_puerta_de_meta_body_entered(_body: Node2D) -> void:
	Global.llave_final_obtenida = true
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer2.play()
	$Final2.show()
	$Personaje_Codigo/Camera2D.enabled = false
	await $AudioStreamPlayer2.finished
	Database.guardar_partida()
	Database.guardar_tiempo(14, tiempo_total)
	# ir al mapa
	Cargador.cargar_escena("uid://c61j2kork7ar5", false)
