extends Control

@onready var slider: HSlider = $VBoxContainer/Volumen
@onready var check_mute: CheckBox = $VBoxContainer/CheckBox
@onready var music: AudioStreamPlayer = $AudioStreamPlayer

var volume_value: float = 1.0  # valor local por ahora, sin GameData


func _ready() -> void:
	print("CONFIG LISTA")

	# Configurar el slider
	slider.min_value = 0.0
	slider.max_value = 1.0
	slider.step = 0.01

	# Valor inicial: volumen máximo
	volume_value = 1.0
	slider.value = volume_value

	# Aplicar volumen inicial a la música
	_aplicar_volumen(volume_value)

	# CheckBox desmarcado (no mute)
	check_mute.button_pressed = false


func _on_Volumen_value_changed(value: float) -> void:
	# El slider manda 0.0–1.0
	volume_value = clamp(value, 0.0, 1.0)
	print("Slider:", volume_value)

	_aplicar_volumen(volume_value)

	# Si el valor es casi 0, activamos mute visualmente
	check_mute.button_pressed = (volume_value <= 0.001)


func _aplicar_volumen(value: float) -> void:
	if value <= 0.001:
		# Casi silencio total
		music.volume_db = -80.0
	else:
		# Curva para que se note más el cambio
		var curved: float = value * value        # 0–1
		var db: float = lerp(-30.0, 0.0, curved) # 0 → -30 dB, 1 → 0 dB
		music.volume_db = db

	print("Volumen slider:", value, " -> dB:", music.volume_db)


func _on_CheckBox_toggled(toggled_on: bool) -> void:
	print("Check:", toggled_on)

	if toggled_on:
		# Mute
		music.volume_db = -80.0
	else:
		# Recuperar según la posición del slider
		_aplicar_volumen(slider.value)


func _on_Back_pressed() -> void:
	print("Back PRESIONADO")
	get_tree().change_scene_to_file("res://Ecenas/menu.tscn")


func _on_Salir_pressed() -> void:
	print("Salir PRESIONADO")
	get_tree().quit()
