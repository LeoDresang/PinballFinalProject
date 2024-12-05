extends CharacterBody2D

@export var FLIPPER_CD:float = 0.3
@export var SWING_TIME:float = 0.1
@export var MASS:float = 1

@export var left_flipper:bool = false

@onready var sprite = $Sprite2D
@onready var collider = $CollisionShape2D

var flipper_on_cd:bool = false

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
