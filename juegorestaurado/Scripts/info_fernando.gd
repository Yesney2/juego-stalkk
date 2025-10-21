extends Node2D

func _on_menger_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/ConFernando.tscn")

func _on_bregresar_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/acto_3.tscn")
