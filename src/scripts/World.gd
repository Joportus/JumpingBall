extends Node2D

var Player1 = preload("res://scenes/Player.tscn")
var Player2 = preload("res://scenes/auto2.tscn")

func _ready() -> void:
	
	Game.connect("player_disconnected", self, "_end_game_id")
	Game.connect("server_disconnected", self, "_end_game")
	
	for nid in Game.players.keys():
		var slot = Game.players[nid]["slot"]
		var new_player
		match slot:
			0 : 
				new_player = Player1.instance()
				$CanvasLayer/winnerIzq.parse_bbcode("[center]%s won the match[/center]" %Game.players[nid]["name"])
			1 : 
				new_player = Player2.instance()
				new_player.get_node("Sprite").scale.x = -1
				$CanvasLayer/winnerDer.parse_bbcode(Game.players[nid]["name"]+" won the match!")
				
		new_player.init(nid)
		new_player.global_position = $Positions.get_child(Game.players[nid]["slot"]).global_position
		
		
		$Players.add_child(new_player)

func _end_game_id(id):
	_end_game()
	
func _end_game():
	Game.call_deferred("end_game")
	get_tree().change_scene("res://scenes/Lobby.tscn")
