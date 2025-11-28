extends Node

const SAVE_PATH := "user://savegame.save"

# Progreso del juego
var intro_vista: bool = false
var ultima_escena: String = "res://Ecenas/Startplay.tscn"
# Se puede cambiar la ruta

# Instrucciones 
var instrucciones_vistas: bool = false
var escena_despues_instrucciones: String = ""

#para el volumen.
var volumen_master: float = 1.0

func guardar() -> void:
	var data := {
		"intro_vista": intro_vista,
		"ultima_escena": ultima_escena,
		"instrucciones_vistas": instrucciones_vistas,
		"volumen_master" : volumen_master,
		
	}

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()


func cargar() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var text := file.get_as_text()
		file.close()

		var result = JSON.parse_string(text)
		if typeof(result) == TYPE_DICTIONARY:
			intro_vista = result.get("intro_vista", false)
			ultima_escena = result.get("ultima_escena", "res://Ecenas/Startplay.tscn")
			instrucciones_vistas = result.get("instrucciones_vistas", false)
			volumen_master = result.get("volumen_master", 1.0)
