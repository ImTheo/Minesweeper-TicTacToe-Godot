class_name TicTaeToe
extends Control

@onready var first_player_turn := true
@onready var texture_rect_current_player = %TextureRect_currentPlayer
@onready var label_turn = %Label_turn
const winning_lines = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

#-1 not, 1 x, 1 o
@onready var turns_map:Array = [-1,-1,-1,-1,-1,-1,-1,-1,-1]

#tile index is 0 to 8 representing the 3x3 matrix
func change_turn(tile_index:int):
	if is_winner(tile_index):
		label_turn.text = "Ganador"
		return
	if game_ended():
		return
	if first_player_turn:
		turns_map[tile_index] = 1
		texture_rect_current_player.texture = load("res://assets/circle-png-119.png")
	else:
		turns_map[tile_index] = 0
		texture_rect_current_player.texture = load("res://assets/X-22.png")
	
	first_player_turn = !first_player_turn
	print(turns_map)
	
func is_winner(tile_index):
	if first_player_turn:
		turns_map[tile_index] = 1
	else:
		turns_map[tile_index] = 0
	for line in winning_lines:
		if turns_map[line[0]] != -1 and turns_map[line[0]] == turns_map[line[1]] and turns_map[line[1]] == turns_map[line[2]]:
			return true
	return false

func game_ended():
	return false

func get_turn():
	return first_player_turn


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ticTacToe.tscn")
