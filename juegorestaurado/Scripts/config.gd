extends Control


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"),linear_to_db(value))
	AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Musica"))


func _on_salir_pressed() -> void:
	get_tree().quit()
	

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/menu.tscn")
