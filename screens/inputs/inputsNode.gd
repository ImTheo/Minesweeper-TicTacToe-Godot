extends Node2D

func _input(event:InputEvent):
	if Input.is_action_pressed("ui_accept"):
		print("Polygon "+event.as_text())
