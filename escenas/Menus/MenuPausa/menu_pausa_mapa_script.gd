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
