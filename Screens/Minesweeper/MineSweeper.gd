extends Control

@onready var label_mines_left = %Label_minesLeft
@onready var label_mine = %Label_mine
@onready var grid_container_minesweeper = %GridContainer_Minesweeper
var board_squares:Array[Square]
const SQUARE_NUMBER = 100
const MINES = 10
const SQUARE = preload("res://Components/Square/Square.tscn")
var board_array = []


func _ready():
	fill_board_array()
	create_board()
	plant_mines()
	generate_hints()

func fill_board_array():
	var row:Array[int] = []
	var matrix_rows:int = SQUARE_NUMBER/grid_container_minesweeper.columns
	var matrix_columns:int = grid_container_minesweeper.columns
	for i in range(matrix_rows):
		for j in range(matrix_columns):
			row.append(matrix_columns*i+j)
		board_array.append(row)
		row = []

func reveal_empty_squares(square:Square):
	if square.is_square_pressed() or square.is_mined():
		return
	square.reveal_tile()
	var adyacents:Array = square.get_adyacent_elements(board_array)
	for i in adyacents:
		if board_squares[i].hint_score != 0:
			board_squares[i].reveal_tile()
		if board_squares[i].hint_score == 0:
			reveal_empty_squares(board_squares[i])

func check_win():
	for i in get_tree().get_nodes_in_group("hints"):
		if not i.is_square_pressed():
			print(i.index)
			print(i.index_to_coordinates())
			print("No has ganado")
			return
	print("Ganaste")
	end_game("Ganaste")

func create_board():
	var square:Square
	for i in range(SQUARE_NUMBER):
		square = SQUARE.instantiate()
		square.connect("game_ended_signal", end_game)
		square.connect("hint_square_pressed_signal", check_win)
		square.connect("empty_square_pressed_signal", reveal_empty_squares)
		square.connect("flagged_mine_signal", update_flag)
		square.index = i
		board_squares.append(square)
		grid_container_minesweeper.add_child(square)

func update_flag(is_added):
	var mines_left:int = int(label_mines_left.text)
	if is_added:
		mines_left -= 1
	else:
		mines_left += 1
	label_mines_left.text = str(mines_left)

func generate_hints():
	var adyacents:Array
	for i in get_tree().get_nodes_in_group("mines"):
		adyacents = i.get_adyacent_elements(board_array)
		for adyacent_index in adyacents:
			board_squares[adyacent_index].add_hint()

func plant_mines():
	var mines_indexes:Array[int] = get_unique_random_numbers()
	for i:int in mines_indexes:
		board_squares[i].mine_square()
			
	label_mines_left.text = str(mines_indexes.size())

func get_unique_random_numbers()->Array[int]:
	var numbers:Array[int] = []
	while numbers.size() < MINES:
		var number = randi() % SQUARE_NUMBER
		if not numbers.has(number):
			numbers.append(number)
	return numbers

func end_game(message:String):
	label_mine.text = message
	label_mines_left.text = ""
	
	for i:Square in get_tree().get_nodes_in_group("squares"):
		i.disable_square()
		
	for i:Square in get_tree().get_nodes_in_group("mines"):
		i.explode_mine()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainSweeper.tscn")

func _on_button_return_pressed():
	get_tree().change_scene_to_file("res://Screens/MainMenu/MainMenu.tscn")
