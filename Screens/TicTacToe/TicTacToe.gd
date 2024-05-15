class_name TicTaeToe
extends Control

@onready var is_first_player_turn := true
@onready var board_map:Array = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
var players:Array[Player]
var winning_lines:Array

func _ready():
	set_game_board_stats()
	winning_lines = calculate_winning_lines(sqrt(board_map.size()))
	
	for i in range(%GridContainer_TicTacToe.get_child_count()):
		(%GridContainer_TicTacToe.get_child(i) as Cell).connect("cell_pressed_signal",cell_pressed)

func calculate_winning_lines(board_size: int) -> Array:
	var res = []
	
	# Rows
	for i in range(board_size):
		var row = []
		for j in range(board_size):
			row.append(i * board_size + j)
		res.append(row)
	
	# Columns
	for i in range(board_size):
		var column = []
		for j in range(board_size):
			column.append(j * board_size + i)
		res.append(column)
	
	# Diagonal top-left to bottom-right
	var diagonal1 = []
	for i in range(board_size):
		diagonal1.append(i * board_size + i)
	res.append(diagonal1)
	
	# Diagonal top-right to bottom-left
	var diagonal2 = []
	for i in range(board_size):
		diagonal2.append((i + 1) * (board_size - 1))
	res.append(diagonal2)
	
	return res

func set_game_board_stats():
	(%TextureRect_currentPlayer as TextureRect).texture = load(players[0].texture_path)
	(%Label_turn as Label).text = players[0].name
	(%Label_player_1 as Label).text = players[0].name
	(%Label_player1_streak as Label).text = str(players[0].wins)
	(%Label_player_2 as Label).text = players[1].name
	(%Label_player2_streak as Label).text = str(players[1].wins)

#tile index is 0 to 8 representing the 3x3 matrix
func change_turn(tile_index:int):
	update_turns_map(tile_index)
	if is_winner():
		%Label_turn.text += " Ganador"
		increase_win_streak()
		return
	if is_draw():
		%Label_turn.text = "Empate"
		return
	is_first_player_turn = !is_first_player_turn
	if is_first_player_turn:
		%TextureRect_currentPlayer.texture = load(players[0].texture_path)
		(%Label_turn as Label).text = players[0].name
	else:
		%TextureRect_currentPlayer.texture = load(players[1].texture_path)
		(%Label_turn as Label).text = players[1].name

func update_turns_map(tile_index):
	if is_first_player_turn:
		board_map[tile_index] = 1
	else:
		board_map[tile_index] = 0

func is_draw():
	if not board_map.has(-1):
		return true
	return false
	
func increase_win_streak():
	if is_first_player_turn:
		players[0].increase_win()
	else: 
		players[1].increase_win()

func is_winner():
	for line in winning_lines:
		if board_map[line[0]] != -1 and board_map[line[0]] == board_map[line[1]] and board_map[line[1]] == board_map[line[2]]:
			end_game()
			return true
	return false

func end_game():
	for cell:Cell in %GridContainer_TicTacToe.get_children():
		cell.disabled = true
	
func game_ended():
	return false
	
func cell_pressed(node:Cell):
	#print(node.get_index())
	if is_first_player_turn:
		node.update_tile(players[0].texture_path)
	else:
		node.update_tile(players[1].texture_path)
	change_turn(node.get_index())

func _on_button_pressed():
	var tic_tac_toe = preload("res://Screens/TicTacToe/TicTacToe.tscn")
	var node = tic_tac_toe.instantiate()
	node.players = players
	get_tree().root.add_child(node)
	self.queue_free()

func _on_button_return_pressed():
	self.queue_free()
	get_tree().change_scene_to_file("res://Screens/MainMenu/MainMenu.tscn")
