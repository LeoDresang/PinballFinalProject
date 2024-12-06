extends CharacterBody2D

@export var FLIPPER_CD:float = 0.3
@export var SWING_TIME:float = 0.1
@export var MASS:float = 1

@export var left_flipper:bool = false

@onready var sprite = $Sprite2D
@onready var collider = $CollisionShape2D
@onready var com = $COM_marker

var flipper_on_cd:bool = false

var center_of_mass:Vector2 = Vector2.ZERO

func ready()->void:
	if(left_flipper):
		rotation_degrees = 30
	else:
		rotation_degrees = -210
	
func _process(delta:float)->void:
	if(!flipper_on_cd):
		if (left_flipper):
			if(Input.is_action_just_pressed("Left_Flipper")):
				start_flipper_cd(true)
		else:
			if(Input.is_action_just_pressed("Right_Flipper")):
				start_flipper_cd(false)

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
	if(left):
		tween.tween_property(self, "rotation_degrees", 30, FLIPPER_CD)
	else:
		tween.tween_property(self, "rotation_degrees", -210, FLIPPER_CD)
	await get_tree().create_timer(FLIPPER_CD).timeout
	flipper_on_cd = false
	sprite.modulate = Color(1, 1, 1, 1)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body == Globals.ball):
		print("ball detected")
		center_of_mass = sprite.global_position
		var r_vector = Globals.ball.position - center_of_mass
		var up_direction = Vector2(cos(global_rotation_degrees), cos(global_rotation_degrees))
		up_direction = up_direction.normalized()
		
		var oy = Globals.ball_radius + (0.5 * 1080 * sprite.scale.y) - abs(r_vector.dot(up_direction))
		
		if(left_flipper && oy <= 0):
			print("top collision")
		if(!left_flipper && oy >= 0):
			print("top collision")
		
