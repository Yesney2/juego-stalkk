extends Node2D

@onready var pinguino: AnimatedSprite2D = $Pinguino
@onready var sonido_dialogo := $Pinguino.get_node_or_null("SonidoDialogo")
@onready var boton_siguiente: Button = $Siguiente
@onready var panel_dialogo: PanelContainer = $CanvasLayer/PanelContainer

var balloon  # nodo del diálogo

func _ready() -> void:
	# Cargar progreso
	GameData.cargar()

	# Guardar que estamos en acto_1 (por si el jugador se queda aquí)
	GameData.ultima_escena = "res://Ecenas/acto_1.tscn"
	GameData.guardar()

	# Ocultar panel de diálogo si existe
	if panel_dialogo:
		panel_dialogo.visible = false

	# Iniciar animación del pingüino
	pinguino.animation = "Saludo"
	pinguino.frame = 0
	pinguino.stop()

	# Cargar el recurso de diálogo
	var recurso_dialogo: DialogueResource = load("res://dialogues/AgenteP.dialogue")
	balloon = DialogueManager.show_dialogue_balloon(recurso_dialogo, "start")

	# Conectar señales del diálogo
	if balloon:
		if balloon.has_signal("dialogue_finished"):
			balloon.dialogue_finished.connect(_on_dialogue_finished)
		if balloon.has_signal("line_started"):
			balloon.line_started.connect(_on_line_started)
		if balloon.has_signal("line_finished"):
			balloon.line_finished.connect(_on_line_finished)
		if balloon.has_signal("line_skipped"):
			balloon.line_skipped.connect(_on_line_skipped)


func _on_line_started(_line) -> void:
	# Reproduce sonido si el nodo existe
	if sonido_dialogo:
		if sonido_dialogo.is_playing():
			sonido_dialogo.stop()
		sonido_dialogo.play()

	# Cambia al siguiente frame del pingüino
	var total_frames = pinguino.sprite_frames.get_frame_count(pinguino.animation)
	pinguino.frame = (pinguino.frame + 1) % total_frames


func _on_line_finished(_line) -> void:
	pass


func _on_line_skipped(_line) -> void:
	pass


func _on_dialogue_finished() -> void:
	# Marcar que ya vimos la intro al terminar este diálogo
	GameData.intro_vista = true
	GameData.ultima_escena = "res://Ecenas/acto_1.tscn"
	GameData.guardar()
	# Aquí puedes habilitar botones, etc., si hace falta


func _on_siguiente_pressed() -> void:
	# Pasar a la siguiente escena de instrucciones
	get_tree().change_scene_to_file("res://Ecenas/acto_2.tscn")


func _on_regresar_pressed() -> void:
	# Volver al menú
	get_tree().change_scene_to_file("res://Ecenas/menu.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/menu.tscn")
