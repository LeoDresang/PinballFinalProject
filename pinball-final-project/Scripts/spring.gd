extends CharacterBody2D

const COMPRESSION_AMOUNT:float = 0.5

@export var SPRING_CONSTANT:float = 1

var RELAXED_LENGTH:float

var x_random:float = 0
var rng = RandomNumberGenerator.new()

@onready var sprite = $Sprite2D
@onready var collider = $CollisionShape2D

var spring_used:bool = false

func _ready():
	RELAXED_LENGTH = scale.y

func _process(delta: float) -> void:
	
	if(!spring_used):
		if(Input.is_action_just_released("Charge_Spring")):
			spring_used = true
			x_random = rng.randf_range(400.0, 1200.0)
			if randi_range(0,1) == 1:
				x_random = -x_random
			var force = Vector2(x_random, -SPRING_CONSTANT * (RELAXED_LENGTH - scale.y))
			Globals.apply_ball_force(force)
			visible = false
			collider.set_deferred("disabled", true)
		
		if(Input.is_action_pressed("Charge_Spring")):
			if(scale.y > 0.5):
				scale.y -= COMPRESSION_AMOUNT * delta
				position.y += (COMPRESSION_AMOUNT * delta) * 80
