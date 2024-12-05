extends Node

const SHAKE_FADE:float = 3.5

var camera:Camera2D = null
var ball:CharacterBody2D = null
var points_label:Label = null
var points:int = 0


func apply_ball_force(force:Vector2):
	ball.velocity +=  force

func add_points(plus_points:int):
	points += plus_points
	points_label.update_points_display()

func _process(delta:float):
	if(Input.is_action_just_pressed("Reload")):
		reset_game() 

func reset_game():
	points = 0
	get_tree().reload_current_scene()
