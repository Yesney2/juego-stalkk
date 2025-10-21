extends Node2D

@onready var dialog_container := $CanvasLayer/PanelContainer

func _ready() -> void:
	var dialog_lines := [
		"¡Soy el Agente P.",

	]
	dialog_container.start_dialog(dialog_lines)
	dialog_container.dialog_finished.connect(Callable(self, "_on_dialog_finished"))

func _on_dialog_finished() -> void:
	print("Diálogo terminado — activar la jugabilidad")



func _on_siguiente_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/acto_2.tscn")
