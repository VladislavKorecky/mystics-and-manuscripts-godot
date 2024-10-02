extends Node


const FIRST_SCENE := "main_menu"
const scenes := {
	"main_menu": preload("res://scenes/main_menu/main_menu.tscn")
}
var current_scene: Node


func _ready() -> void:
	change_scene(FIRST_SCENE)


func change_scene(scene_id: String) -> void:
	"""
	Change the current scene for a new one. Usually called from a signal of the current scene.
	
	Args:
		scene_id (String): ID of the new scene in the scenes dict.
	"""
	
	# remove old scene
	if current_scene != null:
		current_scene.queue_free()
	
	# create the scene
	var instance: Node = scenes[scene_id].instantiate()
	
	# connect the new scene back to this function
	instance.connect("scene_ended", change_scene)
	
	# finalize
	add_child(instance)
	current_scene = instance
