extends CanvasLayer


signal scene_ended(scene_id: String)


func _ready() -> void:
	%Menu.add_option("1", "Uno")
	%Menu.add_option("2", "Dos")
	%Menu.add_option("e", "Exit")


func _on_menu_option_selected(identifier: String) -> void:
	print(identifier)
