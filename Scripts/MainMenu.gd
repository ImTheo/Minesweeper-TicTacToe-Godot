extends Control



func _on_button_tic_tac_toe_pressed():
	get_tree().change_scene_to_file("res://Scenes/TicTacToe.tscn")


func _on_button_minesweeper_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainSweeper.tscn")
