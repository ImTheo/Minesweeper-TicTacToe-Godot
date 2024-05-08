extends Control

@onready var label_mines_left = %Label_minesLeft
@onready var label_mine = %Label_mine
var squares:Array[Square]
func _ready():
	for node in get_tree().get_nodes_in_group("squares"):
		squares.append(node)
	for i in squares:
		i.connect("game_ended_signal", end_game)
	plant_mines(squares)
		

func plant_mines(squares:Array[Square]):
	var mines = get_unique_random_numbers()
	for i in mines:
		squares[i].mine_square()
		
	label_mines_left.text = str(mines.size())

func get_unique_random_numbers()->Array[int]:
	var numbers:Array[int]
	while numbers.size() < 10:
		var number = randi() % 100
		if not numbers.has(number):
			numbers.append(number)
	return numbers

func end_game():
	label_mine.text = "Perdiste"
	label_mines_left.text = ""
	
	for i:Square in get_tree().get_nodes_in_group("squares"):
		i.disable_square()
		
	for i:Square in get_tree().get_nodes_in_group("mines"):
		i.explode_mine()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainSweeper.tscn")

func _on_button_return_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
