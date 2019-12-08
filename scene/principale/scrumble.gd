extends Button

signal scrumble

func _process(delta):
	if is_pressed() and $Timer.time_left == 0:
		$Timer.start()
		randomize()
		emit_signal("scrumble")