extends Control
var config = ConfigFile.new()
@export var idioma: VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	config.load("user://config.cfg")
	var idiomaConf = config.get_value("config","idioma","es")
	TranslationServer.set_locale(idiomaConf)
	_iniciar_animacion()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _iniciar_animacion():
	var tween: Tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "position:y", position.y - 4, 0.35).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y + 4, 0.35).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

func guardar_idioma(idiomaLanguage):
	config.set_value("config","idioma",idiomaLanguage)
	config.save("user://config.cfg")

func _on_idioma_item_selected(index: int) -> void:
	match index:
		0:
			TranslationServer.set_locale("es")
			guardar_idioma("es")
		1:
			TranslationServer.set_locale("en")
			guardar_idioma("en")

func _on_idioma_pressed() -> void:
	idioma.show()
