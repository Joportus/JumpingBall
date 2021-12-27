extends MarginContainer


onready var selector = $HBoxContainer/Selector
onready var dev_title = $CenterContainer/VBoxContainer/CenterContainer/Label
onready var devs = $CenterContainer/VBoxContainer/CenterContainer2/devs
onready var thanks_title = $CenterContainer/VBoxContainer/CenterContainer3/Label
onready var thanks = $CenterContainer/VBoxContainer/CenterContainer4/devs
onready var assets_title = $CenterContainer/VBoxContainer/CenterContainer/Assets
onready var assets = $CenterContainer/VBoxContainer/CenterContainer2/assets
onready var right_arrow = $GridContainer/HBoxContainer/right_arrow
onready var left_arrow = $GridContainer/HBoxContainer/left_arrow


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")
		queue_free()
	if Input.is_action_just_pressed("ui_right"):
		dev_title.visible = false
		devs.visible = false
		thanks_title.visible = false
		thanks.visible = false
		assets_title.visible = true
		assets.visible = true
		right_arrow.visible = false
		left_arrow.visible = true
	if Input.is_action_just_pressed("ui_left"):
		dev_title.visible = true
		devs.visible = true
		thanks_title.visible = true
		thanks.visible = true
		assets_title.visible = false
		assets.visible = false
		right_arrow.visible = true
		left_arrow.visible = false
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
