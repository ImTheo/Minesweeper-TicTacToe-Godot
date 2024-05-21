extends Node
@onready var packed_scene := PackedScene.new()
@onready var current_scene = get_tree().current_scene
#region Metodo 1
#func change_instanced_scene(new_scene:Node):
	#var current_node = get_node("/root/Main")
	#remove_node_children(current_node)
	#(current_node as Node).add_child(new_scene)
	#
#func remove_node_children(node:Node):
	#for ii in (node as Node).get_children(true):
		#ii.queue_free()
#endregion

#region metodo 2 exit_tree
func change_instanced_scene(old_scene:Node,new_scene:Node):
	old_scene.queue_free()
	get_node("/root/Main").add_child(new_scene)
#endregion

#region metodo 3 packed_scene
func change_loaded_scene(new_scene:Node):
	packed_scene.pack(new_scene)
	get_tree().change_scene_to_packed(packed_scene)
#endregion

