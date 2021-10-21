extends RigidBody2D


var max_speed = 1900
var fire_speed = 1700
onready var fireAnimation = $fuegoPelota2
onready var explosion = get_node("../explosion")


var punto_izq = false
var punto_der = false

var puppet_punto_izq = false
var puppet_punto_der = false

var puppet_global_score1 = 0
var puppet_global_score2 = 0

var puppet_goal_animation = false

export var max_points10 = 3

onready var saca_der = get_node("../sacaDer").position
onready var saca_izq = get_node("../sacaIzq").position
onready var animation = get_node("../Winner")
onready var winnerIzq = get_node("../CanvasLayer/winnerIzq")
onready var winnerDer = get_node("../CanvasLayer/winnerDer")
onready var timer = get_node("../Timer")

var puppet_velocity = Vector2.ZERO
var puppet_angular_velocity = 0

var puppet_position = position
var ball_position = position


	
func _on_pisoizq_body_entered(body):
	if body.is_in_group("pelota") and is_network_master():
		explosion.position.x = self.position.x
		explosion.position.y = 1050
		explosion.emitting = true
		punto_der = true
	elif body.is_in_group("pelota") and !is_network_master():
		explosion.position.x = self.position.x
		explosion.position.y = 1050
		#explosion.emitting = true
		puppet_punto_der = true
	
		
		
func _on_pisoder_body_entered(body):
	if body.is_in_group("pelota") and is_network_master():
		explosion.position.x = self.position.x
		explosion.position.y = 1050
		explosion.emitting = true
		punto_izq = true
		
	elif body.is_in_group("pelota") and !is_network_master():
		explosion.position.x = self.position.x
		explosion.position.y = 1050
		#explosion.emitting = true
		puppet_punto_izq = true
		
	
	
		
puppet func update_point_der(punto_der):
	puppet_punto_der = punto_der

puppet func update_point_izq(punto_izq):
	puppet_punto_izq = punto_izq

		
puppet func update_pos_rot(velocity, angular_velocity):
	puppet_velocity = velocity
	puppet_angular_velocity = angular_velocity

puppet func update_score(global_score1, global_score2):
	puppet_global_score1 = global_score1
	puppet_global_score2 = global_score2
	
puppet func update_goal_animation(goal_animation):
	puppet_goal_animation = goal_animation

	
		

func _integrate_forces(state):
	
	if is_network_master():
		
		
		rpc_unreliable("update_point_izq", punto_izq)
		
		rpc_unreliable("update_point_der", punto_der)
		
	

		if abs(get_linear_velocity().x) > max_speed or abs(get_linear_velocity().y) > max_speed:
			var new_speed = get_linear_velocity().normalized()
			new_speed *= max_speed
			set_linear_velocity(new_speed)
			
		#if abs(get_linear_velocity().x) > fire_speed or abs(get_linear_velocity().y) > fire_speed:
		#	fireAnimation.emitting = true
		#	var t = Timer.new()
		#	t.set_wait_time(1.5)
		#	t.set_one_shot(true)
		#	self.add_child(t)
		#	t.start()
		#	yield(t, "timeout")
		#	fireAnimation.emitting = false
			
			
		if punto_der or puppet_punto_der:
			
			var xform = state.get_transform()
			xform.origin = saca_der
			punto_der = false
			state.set_transform(xform)
			set_linear_velocity(Vector2(0, -800))
			set_angular_velocity(0) 
			Global.score2 += 1
		
			
		if punto_izq or puppet_punto_izq:

			var xform = state.get_transform()
			xform.origin = saca_izq
			punto_izq = false
			state.set_transform(xform)
			set_linear_velocity(Vector2(0, -800))
			set_angular_velocity(0) 
			Global.score1 += 1
		
	
			
		if Global.score1 == max_points10:
			winnerIzq.visible = true
			animation.emitting = true
			call_deferred("queue_free")
		
		if Global.score2 == max_points10:
			winnerDer.visible = true
			animation.emitting = true
			call_deferred("queue_free")
			
		rpc_unreliable("update_pos_rot", get_linear_velocity(), get_angular_velocity())
		
		rpc_unreliable("update_score", Global.score1, Global.score2)
		
		rpc_unreliable("update_goal_animation", explosion.emitting)
	
	
	else:
		set_linear_velocity(puppet_velocity)
		set_angular_velocity(puppet_angular_velocity)
		#punto_der = puppet_punto_der
		#punto_izq = puppet_punto_izq
		
		Global.score1 = puppet_global_score1
		Global.score2 = puppet_global_score2
		
		
		
		
		if punto_izq or puppet_punto_izq:
			var xform = state.get_transform()
			xform.origin = saca_izq
			puppet_punto_izq = false
			state.set_transform(xform)
			set_linear_velocity(Vector2(0, -800))
			set_angular_velocity(0) 
			
		if punto_der or puppet_punto_der:
			var xform = state.get_transform()
			xform.origin = saca_der
			punto_der = false
			state.set_transform(xform)
			set_linear_velocity(Vector2(0, -800))
			set_angular_velocity(0) 
		
		if abs(get_linear_velocity().x) > max_speed or abs(get_linear_velocity().y) > max_speed:
			var new_speed = get_linear_velocity().normalized()
			new_speed *= max_speed
			set_linear_velocity(new_speed)
			
		if Global.score1 == max_points10:
			winnerIzq.visible = true
			animation.emitting = true
			call_deferred("queue_free")
		
		if Global.score2 == max_points10:
			winnerDer.visible = true
			animation.emitting = true
			call_deferred("queue_free")
		
		explosion.emitting = puppet_goal_animation
			
		
		
	if not is_network_master():
		puppet_velocity = get_linear_velocity()
		puppet_angular_velocity = get_angular_velocity()
		var xform = state.get_transform()
		xform.origin = puppet_position
		
		
		
		
		
		
		

		
		
		
		
	
		
	
	
	


		

	
