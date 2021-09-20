extends RigidBody2D


var max_speed = 1700

var punto_izq = false
var punto_der = false
export var max_points10 = 3

onready var saca_der = get_node("../sacaDer").position
onready var saca_izq = get_node("../sacaIzq").position
onready var animation = get_node("../Winner")
onready var winnerIzq = get_node("../CanvasLayer/winnerIzq")
onready var winnerDer = get_node("../CanvasLayer/winnerDer")


func _on_pisoizq_body_entered(body):
	if body.is_in_group("pelota"):
		punto_der = true
		
func _on_pisoder_body_entered(body):
	if body.is_in_group("pelota"):
		punto_izq = true
		
	
func _integrate_forces(state):
	


	if abs(get_linear_velocity().x) > max_speed or abs(get_linear_velocity().y) > max_speed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= max_speed
		set_linear_velocity(new_speed)

	
	if punto_der:
		var xform = state.get_transform()
		xform.origin = saca_der
		punto_der = false
		state.set_transform(xform)
		set_linear_velocity(Vector2(0, -800))
		set_angular_velocity(0) 
		Global.score2 += 1
		
	if punto_izq:
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
		
		
	
		
	
	
	


		

	