extends Panel

@onready var tabla := $Contenedor

func _ready() -> void:
	#pass
	if Database.abrir_db():
		#Database.reiniciar_datos()
		Database.crear_tabla_si_no_existe()
		#Database.insertar_datos_ejemplo()
		mostrar_ranking()
		Database.db.close_db()  # Cerramos la DB al final

func mostrar_ranking():
	#pass
	#var resultados = Database.cargar_ranking()
	#var resultados = Database.obtener_record_de_tiempo()
	var resultados = Database.obtener_todo()
	# Limpiar filas anteriores (dejando cabecera)
	var index = 0
	for resultado in resultados:
		index += 1
		var label1 = Label.new()
		#label1.font.resource_path = "res://assets/ui/fuentes/Pixuf.ttf"
		label1.text = str(index)
		#$Top.
		var font = load("res://assets/ui/fuentes/Pixuf.ttf")
		label1.add_theme_font_override("font", font)
		label1.add_theme_font_size_override("font_size", 22)
		$Contenedor.add_child(label1)
		
		#var label2 = Label.new()
		#label2.add_theme_font_override("font", font)
		#label2.add_theme_font_size_override("font_size", 22)
		#label2.text = resultado["jugador"]
		#$Contenedor.add_child(label2)
		
		var label2 = Label.new()
		label2.add_theme_font_override("font", font)
		label2.add_theme_font_size_override("font_size", 22)
		label2.text = str(resultado["nivel"])
		$Contenedor.add_child(label2)
		
		var label3 = Label.new()
		label3.add_theme_font_override("font", font)
		label3.add_theme_font_size_override("font_size", 22)
		#label3.text = str(resultado["mejor_tiempo"])
		label3.text = str(resultado["duracion"])
		$Contenedor.add_child(label3)
