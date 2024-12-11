extends CharacterBody2D

@export var GRAVITY:float = 9.81
@export var MASS:float = 800

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
		if(get_slide_collision(0).get_collider().name == "Flipper" or get_slide_collision(0).get_collider().name == "Flipper2" or get_slide_collision(0).get_collider().name == "Flipper3" or get_slide_collision(0).get_collider().name == "Flipper4"):
			var C_position = get_slide_collision(0).get_position()
			
			#var red_dot1 = collision_dot.instantiate()
			#red_dot1.set_property(C_position)
			#get_tree().current_scene.add_child(red_dot1)
			 
			var v =  Vector3(previous_velocity.x, previous_velocity.y, 0) - (Vector3(0,0, get_slide_collision(0).get_collider().omega).cross(Vector3(C_position.x, C_position.y, 0) - Vector3(get_slide_collision(0).get_collider().global_position.x, get_slide_collision(0).get_collider().global_position.y, 0)))
			var vi = Vector2(v.x, v.y)
			var normal = (Globals.ball.global_position - C_position).normalized()
			var J = RESTITUTION * MASS * (vi.dot(normal)) * normal
			var force = J / MASS
			
			get_slide_collision(0).get_collider().set_collision_layer_value(1, false)
			get_slide_collision(0).get_collider().set_collision_mask_value(1, false)
			
			reset_collision_on_flipper(get_slide_collision(0).get_collider())
			
			Globals.apply_ball_force(force)
			Globals.camera.apply_shake(SHAKE_STRENGTH * Globals.ball.velocity.length(), Globals.SHAKE_FADE)

func reset_collision_on_flipper(flipper):
	await get_tree().create_timer(0.00416666666).timeout
	flipper.set_collision_layer_value(1, true)
	flipper.set_collision_mask_value(1, true)
