extends Node2D


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/acto_3.tscn")

func _on_breportar_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/Reportar.tscn")

func _on_bmenger_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/Menger.tscn")

func _on_bescanner_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/Escanner.tscn")
