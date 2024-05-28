class_name Player
extends Node
var username:String
var texture_path:String
var wins := 0

func _init(player_name,player_texture_path):
	username = player_name
	texture_path = player_texture_path
	wins = 0

func increase_win():
	wins = wins+1
