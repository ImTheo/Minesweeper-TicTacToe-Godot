extends Node

@onready var current = get_tree().current_scene
@onready var tree:SceneTree = get_tree()

var node_sended:Node

func change_instanced_scene(current_node,new_scene:Node):
	remove_node_and_children(current_node)
	get_tree().current_scene = new_scene
	(current_node as Node).name = new_scene.name
	(current_node as Node).add_child(new_scene)

func remove_node_and_children(node:Node):
	for i in (node as Node).get_children(true):
		i.queue_free()
