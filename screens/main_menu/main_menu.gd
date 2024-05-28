extends Control


func _on_button_tic_tac_toe_pressed():
	var choose_player_scene = load("uid://c28c7bd7wcffh").instantiate()
	SceneManager.reeplace_scene(self,choose_player_scene)

func _on_button_minesweeper_pressed():
	var minesweeper_scene = load("uid://bh86pg0gra60k").instantiate()
	SceneManager.reeplace_scene(self,minesweeper_scene)

func _on_button_threads_pressed():
	var photo_menu_scene = load("uid://dwwyg14nx07sy").instantiate()
	SceneManager.reeplace_scene(self,photo_menu_scene)
