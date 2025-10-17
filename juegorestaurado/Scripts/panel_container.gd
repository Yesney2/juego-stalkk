extends PanelContainer

@onready var dialog_label := $DialogLabel   # Asegúrate que el hijo se llame EXACTAMENTE "DialogLabel"

var dialog_lines: Array = []
var current_index := 0

signal dialog_finished

func start_dialog(lines: Array) -> void:
	dialog_lines = lines
	current_index = 0
	_show_line()

func _show_line() -> void:
	if current_index < dialog_lines.size():
		dialog_label.text = str(dialog_lines[current_index])
	else:
		emit_signal("dialog_finished")

func next_line() -> void:
	current_index += 1
	_show_line()
