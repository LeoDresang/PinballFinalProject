extends Camera2D

var shake_fade:float = 3.5
var shake_strength:float = 0.0
var rng = RandomNumberGenerator.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Globals.camera != self):
		Globals.camera = self
	
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, -0.01, shake_fade * delta)
		position.x = randomOffset()
		position.y = randomOffset()
	else:
		position.x = 0
		position.y = 0

func apply_shake(strength: float, fade:float):
	shake_strength = strength / 2
	shake_fade = fade

func randomOffset() -> float:
	return rng.randf_range(-shake_strength, shake_strength)
