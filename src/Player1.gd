extends KinematicBody2D


const UP = Vector2(0, -1)

var motion = Vector2()

const v = 400

const jump = 800

const g = 35



func _physics_process(delta):
	
	motion.y += g
	
	if Input.is_key_pressed(KEY_D):
		motion.x = v
	
	elif Input.is_key_pressed(KEY_A):
		motion.x = -v
		

	else:
		motion.x = 0
		
	if is_on_floor():
		if Input.is_key_pressed(KEY_W):
			motion.y = -jump

		
	motion = move_and_slide(motion, UP)
	
	pass
		
		
