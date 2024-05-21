extends Control
#
func _ready():
	var node = Node2D.new()
	get_tree().current_scene.add_child(node)

#func _on_child_exiting_tree(node:Node):
	#for i in node.get_children():
		#i.queue_free()
		#

#func _on_replacing_by(node:Node):
	#print(node)
	
#func _on_child_entered_tree(node:Node):
	#node.connect("replacing_by",_on_replacing_by)
