class_name Cell
extends TextureButton

@onready var cell = self
var pressed_cell:bool = false
var index
const CIRCLE_PNG_119 = preload("res://assets/circle-png-119.png")
const X_22 = preload("res://assets/X-22.png")

signal cell_pressed_signal(index:int,node:Cell)

func _on_pressed():
	if cell_not_pressed():
		emit_signal("cell_pressed_signal",index,self)

func cell_not_pressed():
	if not pressed_cell:
		pressed_cell = true
		return true

func update_tile(first_player_turn:bool):
	if first_player_turn:
		cell.texture_normal = X_22
	else:
		cell.texture_normal = CIRCLE_PNG_119
