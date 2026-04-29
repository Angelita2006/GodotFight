extends Control

@export var pausa: VBoxContainer
@export var titulo_pausa: Label
@export var opciones: VBoxContainer
@export var titulo_opciones: Label

@export var idiomat: Label
@export var idioma: VBoxContainer
@export var volument: Label
@export var volumen: HSlider
@export var controlest: Label
@export var controles: Panel
@export var creditost: Label
@export var creditos: RichTextLabel
@export var volver: Button

@export var personajeprincipal: CharacterBody2D

var mensaje_guardado: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mensaje_guardado = get_parent().get_child(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	Database.abrir_db()
	Database.crear_tabla_si_no_existe()
	Database.db.query("DELETE FROM partida")
	var pos = personajeprincipal.global_position
	Database.db.query("INSERT INTO partida (pos_x,pos_y) VALUES ("+str(pos.x)+","+str(pos.y)+")")
	Database.cerrar_db()
	mensaje_guardado.show()
	await get_tree().create_timer(2).timeout
	mensaje_guardado.hide()

func _on_volver_pressed() -> void:
	#$AnimationPlayer.play("fade_out")
	get_tree().change_scene_to_file("res://escenas/Menus/MenuInicio1/menu_inicio.tscn")

func _on_volver_opciones_pressed() -> void:
	opciones.hide()
	titulo_opciones.hide()
	titulo_pausa.show()
	pausa.show()

func _on_volverAopciones_pressed() -> void:
	opciones.show()
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
