extends Node2D

# Referencias a los sonidos (si no existen, quedarán en null)
@onready var snd_scarlett = $Sonidobscarlett
@onready var snd_jeniffer = $Sonidobjeniffer
@onready var snd_fernando = $Sonidobfernando
@onready var snd_click = get_node_or_null("SonidoClick")  # ← sin ternario

# Utilidad: reproducir sonido (si hay) y luego cambiar de escena
func _play_and_switch(player, scene_path: String) -> void:
	if player:
		player.stop()
		player.play()
		var wait_time := 0.12
		if player.stream:
			var len = player.stream.get_length()
			if len > 0.0:
				wait_time = min(len, 0.15)
		await get_tree().create_timer(wait_time).timeout

	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_error("Escena no encontrada: " + scene_path)

func _on_bscarlett_pressed() -> void:
	_play_and_switch(snd_scarlett, "res://Ecenas/info_Scarlett.tscn")

func _on_bjeniffer_pressed() -> void:
	_play_and_switch(snd_jeniffer, "res://Ecenas/info_Jeniffer.tscn")

func _on_bfernando_pressed() -> void:
	_play_and_switch(snd_fernando, "res://Ecenas/info_Fernando.tscn")

func _on_bregresar_pressed() -> void:
	_play_and_switch(snd_click, "res://Ecenas/menu.tscn")

func _on_breportar_pressed() -> void:
	_play_and_switch(snd_click, "res://Ecenas/Reportar.tscn")

func _on_b_escanner_pressed() -> void:
	_play_and_switch(snd_click, "res://Ecenas/Escanner.tscn")

func _on_b_menger_pressed() -> void:
	_play_and_switch(snd_click, "res://Ecenas/Menger.tscn")

func _on_iniciar_pressed() -> void:
	_play_and_switch(snd_click, "res://Ecenas/Startplay.tscn")
