extends Node2D

const DIALOGUE_PATH := "res://dialogues/Información.dialogue"

func _ready() -> void:
	# Cargar progreso
	GameData.cargar()

	# Guardar que estamos en acto_3
	GameData.ultima_escena = "res://Ecenas/acto_3.tscn"
	GameData.guardar()

	# Cargar diálogo
	var d: DialogueResource = load(DIALOGUE_PATH)

	# Mostrar el balloon del Dialogue Manager
	var balloon: Control = DialogueManager.show_dialogue_balloon(d, "start") as Control

	# Conectar señales
	if balloon:
		if balloon.has_signal("line_started"):
			balloon.connect("line_started", Callable(self, "_on_line_started"))
		if balloon.has_signal("line_finished"):
			balloon.connect("line_finished", Callable(self, "_on_line_finished"))
		if balloon.has_signal("dialogue_finished"):
			balloon.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))


func _on_line_started(line) -> void:
	var texto := (
		String(line["text"]) 
		if typeof(line) == TYPE_DICTIONARY and line.has("text") 
		else str(line)
	).strip_edges()
	print("[acto_3] line_started: ", texto)


func _on_line_finished(_line) -> void:
	pass


func _on_dialogue_finished() -> void:
	print("[acto_3] diálogo terminado")


# =========================
#      BOTONES DEL MENU
# =========================

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


# =========================
#  BOTÓN FINAL "INICIAR"
# =========================

func _on_iniciar_pressed() -> void:
	# Marcar que ya vio TODAS las instrucciones
	GameData.instrucciones_vistas = true
	GameData.guardar()

	# Ver si venía desde JUGAR o desde INSTRUCCIONES del menú
	var destino: String = GameData.escena_despues_instrucciones

	# Si el destino está vacío, entra al juego normal
	if destino == "":
		destino = "res://Ecenas/Startplay.tscn"

	# Limpiar variable para evitar conflictos
	GameData.escena_despues_instrucciones = ""
	GameData.guardar()

	# Cambiar a la escena correspondiente
	get_tree().change_scene_to_file(destino)
