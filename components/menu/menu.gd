extends VBoxContainer


const option_scene: PackedScene = preload("res://components/option/option.tscn")

# index of a currently selected option
var selected_index: int
# index of the currently highlighted option
var highlighted_index: int


# triggers when a user selects an option
signal option_selected(identifier: String)


func _ready() -> void:
	update_display()


func update_display() -> void:
	"""
	Update the highlighting to correctly match the selected option.
	"""
	
	# prevents index-out-of-bounds error when updating and empty menu
	if len(get_children()) == 0:
		return
	
	# turn off the highlight of the old option
	var prev_option := get_children()[highlighted_index]
	prev_option.highlighted = false
	prev_option.update()
	
	# turn on the highlight for the new item
	var option := get_children()[selected_index]
	option.highlighted = true
	option.update()
	
	# sync the indeces
	highlighted_index = selected_index


func add_option(identifier: String, content: String) -> void:
	"""
	Add a new option at the end of the menu.
	
	Args:
		identifier (String): Identifier of the option.
		content (String): Content of the option.
	"""
	
	# construct the node
	var option_instance := option_scene.instantiate()
	option_instance.identifier = identifier
	option_instance.content = content
	option_instance.update()
	add_child(option_instance)
	
	update_display()


func _increment_index(amount: int) -> void:
	"""
	Increment the index of the selected option.
	
	Args:
		amount (int): Amount by which to increment the index. Can be negative.
	"""
	
	# increment and bound the index
	selected_index = (selected_index + amount) % len(get_children())
	
	update_display()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		_increment_index(-1) 
	
	if Input.is_action_just_pressed("down"):
		_increment_index(1)
		
	if Input.is_action_just_pressed("submit"):
		var selected_option := get_children()[selected_index]
		option_selected.emit(selected_option.identifier)
