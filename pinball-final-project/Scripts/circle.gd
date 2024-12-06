extends CharacterBody2D

const RESTITUTION:float = -1.9
const SHAKE_STRENGTH = 0.025

@onready var area:Area2D = $Area2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body == Globals.ball):
		var normal = Vector2.ZERO
		
		normal = (Globals.ball.global_position - global_position).normalized()
		var force = 1.1 * RESTITUTION * normal * Globals.ball.velocity.dot(normal)
		Globals.apply_ball_force(force)
		Globals.add_points(10)
		Globals.camera.apply_shake(SHAKE_STRENGTH * Globals.ball.velocity.length(), Globals.SHAKE_FADE)
