extends Node2D

@onready var libros: int = 0

var interactuando: bool = false

var palabra_tocada = false

var tiempo: String = "00:00"
var tiempo_total: float = 0.0

var puntos: int = 0

func _ready() -> void:
	$"Personaje_Codigo/Nivel_Biblioteca_Mision".hide()
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
	$Personaje_Codigo/Nivel_Biblioteca_Mision.hide()
	$Personaje_Codigo/Nivel_Biblioteca_Mision2.show()
	$Personaje_Codigo/Fondo_Mision.show()
	$Personaje_Codigo/Mision.show()
	$Personaje_Codigo/Estado_Mision.show()

func _on_activar_primer_mensaje_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Nivel_Biblioteca_Mision.show()

func _on_muerte_body_entered(_body: Node2D) -> void:
	# ir al nivel-tutorial
	get_tree().call_deferred("reload_current_scene")

func _on_puerta_de_salida_body_entered(_body: Node2D) -> void:
	$Personaje_Codigo/Advertencia.show()

func _on_aceptar_pressed() -> void:
	$Personaje_Codigo/Camera2D.enabled = false
	# ir al mapa
	Cargador.cargar_escena("uid://c61j2kork7ar5", true)

func _on_cancelar_pressed() -> void:
	$Personaje_Codigo/Advertencia.hide()

func _on_puerta_de_meta_body_entered(_body: Node2D) -> void:
	if libros == 6:
		Global.llave_purpura_obtenida = true
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer2.play()
		$Final2.show()
		$Personaje_Codigo/Camera2D.enabled = false
		await $AudioStreamPlayer2.finished
		Global.guardar_partida()
		puntos = libros * 10
		Database.guardar_tiempo(11, tiempo_total, puntos)
		# ir al mapa
		Cargador.cargar_escena("uid://c61j2kork7ar5", false)

func _on_libro_body_entered(_body: Node2D) -> void:
	$Libro1.hide()
	$Libro1/CollisionShape2D.set_deferred("disabled", true)
	$Plataforma2.hide()
	$Plataforma2.set_deferred("collision_enabled", false)
	$Plataformas3.show()
	$Plataformas3.set_deferred("collision_enabled", true)
	$Libro2.show()
	$Libro2/CollisionShape2D.set_deferred("disabled", false)
	$Personaje_Codigo/Estado_Mision.set_deferred("text", "1")
	libros += 1

func _on_libro_2_body_entered(_body: Node2D) -> void:
	$Libro2.hide()
	$Libro2/CollisionShape2D.set_deferred("disabled", true)
	$Plataforma3.hide()
	$Plataforma3.set_deferred("collision_enabled", false)
	$Plataformas4.show()
	$Plataformas4.set_deferred("collision_enabled", true)
	$Libro3.show()
	$Libro3/CollisionShape2D.set_deferred("disabled", false)
	$Personaje_Codigo/Estado_Mision.set_deferred("text", "2")
	libros += 1

func _on_libro_3_body_entered(_body: Node2D) -> void:
	$Libro3.hide()
	$Libro3/CollisionShape2D.set_deferred("disabled", true)
	$Plataformas3.hide()
	$Plataformas3.set_deferred("collision_enabled", false)
	$Plataformas5.show()
	$Plataformas5.set_deferred("collision_enabled", true)
	$Libro4.show()
	$Libro4/CollisionShape2D.set_deferred("disabled", false)
	$Personaje_Codigo/Estado_Mision.set_deferred("text", "3")
	libros += 1

func _on_libro_4_body_entered(_body: Node2D) -> void:
	$Libro4.hide()
	$Libro4/CollisionShape2D.set_deferred("disabled", true)
	$Plataformas4.hide()
	$Plataformas4.set_deferred("collision_enabled", false)
	$Plataformas6.show()
	$Plataformas6.set_deferred("collision_enabled", true)
	$Libro5.show()
	$Libro5/CollisionShape2D.set_deferred("disabled", false)
	$Personaje_Codigo/Estado_Mision.set_deferred("text", "4")
	libros += 1

func _on_libro_5_body_entered(_body: Node2D) -> void:
	$Libro5.hide()
	$Libro5/CollisionShape2D.set_deferred("disabled", true)
	$Plataformas5.hide()
	$Plataformas5.set_deferred("collision_enabled", false)
	$Plataformas7.show()
	$Plataformas7.set_deferred("collision_enabled", true)
	await get_tree().create_timer(1).timeout
	$Plataformas6.hide()
	$Plataformas6.set_deferred("collision_enabled", false)
	$Libro6.show()
	$Libro6/CollisionShape2D.set_deferred("disabled", false)
	$Personaje_Codigo/Estado_Mision.set_deferred("text", "5")
	libros += 1

func _on_libro_6_body_entered(_body: Node2D) -> void:
	$Libro6.hide()
	$Libro6/CollisionShape2D.set_deferred("disabled", true)
	$Personaje_Codigo/Estado_Mision.set_deferred("text", "6")
	libros += 1
