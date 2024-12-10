extends CharacterBody2D

const RESTITUTION: float = -1.3

@onready var left:Area2D = $LeftArea
@onready var right:Area2D = $LeftArea
@onready var bottom:Area2D = $BottomArea
@onready var top:Area2D = $TopArea

func _on_left_area_body_entered(body: Node2D) -> void:
	if(body == Globals.ball):
		var normal = Vector2.ZERO
		
		normal += Vector2(1,0)			
		normal = normal.normalized()
		
		var force = RESTITUTION * normal * Globals.ball.velocity.dot(normal)
		Globals.apply_ball_force(force)


func _on_right_area_body_entered(body: Node2D) -> void:
	if(body == Globals.ball):
		var normal = Vector2.ZERO
		
		normal += Vector2(-1,0)			
		normal = normal.normalized()
		
		var force = RESTITUTION * normal * Globals.ball.velocity.dot(normal)
		Globals.apply_ball_force(force)


func _on_bottom_area_body_entered(body: Node2D) -> void:
	if(body == Globals.ball):
		Globals.reset_game()


func _on_top_area_body_entered(body: Node2D) -> void:
	if(body == Globals.ball):
		var normal = Vector2.ZERO
		
		normal += Vector2(0,1)
			
		normal = normal.normalized()
		
		var force = RESTITUTION * normal * Globals.ball.velocity.dot(normal)
		Globals.apply_ball_force(force)
