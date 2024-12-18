extends CharacterBody2D

@export var big_circle:bool = false

@onready var audio1 = $AudioStreamPlayer
@onready var audio2 = $AudioStreamPlayer2
@onready var audio3 = $AudioStreamPlayer3
@onready var audio4 = $AudioStreamPlayer4
@onready var audio5 = $AudioStreamPlayer5

const RESTITUTION:float = -1.9
const SHAKE_STRENGTH = 0.025

@onready var area:Area2D = $Area2D

func _ready():
	if(big_circle):
		$Sprite1.visible = false
		$Sprite2.visible = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body == Globals.ball):
		var normal = Vector2.ZERO
		
		normal = (Globals.ball.global_position - global_position).normalized()
		var force = (RESTITUTION * Globals.ball.MASS *(Globals.ball.velocity.dot(normal)) + (Globals.ball.MASS * 50)) * normal
		var J = force/ Globals.ball.MASS
		Globals.apply_ball_force(J)
		Globals.add_points(10)
		Globals.camera.apply_shake(SHAKE_STRENGTH * Globals.ball.velocity.length(), Globals.SHAKE_FADE)
		if(!audio1.playing):
			audio1.play()
		elif(!audio2.playing):
			audio2.play()
		elif(!audio3.playing):
			audio3.play()
		elif(!audio4.playing):
			audio4.play()
		elif(!audio5.playing):
			audio5.play()
		
