extends KinematicBody2D

var linear_vel = Vector2.ZERO
var SPEED = 400
var SPEED_SQUARED = SPEED * SPEED

# networking
puppet var puppet_pos = Vector2()
puppet var puppet_target_vel = Vector2()

func _ready() -> void:
	puppet_pos = position

func init(nid):
	set_network_master(nid)
	var info = Game.players[nid]
	$Name.text = info["name"]
	name = str(nid)
	get_node()
func _physics_process(delta: float) -> void:
	var target_vel
	if is_network_master():
		target_vel = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
#		target_vel = target_vel.normalized()
		rset("puppet_target_vel", target_vel)
	else:
		target_vel = puppet_target_vel
	
	linear_vel = lerp(linear_vel, target_vel * SPEED, 0.1)
	linear_vel = move_and_slide(linear_vel, Vector2.UP)
	
	if is_network_master():
		rset_unreliable("puppet_pos", position)
	else:
		position = lerp(position, puppet_pos, 0.5)
		puppet_pos = position
