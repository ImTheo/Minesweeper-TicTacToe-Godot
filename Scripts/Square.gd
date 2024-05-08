class_name Square
extends TextureButton

#region constants
const CLOSED = preload("res://assets/closed.svg")
const TYPE_0 = preload("res://assets/type0.svg")
const TYPE_1 = preload("res://assets/type1.svg")
const TYPE_2 = preload("res://assets/type2.svg")
const TYPE_3 = preload("res://assets/type3.svg")
const FLAG = preload("res://assets/flag.svg")
const MINE = preload("res://assets/mine.svg")
const MINE_RED = preload("res://assets/mine_red.svg")
#endregion

@onready var square = self
var pressed_cell:bool = false
var flagged:bool = false
var mined:bool = false
var index

signal square_pressed_signal(index:int,node:Square)
signal game_ended_signal()

func _ready():
	pass
	#if randi() % 11 == 0:
		#mined = true
		#set_texture_square(MINE)
		#add_to_group("mines")
	#else:
		#set_texture_square(CLOSED)

func cell_not_pressed():
	if not pressed_cell:
		pressed_cell = true
		return true

func update_tile():
	if not pressed_cell and not mined:
		pressed_cell = !pressed_cell
		set_texture_square(TYPE_0)
	if mined and not flagged:
		game_ended_signal.emit()

func mark_flag_square():
	if not pressed_cell and not flagged:
		set_texture_square(FLAG)
		flagged = true
		return
	set_texture_square(CLOSED)
	flagged = false

func set_texture_square(texture):
	square.texture_normal = texture
	
func _on_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and not square.disabled:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				update_tile()
			MOUSE_BUTTON_RIGHT:
				mark_flag_square()
			MOUSE_BUTTON_MIDDLE:
				print("middle")

func mine_square():
	mined = true
	set_texture_square(MINE)
	add_to_group("mines")

func disable_square():
	square.disabled = true

func explode_mine():
	set_texture_square(MINE_RED)
