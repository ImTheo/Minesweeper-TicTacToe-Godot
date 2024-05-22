extends Control

#const MINE_SWEEPER = preload("res://Screens/Minesweeper/MineSweeper.tscn")
#const TIC_TAC_TOE = preload("res://Screens/ChoosePlayer/ChoosePlayer.tscn")


func _on_button_tic_tac_toe_pressed():
	var choose_player_scene = load("uid://c28c7bd7wcffh").instantiate()
	Auto.reeplace_scene(self,choose_player_scene)
	#Auto.reeplace_scene(choose_player_scene)

func _on_button_minesweeper_pressed():
	var minesweeper_scene = load("uid://bh86pg0gra60k").instantiate()
	Auto.reeplace_scene(self,minesweeper_scene)


#func _on_button_minesweeper_2_pressed():
	#var node = Node2D.new()
	#node.name = "new scene"
	#Auto.reeplace_scene(self,node)
