extends Node2D

func _ready() -> void:
	# Oculta tu PanelContainer viejo si no lo quieres encima
	if has_node("CanvasLayer/PanelContainer"):
		$CanvasLayer/PanelContainer.visible = false

	var d: DialogueResource = load("res://dialogues/AgenteP.dialogue")
	var balloon := DialogueManager.show_dialogue_balloon(d, "start")
	if balloon:
		# Conecta solo las señales que existan en tu versión
		if balloon.has_signal("dialogue_finished"):
			balloon.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))
		if balloon.has_signal("line_started"):
			balloon.connect("line_started", Callable(self, "_on_line_started"))
		if balloon.has_signal("line_finished"):
			balloon.connect("line_finished", Callable(self, "_on_line_finished"))


func _on_dialogue_finished() -> void:
	print("Diálogo terminado")

func _on_line_started(_line) -> void:
	# Aquí puedes animar al pingüino cuando arranca una línea
	pass

func _on_line_finished(_line) -> void:
	# Aquí cuando termina de escribirse una línea
	pass
	
