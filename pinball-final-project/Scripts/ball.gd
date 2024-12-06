extends CharacterBody2D

@export var GRAVITY = 9.81
@export var MASS:float = 100

@onready var collider:CollisionShape2D = $CollisionShape2D

func _process(delta: float) -> void:
	if(Globals.ball != self):
		Globals.ball = self
	if(Globals.ball_radius != collider.shape.radius):
		Globals.ball_radius = collider.shape.radius
		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * MASS * delta
	move_and_slide()
