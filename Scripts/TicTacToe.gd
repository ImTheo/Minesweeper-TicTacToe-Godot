class_name TicTaeToe
extends Control

@onready var texture_rect_current_player = %TextureRect_currentPlayer
@onready var label_turn = %Label_turn
@onready var grid_container_tic_tac_toe = %GridContainer_TicTacToe
@onready var first_player_turn := true
@onready var turns_map:Array = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
const CIRCLE_PNG_119 = preload("res://assets/circle-png-119.png")
const X_22 = preload("res://assets/X-22.png")
const winning_lines = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

func _ready():
	var i = 0
	for cell:Cell in grid_container_tic_tac_toe.get_children():
		cell.index = i
		cell.connect("cell_pressed_signal",_on_cell_pressed)
		i=1+i
	#for cell:Cell in grid_container_tic_tac_toe.get_children():
		#print(cell.index)

#tile index is 0 to 8 representing the 3x3 matrix
func change_turn(tile_index:int):
	update_turns_map(tile_index)
	if is_winner():
		label_turn.text = "Ganador"
		return
	if is_draw():
		label_turn.text = "Empate"
		return
	if first_player_turn:
		texture_rect_current_player.texture = CIRCLE_PNG_119
	else:
		texture_rect_current_player.texture = X_22
	first_player_turn = !first_player_turn

func update_turns_map(tile_index):
	if first_player_turn:
		turns_map[tile_index] = 1
	else:
		turns_map[tile_index] = 0

func is_draw():
	if not turns_map.has(-1):
		return true
	return false
	
func is_winner():
	for line in winning_lines:
		if turns_map[line[0]] != -1 and turns_map[line[0]] == turns_map[line[1]] and turns_map[line[1]] == turns_map[line[2]]:
			end_game()
			return true
	return false

func end_game():
	for cell:Cell in grid_container_tic_tac_toe.get_children():
		cell.disabled = true
	
func game_ended():
	return false

func get_turn():
	return first_player_turn
	
func _on_cell_pressed(index:int,node:Cell):
	node.update_tile(get_turn())
	change_turn(index)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/TicTacToe.tscn")

func _on_button_return_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
