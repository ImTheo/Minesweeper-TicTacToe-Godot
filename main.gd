extends Control
#
func _ready():
	var node = Node2D.new()
	get_tree().current_scene.add_child(node)

