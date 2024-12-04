extends Node

var ball:CharacterBody2D = null

func apply_ball_force(force:Vector2):
	ball.velocity += force

func _process(delta:float):
	if(Input.is_action_just_pressed("Reload")):
		get_tree().reload_current_scene()
