class_name ChoosePlayer
extends Control
var players:Array[Player]
const SIGN_GROUP = "sign_buttons"
const SIGNAL_SIGN_SELECTED = "sign_selected"
var tic_tac_toe_scene:TicTaeToe

@onready var tree = get_tree()

func _ready():
	tic_tac_toe_scene = load("uid://cch2g4nm34cma").instantiate() as TicTaeToe
	%Label_player.text = "Jugador 1"
	refresh_enabled_signs()

func refresh_enabled_signs():
	for i:TextureButton in get_tree().get_nodes_in_group(SIGN_GROUP):
		if not i.button_pressed and not i.disabled:
			i.button_pressed = true
			return

func _on_button_siguiente_pressed():
	push_saved_player()
	refresh_enabled_signs()
	if players.size() == 2:
		change_scene()

func push_saved_player():
	var player_resource_path
	var player_name = (%LineEdit_playerName as LineEdit).text
	for i:TextureButton in get_tree().get_nodes_in_group(SIGN_GROUP):
		if i.is_pressed():
			player_resource_path = i.texture_normal.resource_path
			i.queue_free()
			players.append(Player.new(player_name,player_resource_path))
			break

func change_scene():
	tic_tac_toe_scene.players = players
	Auto.change_instanced_scene(self,tic_tac_toe_scene)
	#Auto.change_instanced_scene(tic_tac_toe_scene)
