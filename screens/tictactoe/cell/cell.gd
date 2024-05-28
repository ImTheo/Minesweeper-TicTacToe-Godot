class_name Cell
extends TextureButton

signal cell_pressed_signal(node:Cell)

func _on_cell_pressed():
	(self as TextureButton).disabled = true
	emit_signal("cell_pressed_signal",self)

func update_tile(texture:String):
	self.texture_normal = load(texture)
