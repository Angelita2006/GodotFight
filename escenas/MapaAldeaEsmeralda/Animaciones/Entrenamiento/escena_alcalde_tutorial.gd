extends Node2D
@onready var dialogo1: RichTextLabel = $Dialogo1
@onready var dialogo2: RichTextLabel = $Dialogo2
@onready var dialogo3: RichTextLabel = $Dialogo3
@onready var dialogo4: RichTextLabel = $Dialogo4
var dialogo_actual = 1

func _ready() -> void:
	$AnimationPlayer.play("fade_in")
	dialogo1.visible_characters = 0
	dialogo1.show()
	var tween = create_tween()
	tween.tween_property(dialogo1, "visible_characters", dialogo1.get_total_character_count(), 2)
	dialogo2.hide()
	dialogo3.hide()
	dialogo4.hide()

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
			dialogo2.hide()
			dialogo3.visible_characters = 0
			dialogo3.show()
			var tween = create_tween()
			tween.tween_property(dialogo3, "visible_characters", dialogo3.get_total_character_count(), 2)
			dialogo_actual = 3

		elif dialogo_actual == 3:
			dialogo3.hide()
			dialogo4.visible_characters = 0
			dialogo4.show()
			var tween = create_tween()
			tween.tween_property(dialogo4, "visible_characters", dialogo4.get_total_character_count(), 2)
			$Avanzar.text = "¡Vamos! (Pulsa Enter)"
			dialogo_actual = 4

		elif dialogo_actual == 4:
			$AnimationPlayer.play("fade_out")
			#Cargador.cargar_escena("res://escenas/Niveles/tutorial.tscn", false)
			Cargador.cargar_escena("res://escenas/MapaAldeaEsmeralda/Animaciones/Hacker/escena_hacker.tscn", false)
			await $AnimationPlayer.animation_finished
			Cargador.entrar_escena_cargada()
