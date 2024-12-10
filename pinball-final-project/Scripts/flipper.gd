extends CharacterBody2D

@export var FLIPPER_CD:float = 0.6
@export var SWING_TIME:float = 0.2
@export var MASS:float = 1

const RESTITUTION:float = -1.9
const SHAKE_STRENGTH = 0.025

@export var left_flipper:bool = false

@onready var sprite = $Sprite2D

var flipper_on_cd:bool = false

var center_of_mass:Vector2 = Vector2.ZERO

var collision_dot := preload("uid://mp6lcskmi5mw")

var omega:float = 0

func ready()->void:
	if(left_flipper):
		rotation_degrees = 30
	else:
		rotation_degrees = -210
	
func _process(delta:float)->void:
	if(Globals.flipper_mass != MASS):
		Globals.flipper_mass = MASS
	
	
	if(!flipper_on_cd):
		if (left_flipper):
			if(Input.is_action_just_pressed("Left_Flipper")):
				start_flipper_cd(true)
				omega = 6.98 / 2
		else:
			if(Input.is_action_just_pressed("Right_Flipper")):
				start_flipper_cd(false)
				omega = 6.98 / 2

func start_flipper_cd(left:bool)->void:
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
	if(left):
		tween.tween_property(self, "rotation_degrees", -30, SWING_TIME)
	else:
		tween.tween_property(self, "rotation_degrees", -150, SWING_TIME)
	flipper_on_cd = true
	await get_tree().create_timer(SWING_TIME).timeout
	sprite.modulate = Color(0.939, 0, 0.09, 1)
	tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
	omega = -6.98 / 6
	if(left):
		tween.tween_property(self, "rotation_degrees", 30, FLIPPER_CD)
	else:
		tween.tween_property(self, "rotation_degrees", -210, FLIPPER_CD)
	await get_tree().create_timer(FLIPPER_CD).timeout
	flipper_on_cd = false
	omega = 0
	sprite.modulate = Color(1, 1, 1, 1)


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
	#if(body == Globals.ball):
		#var collision_point = body.collider.get_global_position()  
		#print("Collision at:", collision_point) 
		#
		#var red_dot1 = collision_dot.instantiate()
		#red_dot1.set_property(collision_point)
		#get_tree().current_scene.add_child(red_dot1)
			
		
		##These are points.
		#center_of_mass = sprite.global_position
		#var ball_pos:Vector2 = Globals.ball.global_position
		#var point_of_collision:Vector2 = Vector2.ZERO
		#
		##These are side lengths.
		#var a:float = Globals.ball_radius
		#var c:float = center_of_mass.distance_to(ball_pos)
		#var b:float = sqrt((c*c) + (a*a))
		#
		#var coll_p_1 = Vector2.ZERO
		#var coll_p_2 = Vector2.ZERO
		#
		## Intermediate values for the linear equation
		#var p = ball_pos.x - center_of_mass.x
		#var q = ball_pos.y - center_of_mass.y
		#var r = 0.5 * (b * b - a * a + ball_pos.length_squared() - center_of_mass.length_squared())
		#
		## Check for q == 0 (edge case where the line is vertical)
		#if q == 0:
		## Special handling if q == 0 (avoid division by zero)
			#var x1 = r / p
			#var x2 = r / p
			#var y1 = center_of_mass.y + sqrt(b * b - (x1 - center_of_mass.x) ** 2)
			#var y2 = center_of_mass.y - sqrt(b * b - (x2 - center_of_mass.x) ** 2)
			#coll_p_1 = Vector2(x1, y1)
			#coll_p_2 = Vector2(x2, y2)
		#
		## Substitute y = (r - px) / q into the circle equation
		#var A = 1 + (p * p) / (q * q)
		#var B = -2 * center_of_mass.x + (2 * p * (r / q - center_of_mass.y)) / q
		#var C = center_of_mass.x * center_of_mass.x + (r / q - center_of_mass.y) ** 2 - b * b
		#
		## Compute the discriminant
		#var discriminant = B * B - 4 * A * C
		#print("A:", A, "B:", B, "C:", C, "Discriminant:", discriminant)
		#
		## Check discriminant for solutions
		#if discriminant < 0:
			#return  # No solutions (circles don't intersect)
		#elif discriminant == 0:
			## One solution (tangential circles)
			#var x = -B / (2 * A)
			#var y = (r - p * x) / q
			#coll_p_1 = Vector2(x, y)
		#else:
			## Two solutions (normal intersection)
			#var x1 = (-B + sqrt(discriminant)) / (2 * A)
			#var x2 = (-B - sqrt(discriminant)) / (2 * A)
			#var y1 = (r - p * x1) / q
			#var y2 = (r - p * x2) / q
			#coll_p_1 = Vector2(x1, y1)
			#coll_p_2 = Vector2(x2, y2)
			
		#var red_dot1 = collision_dot.instantiate()
		#red_dot1.set_property(coll_p_1)
		#get_tree().current_scene.add_child(red_dot1)
			#
		#var red_dot2 = collision_dot.instantiate()
		#red_dot2.set_property(coll_p_2)
		#get_tree().current_scene.add_child(red_dot2)
			
		#if(coll_p_1):
			#pass
			#
			#
		#var force = Vector2.ZERO
		#Globals.apply_ball_force(force)
		#Globals.camera.apply_shake(SHAKE_STRENGTH * Globals.ball.velocity.length(), Globals.SHAKE_FADE)
	
	
	
	
	
	
	
	
	
	
	
	
	#if(body == Globals.ball):
		#print("ball detected")
		#center_of_mass = sprite.global_position
		#var r_vector = Globals.ball.position - center_of_mass
		#var up_direction = Vector2(cos(global_rotation_degrees), sin(global_rotation_degrees))
		#up_direction = up_direction.normalized()
		#
		#var oy = Globals.ball_radius + (0.5 * 1080 * sprite.scale.y) - abs(r_vector.dot(up_direction))
		#
		#if(oy <= 0):
			#print("top collision")
		
