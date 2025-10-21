extends Node2D
func _on_bscarlett_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/info_Scarlett.tscn")

func _on_bjeniffer_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/info_Jeniffer.tscn")

func _on_bfernando_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/info_Fernando.tscn")

func _on_bregresar_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/menu.tscn")

func _on_breportar_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/Reportar.tscn")

func _on_b_escanner_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/Escanner.tscn")

func _on_b_menger_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/Menger.tscn")
