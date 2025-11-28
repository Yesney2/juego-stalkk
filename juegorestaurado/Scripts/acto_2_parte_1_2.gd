extends Node2D

var dialogue_res: DialogueResource

func _ready() -> void:
	# Cargar el recurso de diálogo de esta escena
	dialogue_res = load("res://dialogues/acto2_parte1_2.dialogue")
	
	if dialogue_res == null:
		push_error("No se pudo cargar el diálogo: res://dialogues/acto2_parte1_2.dialogue")
		return
	
	# Desactivar botón siguiente mientras hay diálogo
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
		push_error("No se pudo crear el balloon en acto2_parte1_2.")


func _on_dialogue_finished() -> void:
	if has_node("siguiente"):
		$siguiente.disabled = false
	print("Diálogo acto2_parte1_2 terminado.")


func _on_bregresar_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/acto_2_parte1.tscn") # cambia si tu escena anterior se llama distinto


func _on_siguiente_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/acto_2_parte2.tscn") # siguiente escena


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/menu.tscn")
