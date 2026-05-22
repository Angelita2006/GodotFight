extends Control

# Export de los contenedores
@export var inicio : VBoxContainer
@export var modohistoria : VBoxContainer
@export var modopractica : VBoxContainer
@export var ranking : VBoxContainer
@export var opciones : VBoxContainer
@export var editor : Control

# Export de los labels
@export var titulo_modohistoria : Label
@export var titulo_modopractica : Label
@export var titulo_ranking : Label
@export var titulo_opciones : Label
@export var titulojuego : Label

# Export de los botones del menú principal
@export var boton_modo_historia : Button
@export var boton_modo_practica : Button
@export var boton_editar_personaje : Button
@export var boton_ranking : Button
@export var boton_opciones : Button
@export var boton_salir : Button

# Export de los botones "Volver" de cada submenú
@export var volver_historia : Button
@export var volver_practica : Button
@export var volver_ranking : Button
@export var volver_opciones : Button
@export var volver_editor: Button

@export var idiomat: Label
@export var idioma: VBoxContainer
@export var volument: Label
@export var volumen: HSlider
@export var controlest: Label
@export var controles: Panel
@export var creditost: Label
@export var creditos: RichTextLabel

@export var fondo_aldea_esmeralda: Panel
@export var preview_aldea_esmeralda: Panel
@export var fondo_aldea_desierta: Panel
@export var preview_aldea_desierta: Panel
@export var fondo_aldea_helada: Panel
@export var preview_aldea_helada: Panel
@export var fondo_aldea_tropical: Panel
@export var preview_aldea_tropical: Panel
@export var fondo_aldea_volcanica: Panel
@export var preview_aldea_volcanica: Panel

@export var idiomaO: OptionButton
@export var chico_boton: Button
@export var chica_boton: Button
@export var nombre_editor: LineEdit
@export var fondo_mensaje: Panel
@export var mensaje: Label

var config = ConfigFile.new()

var partida_nueva :bool = true

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
	
	if Global.jugador_aspecto == "chico":
		chico_boton.button_pressed = true
	elif Global.jugador_aspecto == "chica":
		chica_boton.button_pressed = true
	
	if Global.jugador_nombre != "":
		nombre_editor.text = Global.jugador_nombre
	
	await get_tree().process_frame
	# Conexiones de los botones del menú principal
	boton_modo_historia.pressed.connect(on_modohistoria_pressed.bind(modohistoria))
	boton_modo_practica.pressed.connect(on_modopractica_pressed.bind(modopractica))
	boton_editar_personaje.pressed.connect(on_editarpersonaje_pressed.bind())
	boton_ranking.pressed.connect(on_ranking_pressed.bind(ranking))
	boton_opciones.pressed.connect(on_opciones_pressed.bind(opciones))
	boton_salir.pressed.connect(_on_salir_pressed)

	# Conexiones de los botones "Volver" en cada submenú
	volver_historia.pressed.connect(_on_volver_pressed.bind(modohistoria))
	volver_practica.pressed.connect(_on_volver_pressed.bind(modopractica))
	volver_ranking.pressed.connect(_on_volver_pressed.bind(ranking))
	volver_opciones.pressed.connect(_on_volver_pressed.bind(opciones))
	volver_editor.pressed.connect(_on_volver_pressed.bind(opciones))

func _process(_delta: float) -> void:
	pass

func _on_salir_pressed() -> void:
	get_tree().quit()

# Oculta el contenedor actual y muestra el menú inicio
func _on_volver_pressed(contenedor: VBoxContainer) -> void:
	contenedor.hide()
	volver_historia.hide()
	fondo_aldea_esmeralda.hide()
	preview_aldea_esmeralda.hide()
	fondo_aldea_desierta.hide()
	preview_aldea_desierta.hide()
	fondo_aldea_helada.hide()
	preview_aldea_helada.hide()
	fondo_aldea_tropical.hide()
	preview_aldea_tropical.hide()
	fondo_aldea_volcanica.hide()
	preview_aldea_volcanica.hide()
	inicio.show()
	titulo_modohistoria.hide()
	titulo_modopractica.hide()
	titulo_ranking.hide()
	titulo_opciones.hide()
	titulojuego.show()
	idioma.hide()
	idiomat.hide()
	volumen.hide()
	volument.hide()
	controles.hide()
	controlest.hide()
	creditos.hide()
	creditost.hide()
	editor.hide()

# Oculta el menú inicio y muestra el contenedor seleccionado
func on_modohistoria_pressed(contenedor: VBoxContainer) -> void:
	inicio.hide()
	volver_historia.show()
	fondo_aldea_esmeralda.show()
	preview_aldea_esmeralda.show()
	fondo_aldea_desierta.show()
	preview_aldea_desierta.show()
	fondo_aldea_helada.show()
	preview_aldea_helada.show()
	fondo_aldea_tropical.show()
	preview_aldea_tropical.show()
	fondo_aldea_volcanica.show()
	preview_aldea_volcanica.show()
	contenedor.show()
	titulojuego.hide()
	titulo_modohistoria.show()
	titulo_modopractica.hide()
	titulo_ranking.hide()
	titulo_opciones.hide()

