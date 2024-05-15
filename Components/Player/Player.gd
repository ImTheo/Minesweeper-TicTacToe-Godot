class_name Player

var name
var texture_path
var wins = 0

func _init(player_name,player_texture_path):
	name = player_name
	texture_path = player_texture_path
	wins = 0

func increase_win():
	wins = wins+1
