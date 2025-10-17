extends Node2D

@onready var dialog_container := $CanvasLayer/PanelContainer

func _ready() -> void:
	var dialog_lines := [
		"¡Soy el Agente P.",
		"Aquí empieza nuestra historia...",
		"Pulsa clic o Enter para continuar."
	]
	dialog_container.start_dialog(dialog_lines)
	dialog_container.dialog_finished.connect(Callable(self, "_on_dialog_finished"))

func _on_dialog_finished() -> void:
	print("Diálogo terminado — activar la jugabilidad")
