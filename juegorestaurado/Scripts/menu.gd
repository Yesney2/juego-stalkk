extends Control

func _ready() -> void:
	GameData.cargar()


func _on_bjugar_pressed() -> void:
	$VBoxContainer/Bjugar/AudioStreamPlayer.play()
	GameData.cargar()

	if not GameData.instrucciones_vistas:
		# Primera vez -> ver TODAS las instrucciones (acto_1, acto_2, acto_3...)
		# Cuando terminen las instrucciones, queremos ir a Startplay
		GameData.escena_despues_instrucciones = "res://Ecenas/Startplay.tscn"
		GameData.guardar()

		get_tree().change_scene_to_file("res://Ecenas/acto_1.tscn")
	else:
		# Ya vio instrucciones -> SIEMPRE empezar en Startplay
		GameData.ultima_escena = "res://Ecenas/Startplay.tscn"
		GameData.guardar()
		get_tree().change_scene_to_file(GameData.ultima_escena)


func _on_instrucciones_pressed() -> void:
	$VBoxContainer/Instrucciones/AudioStreamPlayer.play()
	GameData.cargar()

	# Vino desde el botón INSTRUCCIONES -> al terminar, regresar al menú
	GameData.escena_despues_instrucciones = "res://Ecenas/menu.tscn"
	GameData.guardar()

	get_tree().change_scene_to_file("res://Ecenas/acto_1.tscn")


func _on_bopcciones_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/config.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()
