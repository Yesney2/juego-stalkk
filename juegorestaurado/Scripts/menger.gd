extends Control



func _on_regresar_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/Startplay.tscn")


func _on_gfer_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/ConFernando.tscn")


func _on_bsacar_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/ConScarllet.tscn")


func _on_pjeni_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/ConJeniffer.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/menu.tscn")
