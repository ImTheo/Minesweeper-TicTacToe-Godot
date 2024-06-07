extends Control

func _on_gui_input(event:InputEvent):
	if Input.is_action_pressed("ui_accept"):
		print("on_gui accept")

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		print("process accept")

func _physics_process(delta):
	if Input.is_action_pressed("ui_accept"):
		print("physics accept")
#
#func _unhandled_input(event):
	#print("Unhandled "+event.as_text())
