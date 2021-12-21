extends MarginContainer

const lobby_scene = preload("res://scenes/Lobby.tscn")
const credits_scene = preload("res://scenes/Credits.tscn")
onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector

var current_selection = 0


func _ready():
	set_current_selection(0)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		current_selection += 1
	
	elif Input.is_action_just_pressed("ui_up"):
		current_selection -= 1
	
	if current_selection > 2:
		current_selection = 0
		
	if current_selection < 0:
		current_selection = 2
		
	set_current_selection(current_selection)
	
	if Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)
	
		
func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent().add_child(lobby_scene.instance())
		queue_free()
	elif _current_selection == 1:
		get_parent().add_child(credits_scene.instance())
		queue_free()
	elif _current_selection == 2:
		get_tree().quit()
	
			
	
func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	if _current_selection == 0:
		selector_one.text = "> \n"
		
	elif _current_selection == 1:
		selector_two.text = "> \n"
		
	elif _current_selection == 2:
		selector_three.text = "> \n"
	
		

	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
