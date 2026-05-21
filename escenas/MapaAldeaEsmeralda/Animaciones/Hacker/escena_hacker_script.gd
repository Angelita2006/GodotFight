extends Node2D
@onready var dialogo1: RichTextLabel =  $Dialogo1
@onready var dialogo2: RichTextLabel =  $Dialogo2
var dialogo_actual = 1

func _ready() -> void:
	$AnimationPlayer.play("fade_in")
	dialogo1.visible_characters = 0
	dialogo1.show()
	var tween = create_tween()
	tween.tween_property(dialogo1, "visible_characters", dialogo1.get_total_character_count(), 2)
	dialogo2.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("continuar"):
		if dialogo_actual == 1:
			dialogo1.hide()
			dialogo2.visible_characters = 0
			dialogo2.show()
			var tween = create_tween()
			tween.tween_property(dialogo2, "visible_characters", dialogo2.get_total_character_count(), 2)
			dialogo_actual = 2

		elif dialogo_actual == 2:
			$AnimationPlayer.play("fade_out")
			# ir al nivel-tutorial
			Cargador.cargar_escena("uid://re7e6jr62tda", false)
			await $AnimationPlayer.animation_finished
			Cargador.entrar_escena_cargada()
