extends Node2D

var Player1 = preload("res://scenes/player.tscn")
var Player2 = preload("res://scenes/auto2.tscn")

func _ready() -> void:
	
	Game.connect("player_disconnected", self, "_end_game_id")
	Game.connect("server_disconnected", self, "_end_game")
	
	for nid in Game.players.keys():
		var player1 = Player1.instance()
		player1.init(nid)
		player1.global_position = $Positions.get_child(Game.players[nid]["slot"]).global_position
		$Players.add_child(player1)

func _end_game_id(id):
	_end_game()
	
func _end_game():
	Game.call_deferred("end_game")
	get_tree().change_scene("res://scenes/Lobby.tscn")