func on_modopractica_pressed(contenedor: VBoxContainer) -> void:
	inicio.hide()
	volver_historia.hide()
	fondo_aldea_esmeralda.hide()
	preview_aldea_esmeralda.hide()
	fondo_aldea_desierta.hide()
	preview_aldea_desierta.hide()
	fondo_aldea_helada.hide()
	preview_aldea_helada.hide()
	fondo_aldea_tropical.hide()
	preview_aldea_tropical.hide()
	fondo_aldea_volcanica.hide()
	preview_aldea_volcanica.hide()
	contenedor.show()
	titulojuego.hide()
	titulo_modopractica.show()
	titulo_modohistoria.hide()
	titulo_ranking.hide()
	titulo_opciones.hide()

func on_editarpersonaje_pressed() -> void:
	volver_historia.hide()
	fondo_aldea_esmeralda.hide()
	preview_aldea_esmeralda.hide()
	fondo_aldea_desierta.hide()
	preview_aldea_desierta.hide()
	fondo_aldea_helada.hide()
	preview_aldea_helada.hide()
	fondo_aldea_tropical.hide()
	preview_aldea_tropical.hide()
	fondo_aldea_volcanica.hide()
	preview_aldea_volcanica.hide()
	editor.show()

func on_ranking_pressed(contenedor: VBoxContainer) -> void:
	inicio.hide()
	volver_historia.hide()
	fondo_aldea_esmeralda.hide()
	preview_aldea_esmeralda.hide()
	fondo_aldea_desierta.hide()
	preview_aldea_desierta.hide()
	fondo_aldea_helada.hide()
	preview_aldea_helada.hide()
	fondo_aldea_tropical.hide()
	preview_aldea_tropical.hide()
	fondo_aldea_volcanica.hide()
	preview_aldea_volcanica.hide()
	contenedor.show()
	titulojuego.hide()
	titulo_ranking.show()
	titulo_modohistoria.hide()
	titulo_modopractica.hide()
	titulo_opciones.hide()

func on_opciones_pressed(contenedor: VBoxContainer) -> void:
	inicio.hide()
	volver_historia.hide()
	fondo_aldea_esmeralda.hide()
	preview_aldea_esmeralda.hide()
	fondo_aldea_desierta.hide()
	preview_aldea_desierta.hide()
	fondo_aldea_helada.hide()
	preview_aldea_helada.hide()
	fondo_aldea_tropical.hide()
	preview_aldea_tropical.hide()
	fondo_aldea_volcanica.hide()
	preview_aldea_volcanica.hide()
	contenedor.show()
	titulojuego.hide()
	titulo_opciones.show()
	titulo_modohistoria.hide()
	titulo_modopractica.hide()
	titulo_ranking.hide()
	idioma.show()
	idiomat.show()

func _on_mapa_aldea_esmeralda_pressed() -> void:
	if !Database.hay_partida_guardada():
		# ir a la animación del alcalde
		Cargador.cargar_escena("uid://ysdgfhl3llyi", false)
		Cargador.entrar_escena_cargada()
	else:
		# ir al mapa
		Cargador.cargar_escena("uid://c61j2kork7ar5", true)

func _on_volumen_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(volumen.value))
	Global.volumen = volumen.value
	Database.guardar_ajustes()

func _on_audio_pressed() -> void:
	volumen.show()
	volument.show()
	idioma.hide()
	idiomat.hide()
	controles.hide()
	controlest.hide()
	creditos.hide()
	creditost.hide()

func _on_idioma_pressed() -> void:
	idioma.show()
	idiomat.show()
	volumen.hide()
	volument.hide()
	controles.hide()
	controlest.hide()
	creditos.hide()
	creditost.hide()

func _on_controles_pressed() -> void:
	controles.show()
	controlest.show()
	idioma.hide()
	idiomat.hide()
	volumen.hide()
	volument.hide()
	creditos.hide()
	creditost.hide()

func _on_créditos_pressed() -> void:
	creditos.show()
	creditost.show()
	controles.hide()
	controlest.hide()
	idioma.hide()
	idiomat.hide()
	volumen.hide()
	volument.hide()

func _on_guardar_pressed() -> void:
	if chico_boton.button_pressed:
		Global.jugador_aspecto = "chico"
		if nombre_editor.text != "":
			Global.jugador_nombre = nombre_editor.text
		else:
			Global.jugador_nombre = "Mike"
		
	elif chica_boton.button_pressed:
		Global.jugador_aspecto = "chica"
		if nombre_editor.text != "":
			Global.jugador_nombre = nombre_editor.text
		else:
			Global.jugador_nombre = "Lisa"
	
	Database.guardar_ajustes()
	
	fondo_mensaje.show()
	mensaje.show()
	await get_tree().create_timer(1).timeout
	fondo_mensaje.hide()
	mensaje.hide()

func _on_idioma_item_selected(index: int) -> void:
	match index:
		0:
			TranslationServer.set_locale("es")
			guardar_idioma("es")
			Global.idioma = "es"
			Database.guardar_ajustes()
		1:
			TranslationServer.set_locale("en")
			guardar_idioma("en")
			Global.idioma = "en"
			Database.guardar_ajustes()

func guardar_idioma(idiomaLanguage):
	config.set_value("config","idioma",idiomaLanguage)
	config.save("user://config.cfg")

func _on_chico_boton_pressed() -> void:
	chica_boton.button_pressed = false

func _on_chica_boton_pressed() -> void:
	chico_boton.button_pressed = false
