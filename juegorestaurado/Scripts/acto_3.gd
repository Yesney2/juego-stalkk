extends Node2D

const DIALOGUE_PATH := "res://dialogues/Información.dialogue"

func _ready() -> void:
	# 1) Cargar el recurso de diálogo
	var d: DialogueResource = load(DIALOGUE_PATH)

	# 2) Mostrar el balloon desde el nodo "start"
	#    (tipado explícito para evitar el error de inferencia en Godot 4)
	var balloon: Control = DialogueManager.show_dialogue_balloon(d, "start") as Control

	# 3) Conectar señales del balloon
	if balloon:
		if balloon.has_signal("line_started"):
			balloon.connect("line_started", Callable(self, "_on_line_started"))
		if balloon.has_signal("line_finished"):
			balloon.connect("line_finished", Callable(self, "_on_line_finished"))
		if balloon.has_signal("dialogue_finished"):
			balloon.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))

func _on_line_started(line) -> void:
	# Reacciona a cada línea (mover sprites, sfx, etc.)
	var texto := (String(line["text"]) if typeof(line) == TYPE_DICTIONARY and line.has("text") else str(line)).strip_edges()
	print("[acto_3] line_started: ", texto)

func _on_line_finished(_line) -> void:
	# Cuando termina de escribirse la línea
	pass

func _on_dialogue_finished() -> void:
	# Cuando termina TODO el diálogo
	print("[acto_3] diálogo terminado")
	# Ejemplo: pasar a la siguiente escena
	# get_tree().change_scene_to_file("res://Ecenas/acto_4.tscn")


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

func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/Startplay.tscn")
