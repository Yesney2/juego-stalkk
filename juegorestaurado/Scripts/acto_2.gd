extends Node2D

# --- BOTONES (ajustados a tu árbol) ---
@onready var btn_reportar: Button           = $Gcdebotones/Breportar
@onready var btn_escanner: Button           = $Gcdebotones/BEscanner
@onready var btn_menger: Button             = $Gcdebotones/BMenger

# --- AUDIO / TIMER (nombres tal cual en tu escena) ---
@onready var music_bg: AudioStreamPlayer2D  = $MusicBG
@onready var type_sfx: AudioStreamPlayer2D  = $TYpeSFX        # ojo: en tu árbol está con Y mayúscula
@onready var tool_sfx: AudioStreamPlayer2D  = $ToolSFX
@onready var typing_timer: Timer            = $TypingTimer
@onready var voz_audio: AudioStreamPlayer2D = $Pinguino/SonidoDialogo  # opcional

const DIALOGUE_PATH := "res://dialogues/herramientas.dialogue"

# Orden del tutorial: -1=intro, 0=reportar, 1=escáner, 2=menger, >=3=cierre
var tool_step := -1

func _ready() -> void:
	# ----- Orden de dibujo (no truena si faltan) -----
	for name in ["Fgris", "Fazul", "FNegro", "TextureRect3"]:
		var n := get_node_or_null(name)
		if n:
			n.z_index = -100

	var pingu := get_node_or_null("Pinguino")
	if pingu:
		pingu.z_index = 10
		pingu.z_as_relative = false

	# ----- Música de fondo -----
	if music_bg and music_bg.stream:
		music_bg.play()

	# ----- Timer del "tecleo" -----
	if typing_timer and not typing_timer.timeout.is_connected(_on_typing_timer_timeout):
		typing_timer.timeout.connect(_on_typing_timer_timeout)

	# Estado inicial: no grises; sin aceptar clics
	_gate_buttons(false)
	_dim_except(null)

	# ----- Lanza el diálogo -----
	var d: DialogueResource = load(DIALOGUE_PATH)
	# usar "=" (dinámico) o tipo explícito para evitar el error de inferencia
	var balloon: Control = DialogueManager.show_dialogue_balloon(d, "start") as Control
	if balloon:
		if balloon.has_signal("line_started"):
			balloon.connect("line_started", Callable(self, "_on_line_started"))
		if balloon.has_signal("line_finished"):
			balloon.connect("line_finished", Callable(self, "_on_line_finished"))
		if balloon.has_signal("dialogue_finished"):
			balloon.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))

# ================== Señales del Dialogue Manager ==================

func _on_line_started(line) -> void:
	# Efecto de tecleo ON
	if typing_timer:
		typing_timer.start()

	# Avanzamos el orden cuando habla el Agente P
	var texto := (String(line["text"]) if typeof(line) == TYPE_DICTIONARY and line.has("text") else str(line)).strip_edges()
	if texto.begins_with("Agente P:"):
		tool_step += 1

	match tool_step:
		0:
			_dim_except(btn_reportar)
			_flash(btn_reportar)
			_play_tool_sfx()
			_gate_buttons(false)
			_allow_only(btn_reportar)   # permite probar ese botón; quítalo si no quieres
		1:
			_dim_except(btn_escanner)
			_flash(btn_escanner)
			_play_tool_sfx()
			_gate_buttons(false)
			_allow_only(btn_escanner)
		2:
			_dim_except(btn_menger)
			_flash(btn_menger)
			_play_tool_sfx()
			_gate_buttons(false)
			_allow_only(btn_menger)
		_:
			# intro o cierre (todavía no liberar todos)
			_dim_except(null)
			_gate_buttons(false)

func _on_line_finished(_line) -> void:
	if typing_timer:
		typing_timer.stop()

func _on_dialogue_finished() -> void:
	# Al terminar la explicación: todos activos y clickeables
	_dim_except(null)
	_gate_buttons(true)

# ================== Efecto de "tecleo" ==================

func _on_typing_timer_timeout() -> void:
	if type_sfx and type_sfx.stream:
		type_sfx.pitch_scale = randf_range(0.95, 1.05)
		type_sfx.play()

# ================== Utilidades de UI ==================

# No uso 'disabled' (que pone grises). Solo bloqueo clics.
func _gate_buttons(allow: bool) -> void:
	var mode := Control.MOUSE_FILTER_PASS if allow else Control.MOUSE_FILTER_IGNORE
	for b in [btn_reportar, btn_escanner, btn_menger]:
		b.mouse_filter = mode

# Permite clic solo al botón indicado
func _allow_only(btn: Button) -> void:
	for b in [btn_reportar, btn_escanner, btn_menger]:
		b.mouse_filter = Control.MOUSE_FILTER_PASS if b == btn else Control.MOUSE_FILTER_IGNORE

# Atenúa los que no están activos (sin gris feo)
func _dim_except(active: Button) -> void:
	for b in [btn_reportar, btn_escanner, btn_menger]:
		b.modulate = Color(1, 1, 1, 1) if (active == null or b == active) else Color(1, 1, 1, 0.78)
		b.scale = Vector2.ONE

# Efecto "latido" al resaltar
func _flash(btn: Control) -> void:
	if btn == null:
		return
	var tw := create_tween()
	tw.tween_property(btn, "scale", Vector2(1.08, 1.08), 0.16).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tw.tween_property(btn, "scale", Vector2(1, 1), 0.16).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

# SFX de herramienta
func _play_tool_sfx() -> void:
	if tool_sfx and tool_sfx.stream:
		tool_sfx.play()

# ================== Handlers de botones ==================

func _on_breportar_pressed() -> void:
	_play_tool_sfx()
	get_tree().change_scene_to_file("res://Ecenas/Reportar.tscn")

func _on_bescanner_pressed() -> void:
	_play_tool_sfx()
	get_tree().change_scene_to_file("res://Ecenas/Escanner.tscn")

func _on_bmenger_pressed() -> void:
	_play_tool_sfx()
	get_tree().change_scene_to_file("res://Ecenas/Menger.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/acto_3.tscn")

func _on_bregresar_pressed() -> void:
	get_tree().change_scene_to_file("res://Ecenas/menu.tscn")
