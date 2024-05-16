class_name Square
extends TextureButton

#region constants
const CLOSED = preload("res://Screens/Minesweeper/Assets/closed.svg")
const FLAG = preload("res://Screens/Minesweeper/Assets/flag.svg")
const MINE = preload("res://Screens/Minesweeper/Assets/mine.svg")
const MINE_RED = preload("res://Screens/Minesweeper/Assets/mine_red.svg")
const TYPE_0 = preload("res://Screens/Minesweeper/Assets/type0.svg")
const TYPE_1 = preload("res://Screens/Minesweeper/Assets/type1.svg")
const TYPE_2 = preload("res://Screens/Minesweeper/Assets/type2.svg")
const TYPE_3 = preload("res://Screens/Minesweeper/Assets/type3.svg")
const TYPE_4 = preload("res://Screens/Minesweeper/Assets/type4.svg")
const TYPE_5 = preload("res://Screens/Minesweeper/Assets/type5.svg")
const TYPE_6 = preload("res://Screens/Minesweeper/Assets/type6.svg")
const TYPE_7 = preload("res://Screens/Minesweeper/Assets/type7.svg")
const TYPE_8 = preload("res://Screens/Minesweeper/Assets/type8.svg")
#endregion

@onready var square = self
var pressed_square:bool = false
var flagged:bool = false
var mined:bool = false
var index
var hint_score = 0

signal empty_square_pressed_signal(node:Square)
signal game_ended_signal()
signal flag_updated_signal()
signal hint_square_pressed_signal()

func is_mined():
	return mined

func is_square_pressed():
	return pressed_square

func _ready():
	set_texture_square(CLOSED)

func update_tile():
	if hint_score == 0:
		empty_square_pressed_signal.emit(self)
	if not pressed_square and not mined and not flagged:
		pressed_square = true
		hint_square_pressed_signal.emit()
		reveal_tile()
	if mined and not flagged:
		game_ended_signal.emit("Perdiste")

func reveal_tile():
	pressed_square = true
	if mined:
		set_texture_square(CLOSED)
	if hint_score == 0:
		set_texture_square(TYPE_0)
	elif hint_score == 1:
		set_texture_square(TYPE_1)
	elif hint_score == 2:
		set_texture_square(TYPE_2)
	elif hint_score == 3:
		set_texture_square(TYPE_3)
	elif hint_score == 4:
		set_texture_square(TYPE_4)
	elif hint_score == 5:
		set_texture_square(TYPE_5)
	elif hint_score == 6:
		set_texture_square(TYPE_6)
	elif hint_score == 7:
		set_texture_square(TYPE_7)
	elif hint_score == 8:
		set_texture_square(TYPE_8)

func mark_flag_square():
	if pressed_square:
		return
	if not pressed_square and not flagged:
		set_texture_square(FLAG)
		flagged = true
		flag_updated_signal.emit(true)
		return
	set_texture_square(CLOSED)
	flagged = false
	flag_updated_signal.emit(false)

func set_texture_square(texture):
	square.texture_normal = texture
	
func _on_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and not square.disabled:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				update_tile()
			MOUSE_BUTTON_RIGHT:
				mark_flag_square()

func index_to_coordinates() -> Vector2:
	var num_columns: int = 10
	var row: int = index / num_columns
	var column: int = index % num_columns
	return Vector2(row, column)

func mine_square():
	mined = true
	#set_texture_square(MINE)
	add_to_group("mines")
	
func is_valid_pos(i, j, n, m):
	return i >= 0 and j >= 0 and i < n and j < m

func get_adjacent(arr,pos)->Array:
	var n = len(arr)
	var m = len(arr[0])
	var v = []
	for dx in range(-1 if pos.x > 0 else 0, 2 if pos.x < n - 1 else 1):
		for dy in range(-1 if pos.y > 0 else 0, 2 if pos.y < m - 1 else 1):
			if dx != 0 or dy != 0:
				v.append(arr[pos.x + dx][pos.y + dy])
	return v

func get_adyacent_elements(board_array)->Array:
	var index_position:Vector2 = index_to_coordinates()
	var adyacent_list:Array = get_adjacent(board_array,index_position)
	return adyacent_list

func add_hint():
	if not mined:
		hint_score = hint_score + 1
		if not is_in_group("hints"):
			add_to_group("hints")

func disable_square():
	square.disabled = true

func explode_mine():
	set_texture_square(MINE_RED)
