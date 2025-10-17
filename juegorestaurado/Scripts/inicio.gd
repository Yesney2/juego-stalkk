extends Control
@onready var btn :=$Button

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/menu.tscn")
