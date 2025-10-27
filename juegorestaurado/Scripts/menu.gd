extends Control

func _ready() -> void:
	# Conectamos los botones (solo si no están ya conectados desde el editor)
	if not $VBoxContainer/Bjugar.pressed.is_connected(_on_bjugar_pressed):
		$VBoxContainer/Bjugar.pressed.connect(_on_bjugar_pressed)
	if not $VBoxContainer/Bopcciones.pressed.is_connected(_on_bopcciones_pressed):
		$VBoxContainer/Bopcciones.pressed.connect(_on_bopcciones_pressed)
	if not $VBoxContainer/Salir.pressed.is_connected(_on_salir_pressed):
		$VBoxContainer/Salir.pressed.connect(_on_salir_pressed)

func _on_bjugar_pressed() -> void:
	$VBoxContainer/Bjugar/AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://Ecenas/acto_1.tscn")

func _on_bopcciones_pressed() -> void:
	$VBoxContainer/Bopcciones/AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://Ecenas/config.tscn")

func _on_salir_pressed() -> void:
	$VBoxContainer/Salir/AudioStreamPlayer.play()
	get_tree().quit()
