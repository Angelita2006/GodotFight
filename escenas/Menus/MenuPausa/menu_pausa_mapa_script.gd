extends Control

@export var pausa: VBoxContainer
@export var titulo_pausa: Label
@export var opciones: VBoxContainer
@export var titulo_opciones: Label
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
	Database.guardar_partida()
	mensaje_guardado.show()
	await get_tree().create_timer(2).timeout
	mensaje_guardado.hide()

func _on_volver_pressed() -> void:
	# ir al menú de inicio
	get_tree().change_scene_to_file("uid://b5iedpw7s5iny")

func _on_volver_opciones_pressed() -> void:
	opciones.hide()
	titulo_opciones.hide()
	titulo_pausa.show()
	pausa.show()
