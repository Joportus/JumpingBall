extends Node2D

onready var ball = $Ball
onready var spawn = $spawn
onready var collision_shape = $Ball/CollisionShape2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
##	pass
#
#func _on_pisoizq_body_entered(body:PhysicsBody2D):
#	if body.is_in_group("pelota"):
#
#		#ball.linear_velocity = Vector2.ZERO
#		ball.sleeping = true
#		ball.mode = RigidBody2D.MODE_KINEMATIC
#		ball.position = spawn.position
#		yield($Timer, "timeout")
#		ball.mode = RigidBody2D.MODE_RIGID
#		ball.sleeping = false
#
#
#
#
#
#func _on_pisoder_body_entered(body):
#	if body.is_in_group("pelota"):
#
#		#ball.linear_velocity = Vector2.ZERO
#		ball.sleeping = true
#		ball.mode = RigidBody2D.MODE_KINEMATIC
#		ball.position = spawn.position
#		yield($Timer, "timeout")
#		ball.mode = RigidBody2D.MODE_RIGID
#		ball.sleeping = false
#
#
#
#
