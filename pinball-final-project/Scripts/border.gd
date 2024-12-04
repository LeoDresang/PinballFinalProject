extends CharacterBody2D

@onready var area:Area2D = $Area2D
@onready var collider:CollisionShape2D = $Area2D/CollisionShape2D

var temp = true
var x_bound = 0
var y_bound = 0


func _process(delta):
	if(Globals.ball and temp):
		temp = false
		collider.shape.set("size", Vector2(collider.shape.get_rect().size.x - 2 * Globals.ball.collider.shape.radius, collider.shape.get_rect().size.y - 2 * Globals.ball.collider.shape.radius))

func _on_area_2d_body_exited(body: Node2D) -> void:

	
	
	if(body == Globals.ball):
		var normal = Vector2.ZERO
		if(Globals.ball.global_position.x > collider.shape.get_rect().size.x/2):
			normal = Vector2(-1,0)
			print("right wall bounce")
		elif(Globals.ball.global_position.x < -collider.shape.get_rect().size.x/2):
			normal = Vector2(1,0)
			print("left wall bounce")
		elif(Globals.ball.global_position.y < -collider.shape.get_rect().size.y/2):
			normal = Vector2(0, 1)
			print("top wall bounce")
		elif(Globals.ball.global_position.y > collider.shape.get_rect().size.y/2):
			normal = Vector2(0, -1)
			print("bottom wall bounce")
			
		var force = -2 * normal * Globals.ball.velocity.dot(normal)
		Globals.apply_ball_force(force)
