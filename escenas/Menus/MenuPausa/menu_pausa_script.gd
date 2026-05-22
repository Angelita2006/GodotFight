extends Control

@export var pausa: VBoxContainer
@export var titulo_pausa: Label
@export var opciones: VBoxContainer
@export var titulo_opciones: Label

@export var idiomat: Label
@export var idioma: VBoxContainer
@export var idiomaO: OptionButton
@export var volument: Label
@export var volumen: HSlider
@export var controlest: Label
@export var controles: Panel
@export var creditost: Label
@export var creditos: RichTextLabel
@export var volver: Button

@export var personajeprincipal: CharacterBody2D

@onready var mensaje_guardado: Label = $"Mensaje guardado"
@onready var fondo_guardado: Panel = $"Fondo Mensaje"
var config = ConfigFile.new()

func cargar_ajustes():
	var fila = Database.obtener_datos_ajustes()
	if fila:
		Global.volumen = fila[0]["volumen"]
		Global.idioma = fila[0]["idioma"]
		Global.jugador_aspecto = fila[0]["jugador_aspecto"]
		Global.jugador_nombre = fila[0]["jugador_nombre"]

func _ready() -> void:
	# Obtener los ajustes de volumen e idioma
	cargar_ajustes()
	config.load("user://config.cfg")
	var idiomaConf = config.get_value("config","idioma",Global.idioma)
	TranslationServer.set_locale(idiomaConf)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(Global.volumen))
	volumen.value = Global.volumen
	if Global.idioma == "es":
		idiomaO.select(0)
	elif Global.idioma == "en":
		idiomaO.select(1)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("continuar"):
		self.hide()

func _on_continuar_pressed() -> void:
	self.hide()

func _on_opciones_pressed() -> void:
	titulo_pausa.hide()
	pausa.hide()
	opciones.show()
	titulo_opciones.show()

func _on_guardar_pressed() -> void:
	Database.guardar_partida()
	fondo_guardado.show()
	mensaje_guardado.show()
	await get_tree().create_timer(1).timeout
	mensaje_guardado.hide()
	fondo_guardado.hide()

func _on_volver_pressed() -> void:
	# ir al menú de inicio
	get_tree().change_scene_to_file("uid://b5iedpw7s5iny")

func _on_volver_opciones_pressed() -> void:
	opciones.hide()
	titulo_opciones.hide()
	titulo_pausa.show()
	pausa.show()

func _on_volverAopciones_pressed() -> void:
	opciones.show()
	titulo_opciones.show()
	idioma.hide()
	idiomat.hide()
	volumen.hide()
	volument.hide()
	creditos.hide()
	creditost.hide()
	controles.hide()
	controlest.hide()
	volver.hide()

func _on_idioma_pressed() -> void:
	opciones.hide()
	titulo_opciones.hide()
	volver.show()
	idioma.show()
	idiomat.show()
	volumen.hide()
	volument.hide()
	creditos.hide()
	creditost.hide()
	controles.hide()
	controlest.hide()

func _on_audio_pressed() -> void:
	titulo_opciones.hide()
	opciones.hide()
	volver.show()
	idioma.hide()
	idiomat.hide()
	volumen.show()
	volument.show()
	creditos.hide()
	creditost.hide()
	controles.hide()
	controlest.hide()

func _on_controles_pressed() -> void:
	titulo_opciones.hide()
	opciones.hide()
	volver.show()
	idioma.hide()
	idiomat.hide()
	volumen.hide()
	volument.hide()
	creditos.hide()
	creditost.hide()
	controles.show()
	controlest.show()

func _on_créditos_pressed() -> void:
	titulo_opciones.hide()
	opciones.hide()
	volver.show()
	idioma.hide()
	idiomat.hide()
	volumen.hide()
	volument.hide()
	creditos.show()
	creditost.show()
	controles.hide()
	controlest.hide()

func _on_volumen_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(volumen.value))
