extends Node2D

var dialogo_actual = 1

func _ready() -> void:
	$AnimationPlayer.play("fade_in")
	$Bocadillo/Dialogo1.show()
	$Bocadillo/Dialogo2.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("continuar"):
		if dialogo_actual == 1:
			$Bocadillo/Dialogo1.hide()
			$Bocadillo/Dialogo2.show()
			dialogo_actual = 2

		elif dialogo_actual == 2:
			$AnimationPlayer.play("fade_out")
			await $AnimationPlayer.animation_finished
			
			Cargador.cargar_escena(
				"res://escenas/MapaAldeaEsmeralda/Animaciones/Entrenamiento/escena_alcalde_tutorial.tscn",
				false
			)
			Cargador.entrar_escena_cargada()
