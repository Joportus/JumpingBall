extends KinematicBody2D

const UP = Vector2(0, -1)

var motion = Vector2()

const v = 800

const jump = 800

const g = 35



func _physics_process(delta):
	
	motion.y += g
	
	if Input.is_action_pressed("ui_right"):
		motion.x = v
	
	elif Input.is_action_pressed("ui_left"):
		motion.x = -v
		

	else:
		motion.x = 0
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -jump

		
	motion = move_and_slide(motion, UP)
	
	pass
		
		
