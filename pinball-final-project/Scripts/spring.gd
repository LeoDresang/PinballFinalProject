extends CharacterBody2D

const COMPRESSION_AMOUNT:float = 0.5

@export var SPRING_CONSTANT:float = 1
@export var MASS:float = 1

var RELAXED_LENGTH:float

@onready var sprite = $Sprite2D
@onready var collider = $CollisionShape2D

var spring_used:bool = false

func _ready():
	RELAXED_LENGTH = scale.y

func _process(delta: float) -> void:
	
	if(Input.is_action_just_released("Charge_Spring")):
		spring_used = true
	
	if(!spring_used):
		if(Input.is_action_pressed("Charge_Spring")):
			if(scale.y > 0.5):
				scale.y -= COMPRESSION_AMOUNT * delta
				position.y += (COMPRESSION_AMOUNT * delta) * 80
