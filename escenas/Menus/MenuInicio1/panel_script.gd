extends Panel

@onready var tabla := $Contenedor

func _ready() -> void:
	Database.crear_tablas_si_no_existen()
	#Database.reiniciar_datos()
	#Database.insertar_datos_ejemplo()
	mostrar_ranking()

func mostrar_ranking():
	
	var resultados = Database.obtener_todo()
	
	# Limpiar filas anteriores (dejando cabecera)
	var index = 0
	for resultado in resultados:
		index += 1
		var label1 = Label.new()
		label1.text = str(index)
		var font = load("res://assets/ui/fuentes/Pixuf.ttf")
		label1.add_theme_font_override("font", font)
		label1.add_theme_font_size_override("font_size", 22)
		label1.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		$Contenedor.add_child(label1)
		
		var label2 = Label.new()
		label2.add_theme_font_override("font", font)
		label2.add_theme_font_size_override("font_size", 22)
		if resultado["nivel"] == 10:
			label2.text = "Parque"
		elif resultado["nivel"] == 11:
			label2.text = "Biblioteca"
		elif resultado["nivel"] == 12:
			label2.text = "Mercao"
		elif resultado["nivel"] == 13:
			label2.text = "Banco"
		elif resultado["nivel"] == 14:
			label2.text = "Ayuntamiento"
		label2.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		$Contenedor.add_child(label2)
		
		var label3 = Label.new()
		label3.add_theme_font_override("font", font)
		label3.add_theme_font_size_override("font_size", 22)
		var minutos: int = int(resultado["duracion"] / 60)
		var segundos: int = int(resultado["duracion"]) % 60
		var tiempo_formateado: String = "%02d:%02d" % [minutos, segundos]
		label3.text = tiempo_formateado
		label3.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		$Contenedor.add_child(label3)
