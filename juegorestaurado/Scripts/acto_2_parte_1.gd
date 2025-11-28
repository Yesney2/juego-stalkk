extends Node2D

var dialogue_res: DialogueResource

func _ready() -> void:
	dialogue_res = load("res://dialogues/acto_2_parte1.dialogue")
	if dialogue_res == null:
		push_error("No se pudo cargar el diálogo.")
		return
	
	if has_node("siguiente"):
		$siguiente.disabled = true
	
	_start_dialogue()


func _start_dialogue() -> void:
	var balloon := DialogueManager.show_dialogue_balloon(dialogue_res, "start")
	
	if balloon:
		if balloon.has_signal("dialogue_finished"):
			balloon.dialogue_finished.connect(_on_dialogue_finished)
		else:
			push_warning("El balloon no tiene la señal 'dialogue_finished'.")
	else:
		push_error("No se pudo crear el balloon.")


func _on_dialogue_finished() -> void:
	if has_node("siguiente"):
		$siguiente.disabled = false
	print("Diálogo acto_2_parte1 terminado.")


func _on_bregresar_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/acto_2.tscn")


func _on_siguiente_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/acto2_parte1_2.tscn")
