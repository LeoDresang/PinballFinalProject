extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Globals.points_label != self):
		Globals.points_label = self

func update_points_display():
	text = "POINTS: " + str(Globals.points)
