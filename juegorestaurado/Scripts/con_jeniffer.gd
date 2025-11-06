extends Control

@onready var sprite := $AnimatedSprite2D

func _ready() -> void:
	_start_dialogue()

func _start_dialogue() -> void:
	var d: DialogueResource = load("res://dialogues/jeniffer.dialogue")
	if d == null:
		push_error("No se pudo cargar res://dialogues/jeniffer.dialogue")
		return

	# Lanza el globo empezando en el nodo 'start'
	var balloon := DialogueManager.show_dialogue_balloon(d, "start")
	if balloon:
		if balloon.has_signal("dialogue_finished"):
			balloon.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))
		if balloon.has_signal("line_started"):
			balloon.connect("line_started", Callable(self, "_on_line_started"))
		if balloon.has_signal("line_finished"):
			balloon.connect("line_finished", Callable(self, "_on_line_finished"))

func _on_dialogue_finished() -> void:
	print("Diálogo terminado")

func _on_line_started(_line) -> void:
	# Aquí puedes animar a Jeniffer, reproducir un sonido, etc.
	# if sprite: sprite.play("hablar")
	pass

func _on_line_finished(_line) -> void:
	# if sprite: sprite.play("idle")
	pass



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/Menger.tscn")
