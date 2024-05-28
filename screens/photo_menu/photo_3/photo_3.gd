extends Control


func _on_button_return_pressed():
	var photo_menu_scene = load("uid://dwwyg14nx07sy").instantiate()
	SceneManager.reeplace_scene(self,photo_menu_scene)
