extends Node2D

# Botones de los sospechosos
@onready var b_scarlett: BaseButton = $Gcperfiles/BScarlett
@onready var b_jeniffer: BaseButton = $Gcperfiles/BJeniffer
@onready var b_fernando: BaseButton = $Gcperfiles/BFernando
@onready var b_agente_p: BaseButton = $BAgenteP

# Botón de reportar y label de resultado
@onready var b_reportar: BaseButton = $Iniciar
@onready var lbl_resultado: Label = $Label

# Lista de nombres seleccionados
var seleccionados: Array[String] = []


func _ready() -> void:
	lbl_resultado.text = ""

	# Conectamos cada botón con su nombre + el botón mismo
	b_scarlett.pressed.connect(_on_sospechoso_pressed.bind("Scarlett", b_scarlett))
	b_jeniffer.pressed.connect(_on_sospechoso_pressed.bind("Jeniffer", b_jeniffer))
	b_fernando.pressed.connect(_on_sospechoso_pressed.bind("Fernando", b_fernando))
	b_agente_p.pressed.connect(_on_sospechoso_pressed.bind("AgenteP", b_agente_p))

	b_reportar.pressed.connect(_on_reportar_pressed)


func _on_sospechoso_pressed(nombre: String, boton: BaseButton) -> void:
	if nombre in seleccionados:
		seleccionados.erase(nombre)
		_resaltar(boton, false)
	else:
		seleccionados.append(nombre)
		_resaltar(boton, true)

	print("Seleccionados ahora:", seleccionados)


func _resaltar(boton: BaseButton, activo: bool) -> void:
	# Limpiar estilos anteriores
	boton.remove_theme_stylebox_override("normal")

	if activo:
		var style := StyleBoxFlat.new()
		style.set_border_width_all(12)                   # ← grosor del borde
		style.border_color = Color(1, 0, 0, 1)           # rojo
		style.bg_color = Color(0, 0, 0, 0.0)             # fondo totalmente transparente
		style.set_corner_radius_all(16)                  # esquinas redondeadas (opcional)
		boton.add_theme_stylebox_override("normal", style)
	else:
		boton.modulate = Color(1, 1, 1, 1)


func _on_reportar_pressed() -> void:
	var correcto := (
		"Scarlett" in seleccionados
		and "AgenteP" in seleccionados
		and seleccionados.size() == 2
	)

	if correcto:
		lbl_resultado.text = ""
		# Espera 1.5 segundos para que alcance a leer el mensaje
		await get_tree().create_timer(0).timeout
		get_tree().change_scene_to_file("res://Ecenas/reportar_correcto.tscn")
	else:
		lbl_resultado.text = ""
		await get_tree().create_timer(0).timeout
		get_tree().change_scene_to_file("res://Ecenas/reportar_incorrecto.tscn")
