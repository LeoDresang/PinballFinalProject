extends CharacterBody2D

@export var GRAVITY:float = 9.81
@export var MASS:float = 100

const RESTITUTION:float = -1
const SHAKE_STRENGTH = 0.025

@onready var collider:CollisionShape2D = $CollisionShape2D

var collision_dot := preload("uid://mp6lcskmi5mw")

var previous_velocity:Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	if(Globals.ball != self):
		Globals.ball = self
	if(Globals.ball_radius != collider.shape.radius):
		Globals.ball_radius = collider.shape.radius
		
func _physics_process(delta: float) -> void:
	previous_velocity = velocity
	if not is_on_floor():
		velocity.y += GRAVITY * MASS * delta
	move_and_slide()
	
	#hitting flipper calculations
	if(get_slide_collision(0)):
		if(get_slide_collision(0).get_collider().name == "Flipper" or get_slide_collision(0).get_collider().name == "Flipper2"):
			var C_position = get_slide_collision(0).get_position()
			print(C_position)
			
			var red_dot1 = collision_dot.instantiate()
			red_dot1.set_property(C_position)
			get_tree().current_scene.add_child(red_dot1)
			
			var force = Vector2.ZERO
			var normal = (global_position - C_position).normalized()
			Globals.apply_ball_force(RESTITUTION * normal * previous_velocity.dot(normal))
			Globals.camera.apply_shake(SHAKE_STRENGTH * Globals.ball.velocity.length(), Globals.SHAKE_FADE)
