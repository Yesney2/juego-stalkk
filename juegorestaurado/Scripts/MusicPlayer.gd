extends Node

const BUS_INDEX := 0  # 0 = Master, si usas otro bus lo cambiamos luego

var volume: float = 1.0
var muted: bool = false

func _ready() -> void:
	_apply_volume()
	_apply_mute()

func set_volume(v: float) -> void:
	# Espera valores entre 0.0 y 1.0
	volume = clamp(v, 0.0, 1.0)
	_apply_volume()

func set_muted(m: bool) -> void:
	muted = m
	_apply_mute()

func _apply_volume() -> void:
	var db := -80.0  # silencio
	if volume > 0.0:
		db = linear_to_db(volume)
	AudioServer.set_bus_volume_db(BUS_INDEX, db)

func _apply_mute() -> void:
	AudioServer.set_bus_mute(BUS_INDEX, muted)
