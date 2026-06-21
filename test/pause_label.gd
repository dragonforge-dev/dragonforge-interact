extends Label


func _process(_delta: float) -> void:
	if get_tree().paused:
		text = "Press 'P' to Unpause"
	else:
		text = "Press 'P' to Pause and Free Mouse"
