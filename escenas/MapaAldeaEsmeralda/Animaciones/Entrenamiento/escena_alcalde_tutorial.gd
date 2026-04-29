extends Node2D

var dialogo_actual = 1

func _ready() -> void:
	$AnimationPlayer.play("fade_in")
	$Dialogo1.show()
	$Dialogo2.hide()
	$Dialogo3.hide()
	$Dialogo4.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("continuar"):

		if dialogo_actual == 1:
			$Dialogo1.hide()
			$Dialogo2.show()
			dialogo_actual = 2

		elif dialogo_actual == 2:
			$Dialogo2.hide()
			$Dialogo3.show()
			dialogo_actual = 3

		elif dialogo_actual == 3:
			$Dialogo3.hide()
			$Dialogo4.show()
			$Avanzar.text = "¡Vamos! (Pulsa Enter)"
			dialogo_actual = 4

		elif dialogo_actual == 4:
			$AnimationPlayer.play("fade_out")
			await $AnimationPlayer.animation_finished
			Cargador.cargar_escena("res://escenas/Niveles/tutorial.tscn", false)
			Cargador.entrar_escena_cargada()
