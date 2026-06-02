extends Control
@export var idioma: VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_iniciar_animacion()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _iniciar_animacion():
	var tween: Tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "position:y", position.y - 4, 0.35).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y + 4, 0.35).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

func _on_idioma_pressed() -> void:
	idioma.show()
