extends Node

#region Method 1 reeplacing all children of parent container
#func change_instanced_scene(new_scene:Node):
	#var current_node = get_node("/root/Main")
	#remove_node_children(current_node)
	#(current_node as Node).add_child(new_scene)
	#
#func remove_node_children(node:Node):
	#for ii in (node as Node).get_children(true):
		#ii.queue_free()
#endregion

#region Method 2 adding new_scene as a child of parent container
func reeplace_scene(old_scene:Node,new_scene:Node):
	var parent_container = old_scene.get_parent()
	parent_container.remove_child(old_scene)
	parent_container.get_tree().process_frame
	parent_container.add_child(new_scene)
	old_scene.queue_free()
	
	#await parent_container.get_tree().process_frame
	#old_scene.free()
	#for i in old_scene.get_children(true):
		#i.free()
#endregion

#region Method 3 reeplace with packed_scene
func change_loaded_scene(new_scene:Node):
	var packed_scene := PackedScene.new()
	packed_scene.pack(new_scene)
	get_tree().change_scene_to_packed(packed_scene)
#endregion

