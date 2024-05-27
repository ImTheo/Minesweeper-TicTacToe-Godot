extends Control

var board_squares:Array[Square]
const COLUMNS = 15
const SQUARES = int(pow(COLUMNS,2))
const MINES = COLUMNS
const SQUARE_SCENE:Resource = preload("uid://cd4njqupgwpeb")
var board_array:Array[Array] = []

func _ready():
	update_board_scene()
	update_board_array()
	instantiate_squares()
	set_mines()
	set_hints()
	
func update_board_scene():
	(%GridContainer_Minesweeper as GridContainer).columns = COLUMNS
	(%Label_minesLeft as Label).text = str(MINES)
	
func update_board_array():
	var row:Array[int] = []
	var matrix_rows:int = SQUARES/%GridContainer_Minesweeper.columns
	for i in range(matrix_rows):
		for j in range(COLUMNS):
			row.append(COLUMNS*i+j)
		board_array.append(row)
		row = []

func empty_square_pressed(square:Square):
	reveal_empty_squares(square)

func reveal_empty_squares(square:Square):
	if square.is_square_pressed():
		return
	square.reveal_tile()
	var adyacents:Array = square.get_adyacent_elements(square.get_index(),board_array)
	for i in adyacents:
		if board_squares[i].hint_score != 0:
			board_squares[i].reveal_tile()
		if board_squares[i].hint_score == 0:
			reveal_empty_squares(board_squares[i])

func hint_square_pressed():
	if all_hints_pressed():
		game_ended("Ganaste")
	
func all_hints_pressed()->bool:
	for i:Square in get_tree().get_nodes_in_group("hints"):
		if not i.is_square_pressed():
			return false
	return true

func instantiate_squares():
	var square:Square
	for ii in range(SQUARES):
		square = SQUARE_SCENE.instantiate()
		square.connect("game_ended", game_ended)
		square.connect("hint_square_pressed", hint_square_pressed)
		square.connect("empty_square_pressed", empty_square_pressed)
		square.connect("flag_updated", flag_updated)
		board_squares.append(square)
		%GridContainer_Minesweeper.add_child(square)

func flag_updated(is_added):
	var mines_left:int = int(%Label_minesLeft.text)
	if is_added:
		mines_left -= 1
	else:
		mines_left += 1
	%Label_minesLeft.text = str(mines_left)

func set_hints():
	var adyacents:Array
	for ii:Square in get_tree().get_nodes_in_group("mines"):
		adyacents = ii.get_adyacent_elements(ii.get_index(),board_array)
		for adyacent_index in adyacents:
			board_squares[adyacent_index].add_hint()

func set_mines():
	var mines_indexes:Array[int] = get_unique_random_numbers()
	for ii:int in mines_indexes:
		board_squares[ii].mine_square()

func get_unique_random_numbers()->Array[int]:
	var numbers:Array[int] = []
	while numbers.size() < MINES:
		var number = randi() % SQUARES
		if not numbers.has(number):
			numbers.append(number)
	return numbers

func game_ended(message:String):
	%Label_mine.text = message
	%Label_minesLeft.text = ""
	
	for ii:Square in get_tree().get_nodes_in_group("squares"):
		ii.disable_square()
		
	for ii:Square in get_tree().get_nodes_in_group("mines"):
		ii.explode_mine()

func _on_button_reiniciar_pressed():
	var minesweeper_scene = load("uid://bh86pg0gra60k").instantiate()
	Auto.reeplace_scene(self,minesweeper_scene)


func _on_button_menu_pressed():
	var main_scene = load("uid://c1s431lbfbycn").instantiate()
	Auto.reeplace_scene(self,main_scene)
