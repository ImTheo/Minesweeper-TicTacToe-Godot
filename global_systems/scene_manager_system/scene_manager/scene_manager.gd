extends Node
@onready var packed_scene := PackedScene.new()

func change_instanced_scene(new_scene:Node):
	var current_node = get_node("/root/Main")
	remove_node_children(current_node)
	(current_node as Node).add_child(new_scene)

func remove_node_children(node:Node):
	for ii in (node as Node).get_children(true):
		ii.queue_free()

func change_loaded_scene(new_scene:Node):
	packed_scene.pack(new_scene)
	get_tree().change_scene_to_packed(packed_scene)
