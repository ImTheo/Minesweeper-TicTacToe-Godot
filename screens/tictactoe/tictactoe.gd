@tool
class_name TicTaeToe
extends Control

@export var players:Array[Player] = []
enum Board_states {NONE=-1,PLAYER1=0,PLAYER2=1}
const TIC_TAC_TOE_CELLS = 9
var is_first_player_turn := true
var winning_lines:Array[Array]
var board_map:Array[Board_states] = [
	Board_states.NONE,
	Board_states.NONE,
	Board_states.NONE,
	Board_states.NONE,
	Board_states.NONE,
	Board_states.NONE,
	Board_states.NONE,
	Board_states.NONE,
	Board_states.NONE,
]

func _ready():
	update_scene_player_stats()
	update_winning_lines(int(sqrt(board_map.size())))
	instantiate_cells()

func update_scene_player_stats():
	(%TextureRect_currentPlayer as TextureRect).texture = load(players[Board_states.PLAYER1].texture_path)
	(%Label_turn as Label).text = players[Board_states.PLAYER1].username
	
	(%Label_player_1 as Label).text = players[Board_states.PLAYER1].username
	(%Label_player1_streak as Label).text = str(players[Board_states.PLAYER1].wins)
	(%Label_player_2 as Label).text = players[Board_states.PLAYER2].username
	(%Label_player2_streak as Label).text = str(players[Board_states.PLAYER2].wins)

func instantiate_cells():
	var cell_scene = load("uid://d3cwpywine331")
	var cell_node:Cell
	for ii in range(TIC_TAC_TOE_CELLS):
		cell_node = cell_scene.instantiate()
		cell_node.connect("cell_pressed_signal",cell_pressed)
		%GridContainer_TicTacToe.add_child(cell_node)

func update_current_player():
	is_first_player_turn = !is_first_player_turn
	if is_first_player_turn:
		%TextureRect_currentPlayer.texture = load(players[Board_states.PLAYER1].texture_path)
		(%Label_turn as Label).text = players[Board_states.PLAYER1].name
	else:
		%TextureRect_currentPlayer.texture = load(players[Board_states.PLAYER2].texture_path)
		(%Label_turn as Label).text = players[Board_states.PLAYER2].name
	
func update_board_map(cell_index):
	if is_first_player_turn:
		board_map[cell_index] = Board_states.PLAYER1
	else:
		board_map[cell_index] = Board_states.PLAYER2

func is_draw()->bool:
	if not board_map.has(Board_states.NONE):
		return true
	return false
	
func increase_win_streak():
	if is_first_player_turn:
		players[Board_states.PLAYER1].increase_win()
	else: 
		players[Board_states.PLAYER2].increase_win()

func is_winner()->bool:
	for line in winning_lines:
		if (
				board_map[line[0]] != Board_states.NONE 
				and board_map[line[0]] == board_map[line[1]] 
				and board_map[line[1]] == board_map[line[2]]
		):
			return true
	return false

func end_game():
	for cell:Cell in %GridContainer_TicTacToe.get_children():
		cell.disabled = true
	
func cell_pressed(cell:Cell):
	update_texture(cell)
	update_board_map(cell.get_index())
	update_game_state()
	
func update_game_state():
	if is_winner():
		%Label_turn.text += " Ganador"
		increase_win_streak()
		end_game()
	elif is_draw():
		%Label_turn.text = "Empate"
		end_game()
	else:
		update_current_player()

func update_texture(cell:Cell):
	if is_first_player_turn:
		cell.update_tile(players[Board_states.PLAYER1].texture_path)
	else:
		cell.update_tile(players[Board_states.PLAYER2].texture_path)

func _on_button_reset_pressed():
	var tic_tac_toe_scene:TicTaeToe = load("uid://cch2g4nm34cma").instantiate()
	tic_tac_toe_scene.players = players
	SceneManager.reeplace_scene(self,tic_tac_toe_scene)

func _on_button_return_pressed():
	var main_scene = load("uid://c1s431lbfbycn").instantiate()
	SceneManager.reeplace_scene(self,main_scene)

func update_winning_lines(board_size: int):
	# Rows
	for ii in range(board_size):
		var row = []
		for jj in range(board_size):
			row.append(ii * board_size + jj)
		winning_lines.append(row)
	
	# Columns
	for ii in range(board_size):
		var column = []
		for jj in range(board_size):
			column.append(jj * board_size + ii)
		winning_lines.append(column)
	
	# Diagonal top-left to bottom-right
	var diagonal1 = []
	for ii in range(board_size):
		diagonal1.append(ii * board_size + ii)
	winning_lines.append(diagonal1)
	
	# Diagonal top-right to bottom-left
	var diagonal2 = []
	for ii in range(board_size):
		diagonal2.append((ii + 1) * (board_size - 1))
	winning_lines.append(diagonal2)
