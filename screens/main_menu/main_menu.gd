extends Control

#const MINE_SWEEPER = preload("res://Screens/Minesweeper/MineSweeper.tscn")
#const TIC_TAC_TOE = preload("res://Screens/ChoosePlayer/ChoosePlayer.tscn")


func _on_button_tic_tac_toe_pressed():
	var choose_player_scene = load("uid://c28c7bd7wcffh").instantiate()
	Auto.change_loaded_scene(choose_player_scene)
	#Auto.change_instanced_scene(choose_player_scene)

func _on_button_minesweeper_pressed():
	var minesweeper_scene = load("uid://bh86pg0gra60k").instantiate()
	Auto.change_loaded_scene(minesweeper_scene)
