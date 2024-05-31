class_name SceneManager
extends Node

#region Method 1 adding new_scene as a child of parent container
static func reeplace_scene(old_scene:Node,new_scene:Node):
	var scene_parent = old_scene.get_parent()
	scene_parent.remove_child(old_scene)
	scene_parent.add_child(new_scene)
	old_scene.queue_free()
#endregion

#region Method 2 reeplace with packed_scene
func tree_change_scene_to_instanced(instanced_scene:Node):
	var packed_scene := PackedScene.new()
	packed_scene.pack(instanced_scene)
	get_tree().change_scene_to_packed(packed_scene)
#endregion

