class_name TicTaeToe
extends Control

var is_first_player_turn := true
var board_map:Array[int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
var players:Array[Player]
var winning_lines:Array
const TIC_TAC_TOE_CELLS = 9
const CELL = preload("res://Components/Cell/Cell.tscn")

func _ready():
	set_game_board_player_stats()
	update_winning_lines(sqrt(board_map.size()))
	instanciate_cells()

func instanciate_cells():
	var cell:Cell
	for i in range(TIC_TAC_TOE_CELLS):
		cell = CELL.instantiate()
		cell.connect("cell_pressed_signal",cell_pressed)
		%GridContainer_TicTacToe.add_child(cell)

func update_game_board_player_stats():
	(%TextureRect_currentPlayer as TextureRect).texture = load(players[0].texture_path)
	(%Label_turn as Label).text = players[0].name
	
	(%Label_player_1 as Label).text = players[0].name
	(%Label_player1_streak as Label).text = str(players[0].wins)
	(%Label_player_2 as Label).text = players[1].name
	(%Label_player2_streak as Label).text = str(players[1].wins)

func change_turn(cell_index:int):
	is_first_player_turn = !is_first_player_turn
	update_current_player()
	
func update_current_player():
	if is_first_player_turn:
		%TextureRect_currentPlayer.texture = load(players[0].texture_path)
		(%Label_turn as Label).text = players[0].name
	else:
		%TextureRect_currentPlayer.texture = load(players[1].texture_path)
		(%Label_turn as Label).text = players[1].name
	
func update_board_map(cell_index):
	if is_first_player_turn:
		board_map[cell_index] = 1
	else:
		board_map[cell_index] = 0

func is_draw()->bool:
	if not board_map.has(-1):
		return true
	return false
	
func increase_win_streak():
	if is_first_player_turn:
		players[0].increase_win()
	else: 
		players[1].increase_win()

func is_winner()->bool:
	for line in winning_lines:
		if board_map[line[0]] != -1 and board_map[line[0]] == board_map[line[1]] and board_map[line[1]] == board_map[line[2]]:
			return true
	return false

func end_game():
	for cell:Cell in %GridContainer_TicTacToe.get_children():
		cell.disabled = true
	
func cell_pressed(cell:Cell):
	update_texture(cell)
	update_board_map(cell.get_index())
	if not is_game_over():
		change_turn(cell.get_index())
	else:
		end_game()
	
func is_game_over()->bool:
	if is_winner():
		%Label_turn.text += " Ganador"
		increase_win_streak()
		return true
	if is_draw():
		%Label_turn.text = "Empate"
		return true
	return false

func update_texture(cell:Cell):
	if is_first_player_turn:
		cell.update_tile(players[0].texture_path)
	else:
		cell.update_tile(players[1].texture_path)

func _on_button_pressed():
	var tic_tac_toe = preload("res://Screens/TicTacToe/TicTacToe.tscn")
	var node = tic_tac_toe.instantiate()
	node.players = players
	get_tree().root.add_child(node)
	self.queue_free()

func _on_button_return_pressed():
	self.queue_free()
	get_tree().change_scene_to_file("res://Screens/MainMenu/MainMenu.tscn")

func update_winning_lines(board_size: int):
	# Rows
	for i in range(board_size):
		var row = []
		for j in range(board_size):
			row.append(i * board_size + j)
		winning_lines.append(row)
	
	# Columns
	for i in range(board_size):
		var column = []
		for j in range(board_size):
			column.append(j * board_size + i)
		winning_lines.append(column)
	
	# Diagonal top-left to bottom-right
	var diagonal1 = []
	for i in range(board_size):
		diagonal1.append(i * board_size + i)
	winning_lines.append(diagonal1)
	
	# Diagonal top-right to bottom-left
	var diagonal2 = []
	for i in range(board_size):
		diagonal2.append((i + 1) * (board_size - 1))
	winning_lines.append(diagonal2)

