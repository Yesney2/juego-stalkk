extends Node2D

# (Opcional) si vas a usar el botón "Siguiente" para pasar a la siguiente escena cuando acabe el diálogo
@onready var boton_siguiente: Button = $Siguiente

func _ready() -> void:
	# Desactiva el botón hasta que termine el diálogo (opcional)
	if is_instance_valid(boton_siguiente):
		boton_siguiente.disabled = true

	# Carga el recurso de diálogo y lo muestra
	var d: DialogueResource = load("res://dialogues/Pingu.dialogue")
	# "start" es el título del nodo de inicio en el .dialogue
	DialogueManager.show_dialogue(d, "start")

	# Conecta señales del Dialogue Manager
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_line_started.connect(_on_dialogue_line_started)
	DialogueManager.dialogue_line_finished.connect(_on_dialogue_line_finished)

func _on_dialogue_started() -> void:
	# Aquí podrías ocultar tu PanelContainer viejo, si lo sigues teniendo en escena
	if has_node("CanvasLayer/PanelContainer"):
		$CanvasLayer/PanelContainer.visible = false

func _on_dialogue_line_started(_line) -> void:
	# Se dispara cuando se muestra una línea (por si quieres animar al pingüino)
	pass

func _on_dialogue_line_finished(_line) -> void:
	# Se dispara cuando termina de imprimirse una línea
	pass

func _on_dialogue_ended() -> void:
	# Reactiva el botón y/o pasa a la siguiente escena
	if is_instance_valid(boton_siguiente):
		boton_siguiente.disabled = false
	# Si quieres cambiar automáticamente de escena al terminar:
	# get_tree().change_scene_to_file("res://Ecenas/acto_2.tscn")

# Si sigues usando el botón "Siguiente" manual:
func _on_siguiente_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/acto_2.tscn")
