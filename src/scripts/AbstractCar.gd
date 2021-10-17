extends KinematicBody2D

const UP = Vector2(0, -1)

var motion = Vector2()

const v = 800

const jump = 800

const g = 35

var puppet_motion = Vector2()
var puppet_position = Vector2()


puppet func _update_state(motion, position):
	puppet_motion = motion
	puppet_position = position



func _physics_process(delta):
	
	if is_network_master():
		
		motion.y += g
		motion.x = (Input.get_action_strength("drive_right") - Input.get_action_strength("drive_left"))*v
			
		if is_on_floor():
			if Input.is_action_just_pressed("Jump"):
				motion.y = -jump
		
		rpc("_update_state", puppet_position, puppet_motion)
	else:
		motion = puppet_motion
		position = puppet_position
		
	
	
	motion = move_and_slide(motion, UP)
	
	if not is_network_master():
		puppet_position = position

		
		
func _ready() -> void:
	puppet_position = position

func init(nid):
	set_network_master(nid)
	var info = Game.players[nid]
	$Name.text = info["name"]
	name = str(nid)



