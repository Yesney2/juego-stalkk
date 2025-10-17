extends Control

func _on_salir_config_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
