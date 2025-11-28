extends Node2D

var dialogue_res: DialogueResource

func _ready() -> void:
	# Cargar recurso de diálogo
	dialogue_res = load("res://dialogues/reportar_incorrecto.dialogue")
	
	if dialogue_res == null:
		push_error("No se pudo cargar el diálogo: res://dialogues/reportar_incorrecto.dialogue")
		return
	
	if has_node("newgame"):
		$newgame.disabled = true
	
	_start_dialogue()


func _start_dialogue() -> void:
	var balloon := DialogueManager.show_dialogue_balloon(dialogue_res, "start")
	
	if balloon:
		if balloon.has_signal("dialogue_finished"):
			balloon.dialogue_finished.connect(_on_dialogue_finished)
		else:
			push_warning("El balloon no tiene la señal 'dialogue_finished'.")
	else:
		push_error("No se pudo crear el balloon en reportar_incorrecto.")


func _on_dialogue_finished() -> void:
	if has_node("newgame"):
		$newgame.disabled = false
	print("Diálogo de reportar_incorrecto terminado.")
