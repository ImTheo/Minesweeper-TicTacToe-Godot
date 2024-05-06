class_name Cell
extends TextureButton

@onready var cell = $"."
var pressed_cell:bool = false

func _on_pressed():
	if cell_not_pressed():
		update_tile((owner as TicTaeToe).get_turn())
		(owner as TicTaeToe).change_turn(get_meta("tile"))
		
func cell_not_pressed():
	if not pressed_cell:
		pressed_cell = true
		return true

func update_tile(first_player_turn:bool):
	if first_player_turn:
		cell.texture_normal = load("res://assets/X-22.png")
	else:
		cell.texture_normal = load("res://assets/circle-png-119.png")
