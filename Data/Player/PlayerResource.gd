class_name PlayerResource
extends Resource

var players:Array[Player]

#func _init(array_players:Array[Player]):
	#players = array_players
func set_players(array_players:Array[Player]):
	players = array_players
