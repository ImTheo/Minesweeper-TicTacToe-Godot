extends Control

#const MINE_SWEEPER = preload("res://Screens/Minesweeper/MineSweeper.tscn")
#const TIC_TAC_TOE = preload("res://Screens/ChoosePlayer/ChoosePlayer.tscn")

func _on_button_tic_tac_toe_pressed():
	get_tree().change_scene_to_file("res://Screens/ChoosePlayer/ChoosePlayer.tscn")


func _on_button_minesweeper_pressed():
	get_tree().change_scene_to_file("res://Screens/Minesweeper/MineSweeper.tscn")
