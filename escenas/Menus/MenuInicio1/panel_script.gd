extends Panel

@onready var tabla := $Contenedor

func _ready() -> void:
	if Database.abrir_db():
		Database.crear_tablas_si_no_existen()
		mostrar_ranking()
		Database.db.close_db()

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
		$Contenedor.add_child(label1)
		
		var label2 = Label.new()
		label2.add_theme_font_override("font", font)
		label2.add_theme_font_size_override("font_size", 22)
		label2.text = str(resultado["nivel"])
		$Contenedor.add_child(label2)
		
		var label3 = Label.new()
		label3.add_theme_font_override("font", font)
		label3.add_theme_font_size_override("font_size", 22)
		label3.text = str(resultado["duracion"])
		$Contenedor.add_child(label3)
