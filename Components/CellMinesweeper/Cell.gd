class_name Cell
extends TextureButton

@onready var cell = self
var pressed_cell:bool = false
var player_1 = "res://Screens/TicTacToe/Assets/circle-png-119.png"
var player_2 = "res://Screens/TicTacToe/Assets/X-22.png"

signal cell_pressed_signal(node:Cell)

func _on_pressed():
	if cell_not_pressed():
		emit_signal("cell_pressed_signal",self)

func cell_not_pressed():
	if not pressed_cell:
		pressed_cell = true
		return true

func update_tile(texture:String):
	cell.texture_normal = load(texture)
