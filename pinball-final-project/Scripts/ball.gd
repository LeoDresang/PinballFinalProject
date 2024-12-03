extends CharacterBody2D

@export var GRAVITY = 9.81
@export var MASS:float = 100

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready()-> void:
	await get_tree().get_root().ready
	Globals.ball = self

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * MASS * delta
		
	move_and_slide()
