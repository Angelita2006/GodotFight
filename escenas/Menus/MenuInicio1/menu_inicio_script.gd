extends Control

# Export de los contenedores
@export var inicio : VBoxContainer
@export var modohistoria : VBoxContainer
@export var modopractica : VBoxContainer
@export var ranking : VBoxContainer
@export var opciones : VBoxContainer

# Export de los labels
@export var titulo : Label
@export var titulojuego : Label

# Export de los botones del menú principal
@export var boton_modo_historia : Button
@export var boton_modo_practica : Button
@export var boton_ranking : Button
@export var boton_opciones : Button
@export var boton_salir : Button

# Export de los botones "Volver" de cada submenú
@export var volver_historia : Button
@export var volver_practica : Button
@export var volver_ranking : Button
@export var volver_opciones : Button

func _ready() -> void:
	# Conexiones de los botones del menú principal
	boton_modo_historia.pressed.connect(on_boton_pressed.bind(modohistoria))
	boton_modo_practica.pressed.connect(on_boton_pressed.bind(modopractica))
	boton_ranking.pressed.connect(on_boton_pressed.bind(ranking))
	boton_opciones.pressed.connect(on_boton_pressed.bind(opciones))
	boton_salir.pressed.connect(_on_salir_pressed)

	# Conexiones de los botones "Volver" en cada submenú
	volver_historia.pressed.connect(_on_volver_pressed.bind(modohistoria))
	volver_practica.pressed.connect(_on_volver_pressed.bind(modopractica))
	volver_ranking.pressed.connect(_on_volver_pressed.bind(ranking))
	volver_opciones.pressed.connect(_on_volver_pressed.bind(opciones))

func _process(_delta: float) -> void:
	pass

func _on_salir_pressed() -> void:
	get_tree().quit()

# Oculta el contenedor actual y muestra el menú inicio
func _on_volver_pressed(contenedor: VBoxContainer) -> void:
	contenedor.hide()
	inicio.show()
	titulo.hide()
	titulojuego.show()

# Oculta el menú inicio y muestra el contenedor seleccionado
func on_boton_pressed(contenedor: VBoxContainer) -> void:
	inicio.hide()
	contenedor.show()
	titulojuego.hide()
	titulo.text = contenedor.name   # usa el nombre del nodo como texto
	titulo.show()


func _on_mapa_aldea_esmeralda_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/MapaAldeaEsmeralda/mapa_aldea_esmeralda.tscn")
