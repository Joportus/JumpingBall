extends Label

onready var selector = $HBoxContainer/Selector


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().remove_child("res://scenes/Credits.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
