extends Control

func _ready():
	ResourceLoader.load_threaded_request("uid://ceoy2jdbsdav6")
	ResourceLoader.load_threaded_request("uid://c67qwjkjusrj4")
	ResourceLoader.load_threaded_request("uid://cce4tm8wxefbl")

func _process(_delta):
	validate_buttons_load_scenes()

func validate_buttons_load_scenes():
	if(ResourceLoader.load_threaded_get_status("uid://ceoy2jdbsdav6") == 3):
		(%Button_Picture1 as Button).disabled = false
	if(ResourceLoader.load_threaded_get_status("uid://c67qwjkjusrj4") == 3):
		(%Button_Picture2 as Button).disabled = false
	if (ResourceLoader.load_threaded_get_status("uid://cce4tm8wxefbl") == 3):
		(%Button_Picture3 as Button).disabled = false
		
func _on_button_picture_1_pressed():	
	var photo_1_scene = ResourceLoader.load_threaded_get("uid://ceoy2jdbsdav6").instantiate()
	Auto.reeplace_scene(self,photo_1_scene)


func _on_button_picture_2_pressed():
	var photo_2_scene = ResourceLoader.load_threaded_get("uid://c67qwjkjusrj4").instantiate()
	Auto.reeplace_scene(self,photo_2_scene)


func _on_button_picture_3_pressed():
	var photo_3_scene = ResourceLoader.load_threaded_get("uid://cce4tm8wxefbl").instantiate()
	Auto.reeplace_scene(self,photo_3_scene)


func _on_button_return_pressed():
	var main_menu_scene = load("uid://c1s431lbfbycn").instantiate()
	Auto.reeplace_scene(self,main_menu_scene)
	

#func _on_tree_exiting():
	#ResourceLoader.load_threaded_get("uid://cce4tm8wxefbl").queue_free()
	#ResourceLoader.load_threaded_get("uid://c67qwjkjusrj4").queue_free()
	#ResourceLoader.load_threaded_get("uid://ceoy2jdbsdav6").queue_free()
