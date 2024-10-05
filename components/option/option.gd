@tool
extends PanelContainer


# A unique string for referrencing this option. (displayed on left side)
@export var identifier: String
# Text describing the option.
@export var content: String
# Adds a background highlight when true.
@export var highlighted: bool


func _ready() -> void:
	update()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		update()


func update() -> void:
	"""
	Update the option's appearance.
	"""
	
	(%Label as Label).text = "%s. %s" % [identifier, content]
	(%Label as Label).set("theme_override_colors/font_color", Color("0a0a0a") if highlighted else Color("fafafa"))
	%Background.visible = highlighted
