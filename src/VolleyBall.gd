extends RigidBody2D

onready var spawn = $spawn
var punto_izq = false
var punto_der = false

var saca_der = Vector2(930,400)
var saca_izq = Vector2(920,400)


func _on_pisoizq_body_entered(body):
	if body.is_in_group("pelota"):
		punto_der = true
		
func _on_pisoder_body_entered(body):
	if body.is_in_group("pelota"):
		punto_izq = true
		
		
		
	
	
func _integrate_forces(state):
	
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
		
	
	
	


		

	
